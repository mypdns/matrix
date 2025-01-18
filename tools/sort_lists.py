#!/usr/bin/env python3

import os
import sys
import csv
import argparse
import webbrowser
import re
import ipaddress
from subprocess import check_output
import requests

VERSION = "0.2b1"  # PEP 440 versioning format for beta release

def find_files_by_name(directory, filenames):
    matches = []
    for root, _, files in os.walk(directory):
        for filename in files:
            if filename in filenames:
                matches.append(os.path.join(root, filename))
    return matches

def get_modified_files_in_last_commit():
    output = check_output(["git", "diff", "--name-only", "HEAD~1", "HEAD"]).decode().splitlines()
    return output

def fetch_valid_tlds():
    response = requests.get("https://data.iana.org/TLD/tlds-alpha-by-domain.txt")
    tlds = response.text.splitlines()
    return set(tld.lower() for tld in tlds if not tld.startswith("#"))

VALID_TLDS = fetch_valid_tlds()

def is_valid_domain(domain):
    if "." in domain:
        tld = domain.split(".")[-1].lower()
        if tld not in VALID_TLDS:
            return False
    regex = re.compile(
        r'^(?:[a-zA-Z0-9]'  # First character of the domain
        r'(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)'  # Sub domain + hostname
        r'+[a-zA-Z]{2,6}$'  # First level TLD
    )
    return re.match(regex, domain) is not None

def is_valid_ip_arpa(ip_arpa):
    try:
        ip = ip_arpa.split('.')[0]
        ipaddress.ip_network(ip)
        return True
    except ValueError:
        return False

def sort_file_alphanum(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    header = "domain,"
    if not lines or lines[0].strip() != header:
        lines.insert(0, header + "\n")

    lines = [line for line in lines if line.strip()]  # Remove empty lines
    lines = sorted(lines[1:], key=lambda x: x.strip().split(',')[0] if ',' in x else '')  # Sort FQDNs
    lines.insert(0, header + "\n")

    invalid_entries = [line for line in lines if not is_valid_domain(line.strip().split(',')[0])]
    if invalid_entries:
        print(f"Invalid DNS entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())

    with open(file_path, 'w') as file:
        file.writelines(lines)
        file.write("")  # Ensure no additional newline

def sort_file_hierarchical(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    header = "domain,"
    if not lines or lines[0].strip() != header:
        lines.insert(0, header + "\n")

    lines = [line for line in lines if line.strip()]  # Remove empty lines
    lines = sorted(lines[1:], key=lambda x: (x.strip().split(',')[0], x.strip().split(',')[1] if ',' in x and len(x.strip().split(',')) > 1 else ''))  # Sort FQDNs and CIDR
    lines.insert(0, header + "\n")

    invalid_entries = []
    for line in lines:
        parts = line.strip().split(',')
        if len(parts) > 1:
            domain, ip_arpa = parts[0], parts[1]
            if not is_valid_domain(domain) or not is_valid_ip_arpa(ip_arpa):
                invalid_entries.append(line)
        else:
            domain = parts[0]
            if not is_valid_domain(domain):
                invalid_entries.append(line)

    if invalid_entries:
        print(f"Invalid DNS or IP entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())

    with open(file_path, 'w') as file:
        file.writelines(lines)
        file.write("")  # Ensure no additional newline

def handle_donate():
    try:
        webbrowser.get('tor').open('https://www.mypdns.org/donate')
    except webbrowser.Error:
        try:
            webbrowser.get('firefox-esr').open('https://www.mypdns.org/donate')
        except webbrowser.Error:
            try:
                webbrowser.get('firefox').open('https://www.mypdns.org/donate')
            except webbrowser.Error:
                webbrowser.open('https://www.mypdns.org/donate')

def main():
    parser = argparse.ArgumentParser(description="Sort and clean CSV files.")
    parser.add_argument('-v', '--version', action='version', version=f"%(prog)s {VERSION}")
    parser.add_argument('-f', '--force', action='store_true', help="Force run on all files, altered or not")
    parser.add_argument('-d', '-s', '--donate', '--sponsor', action='store_true', help="Open the donate link in default browser")
    args = parser.parse_args()

    if args.donate:
        handle_donate()
        sys.exit(0)

    alphanum_filenames = ["tld.csv", "wildcard.csv", "wildcard.rpz-nsdname.csv", "domains.rpz-nsdname.csv", "mobile.csv", "snuff.csv"]
    hierarchical_filenames = ["domains.csv", "onions.csv", "rpz-ip.csv", "ip4.csv", "ip6.csv", "rpz-client-ip.csv", "rpz-drop.csv", "rpz-ip.csv", "hosts.csv"]

    modified_files = get_modified_files_in_last_commit()
    target_files_alphanum = find_files_by_name("source", alphanum_filenames)
    target_files_hierarchical = find_files_by_name("source", hierarchical_filenames)

    for file in target_files_alphanum:
        if args.force or any(file.endswith(modified) for modified in modified_files):
            sort_file_alphanum(file)

    for file in target_files_hierarchical:
        if args.force or any(file.endswith(modified) for modified in modified_files):
            sort_file_hierarchical(file)

    print("Please consider sponsoring My Privacy DNS at https://www.mypdns.org/donate")

if __name__ == "__main__":
    main()
