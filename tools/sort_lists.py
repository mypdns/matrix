#!/usr/bin/env python3

import os
import sys
import csv
import argparse
import webbrowser
import re
import ipaddress
from subprocess import check_output, CalledProcessError
import requests
import idna
import dns.resolver
import dns.query

VERSION = "0.2b20"  # Incremented beta version

def find_files_by_name(directory, filenames):
    matches = []
    for root, _, files in os.walk(directory):
        for filename in files:
            if filename in filenames:
                matches.append(os.path.join(root, filename))
    return matches

def get_modified_files_in_last_commit():
    try:
        output = check_output(["git", "diff", "--name-only", "HEAD~1", "HEAD"]).decode().splitlines()
    except CalledProcessError:
        # If there's only one commit, use `git ls-files` instead
        output = check_output(["git", "ls-files"]).decode().splitlines()
    return output

def fetch_valid_tlds(proxy):
    tlds_file = 'tools/tlds-alpha-by-domain.txt'
    url = "https://data.iana.org/TLD/tlds-alpha-by-domain.txt"

    # Check if the local file exists and read its version
    local_version = None
    if os.path.exists(tlds_file):
        with open(tlds_file, 'r') as file:
            for line in file:
                if line.startswith("# Version:"):
                    local_version = line.split()[2]
                    break

    # Fetch the remote file
    headers = {"User-Agent": "Mozilla/5.0"}
    proxies = {"http": proxy, "https": proxy} if proxy else None
    response = requests.get(url, headers=headers, proxies=proxies)
    remote_lines = response.text.splitlines()

    # Get the remote version
    remote_version = None
    for line in remote_lines:
        if line.startswith("# Version:"):
            remote_version = line.split()[2]
            break

    # If the versions differ or no local version, update the local file
    if local_version != remote_version:
        with open(tlds_file, 'w') as file:
            file.write(response.text)

    return set(tld.lower() for tld in remote_lines if not tld.startswith("#")).union({"onion"})

def is_valid_domain(domain, valid_tlds):
    if "." in domain:
        tld = domain.split(".")[-1].lower()
        if tld not in valid_tlds:
            return False
    regex = re.compile(
        r'^(?:[a-zA-Z0-9_]'  # First character of the domain or subdomain
        r'(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9_])?\.)'  # Sub domain + hostname
        r'+[a-zA-Z]{2,63}$'  # First level TLD
    )
    return re.match(regex, domain) is not None

def is_valid_ip_arpa(ip_arpa):
    # Skip validation for lines consisting only of numbers and dots
    if re.fullmatch(r'[\d.]+', ip_arpa):
        return True

    parts = ip_arpa.split('.')
    if len(parts) != 5:
        return False
    try:
        # Convert RPZ format to IP address and CIDR
        ip = '.'.join(parts[1:]) + '/' + parts[0]
        ipaddress.ip_network(ip)
        return True
    except ValueError:
        return False

def remove_duplicates(lines):
    seen = set()
    unique_lines = []
    for line in lines:
        if line not in seen:
            seen.add(line)
            unique_lines.append(line)
    return unique_lines

def validate_idna_domain(domain):
