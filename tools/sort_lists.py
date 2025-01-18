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
import idna  # For IDN support

VERSION = "0.2b9"  # PEP 440 versioning format for beta release

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
    # Convert IDN to ASCII
    try:
        domain = idna.encode(domain).decode('ascii')
    except idna.IDNAError:
        return False

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

def sort_file_alphanum(file_path, valid_tlds):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines, key=lambda x: x.strip().split(',')[0] if ',' in x else '')  # Sort FQDNs

    invalid_entries = []
    for line in lines:
        domain_part = line.strip().split(',')[0]
        if domain_part != "domain" and not (is_valid_domain(domain_part, valid_tlds) or domain_part in valid_tlds):
            invalid_entries.append(line)

    if invalid_entries:
        print(f"Invalid DNS entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())

    with open(file_path, 'w') as file:
        if header:
            file.write(header)
        file.writelines(lines)
        file.write("")  # Ensure no additional newline

def sort_file_tld(file_path, valid_tlds):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines, key=lambda x: x.strip())  # Sort TLDs

    invalid_entries = []
    for line in lines:
        domain_part = line.strip().split(',')[0]
        if domain_part != "domain" and not (is_valid_domain(domain_part, valid_tlds) or domain_part in valid_tlds):
            invalid_entries.append(line)

    if invalid_entries:
        print(f"Invalid TLD entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())

    with open(file_path, 'w') as file:
        if header:
            file.write(header)
        file.writelines(lines)
        file.write("")  # Ensure no additional newline

def sort_file_rpz_nsdname(file_path, valid_tlds):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines, key=lambda x: x.strip().split(',')[0] if ',' in x else '')  # Sort FQDNs

    invalid_entries = []
    for line in lines:
        domain_part = line.strip().split(',')[0]
        if domain_part != "domain" and not (is_valid_domain(domain_part, valid_tlds) or domain_part in valid_tlds):
            invalid_entries.append(line)

    if invalid_entries:
        print(f"Invalid entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())

    with open(file_path, 'w') as file:
        if header:
            file.write(header)
        file.writelines(lines)
        file.write("")  # Ensure no additional newline

def sort_file_hierarchical(file_path, valid_tlds):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines, key=lambda x: (x.strip().split(',')[0], x.strip().split(',')[1] if ',' in x and len(x.strip().split(',')) > 1 else ''))  # Sort FQDNs and CIDR

    invalid_entries = []
    for line in lines:
        parts = line.strip().split(',')
        if len(parts) > 1:
            domain, ip_arpa = parts[0], parts[1]
            if domain != "domain" and (not is_valid_domain(domain, valid_tlds) and not is_valid_ip_arpa(ip_arpa)):
                invalid_entries.append(line)
        else:
            domain = parts[0]
            if domain != "domain" and not is_valid_domain(domain, valid_tlds):
                invalid_entries.append(line)

    if invalid_entries:
        print(f"Invalid DNS or IP entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())

    with open(file_path, 'w') as file:
        if header:
            file.write(header)
        file.writelines(lines)
        file.write("")  # Ensure no additional newline

def sort_file_onion(file_path, valid_tlds):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines, key=lambda x: x.strip().split(',')[0] if ',' in x else '')  # Sort FQDNs

    invalid_entries = [line for line in lines if line.strip().split(',')[0] != "domain" and not line.strip().endswith('.onion')]
    if invalid_entries:
        print(f"Invalid .onion entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())

    with open(file_path, 'w') as file:
        if header:
            file.write(header)
        file.writelines(lines)
        file.write("")  # Ensure no additional newline

def sort_file_ip(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines)  # Sort IPs directly

    with open(file_path, 'w') as file:
        if header:
            file.write(header)
        file.writelines(lines)
        file.write("")  # Ensure no additional newline

def find_tor_browser():
    home_dir = os.path.expanduser("~")
    for root, dirs, files in os.walk(home_dir):
        if 'start-tor-browser' in files:
            return os.path.join(root, 'start-tor-browser')
    return None

def handle_donate():
    tor_browser = find_tor_browser()
    if tor_browser:
        try:
            webbrowser.get(tor_browser).open('https://www.mypdns.org/donate')
            return
        except webbrowser.Error:
            pass
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
    parser.add_argument('-x', '--proxy', type=str, default=None, help="Specify a proxy to use for downloading external files")
    parser.add_argument('--no-proxy', action='store_true', help="Disable the default proxy setting")
    parser.add_argument('-d', '-s', '--donate', '--sponsor', action='store_true', help="Open the donate link in default browser")
    args = parser.parse_args()

    proxy = args.proxy
    if not args.no_proxy and not proxy and "GITHUB_ACTIONS" not in os.environ:
        proxy = "socks5h://localhost:9050"

    if args.donate:
        handle_donate()
        sys.exit(0)

    valid_tlds = fetch_valid_tlds(proxy)

    alphanum_filenames = ["wildcard.csv", "mobile.csv", "snuff.csv"]
    tld_filenames = ["tld.csv"]
    rpz_nsdname_filenames = ["wildcard.rpz-nsdname.csv", "domains.rpz-nsdname.csv"]
    hierarchical_filenames = ["domains.csv", "onions.csv"]
    ip_filenames = ["rpz-ip.csv", "ip4.csv", "rpz-client-ip.csv", "rpz-drop.csv", "ip6.csv"]

    modified_files = get_modified_files_in_last_commit()
    target_files_alphanum = find_files_by_name("source", alphanum_filenames)
    target_files_tld = find_files_by_name("source", tld_filenames)
    target_files_rpz_nsdname = find_files_by_name("source", rpz_nsdname_filenames)
    target_files_hierarchical = find_files_by_name("source", hierarchical_filenames)
    target_files_onion = find_files_by_name("source", ["onions.csv"])
    target_files_ip = find_files_by_name("source", ip_filenames)

    for file in target_files_alphanum:
        if args.force or any(file.endswith(modified) for modified in modified_files):
            sort_file_alphanum(file, valid_tlds)

    for file in target_files_tld:
        if args.force or any(file.endswith(modified) for modified in modified_files):
            sort_file_tld(file, valid_tlds)

    for file in target_files_rpz_nsdname:
        if args.force or any(file.endswith(modified) for modified in modified_files):
            sort_file_rpz_nsdname(file, valid_tlds)

    for file in target_files_hierarchical:
        if args.force or any(file.endswith(modified) for modified in modified_files):
            sort_file_hierarchical(file, valid_tlds)

    for file in target_files_onion:
        if args.force or any(file.endswith(modified) for modified in modified_files):
            sort_file_onion(file, valid_tlds)

    for file in target_files_ip:
        if args.force or any(file.endswith(modified) for modified in modified_files):
            sort_file_ip(file)

    print("Please consider sponsoring My Privacy DNS at https://www.mypdns.org/donate")

if __name__ == "__main__":
    main()
