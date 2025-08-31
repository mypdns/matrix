#!/usr/bin/env python3

#  <Program Name>: <Brief Description of the Program>
#  Copyright (C) 2025. @spirillen, My Privacy DNS - Matrix
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as
#  published by the Free Software Foundation, either version 3 of the
#  License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU Affero General Public License for more details.
#
#  You should have received a copy of the GNU Affero General Public License
#  along with this program. If not, see <https://www.gnu.org/licenses/>.

import os
import sys
import argparse
import webbrowser
import re
import ipaddress
from subprocess import check_output, CalledProcessError
import requests
import idna

VERSION = "0.0.2b26"  # First stable release version


def find_files_by_name(directory, filenames):
    matches = []
    for root, _, files in os.walk(directory):
        for filename in files:
            if filename in filenames:
                matches.append(os.path.join(root, filename))
    return matches


def get_modified_files_in_last_commit():
    try:
        output = check_output(["git", "diff", "--name-only", "HEAD~1",
                               "HEAD"]).decode().splitlines()
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

    return set(
        tld.lower() for tld in remote_lines if not tld.startswith("#")).union(
        {"onion"})


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
    try:
        # Attempt to encode to IDNA
        domain_idna = idna.encode(domain).decode('utf-8')
        return domain_idna
    except Exception as e:
        print(f"IDNA encoding error for domain {domain}: {e}")
        return None


def test_domain_connectivity(domain, proxy):
    proxies = {"http": proxy, "https": proxy} if proxy else None
    try:
        response = requests.get(f"http://{domain}", timeout=5, proxies=proxies)
        if response.status_code == 200:
            return True
    except requests.RequestException as e:
        print(f"Connectivity test error for domain {domain}: {e}")
    return False


def dns_lookup(domain):
    try:
        response = requests.get(
            f"https://dns10.quad9.net/dns-query?name={domain}&type=A",
            headers={"accept": "application/dns-json"})
        if response.status_code == 200:
            data = response.json()
            if "Answer" in data:
                return True
    except requests.RequestException as e:
        print(f"DNS lookup error for domain {domain}: {e}")
    return False


def sort_file_alphanum(file_path, valid_tlds, proxy):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line.rstrip('\n') for line in lines[1:] if
             line.strip()]  # Remove empty lines and skip header

    lines = sorted(lines, key=lambda x: x.strip().split(',')[
        0] if ',' in x else '')  # Sort FQDNs

    invalid_entries = []
    for line in lines:
        domain_part = line.strip().split(',')[0]
        if domain_part != "domain" and not (is_valid_domain(domain_part,
                                                            valid_tlds) or domain_part in valid_tlds):
            domain_idna = validate_idna_domain(domain_part)
            if domain_idna is None or not test_domain_connectivity(domain_idna,
                                                                   proxy) or not dns_lookup(
                domain_idna):
                invalid_entries.append(line)

    # Continue processing even if there are invalid entries
    if invalid_entries:
        print(f"Invalid DNS entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())

    with open(file_path, 'w') as file:
        if header:
            file.write(header)
        file.write('\n'.join(lines))
        file.write('\n')  # Ensure a newline at the end of the file


def sort_file_tld(file_path, valid_tlds, proxy):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if
             line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines, key=lambda x: x.strip())  # Sort TLDs

    invalid_entries = []
    for line in lines:
        domain_part = line.strip().split(',')[0]
        if domain_part != "domain" and not (is_valid_domain(domain_part,
                                                            valid_tlds) or domain_part in valid_tlds):
            domain_idna = validate_idna_domain(domain_part)
            if domain_idna is None or not test_domain_connectivity(domain_idna,
                                                                   proxy) or not dns_lookup(
                domain_idna):
                invalid_entries.append(line)

    # Continue processing even if there are invalid entries
    if invalid_entries:
        print(f"Invalid TLD entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())


def sort_file_rpz_nsdname(file_path, valid_tlds, proxy):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if
             line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines, key=lambda x: x.strip().split(',')[
        0] if ',' in x else '')  # Sort FQDNs

    invalid_entries = []
    for line in lines:
        domain_part = line.strip().split(',')[0]
        if domain_part != "domain" and not (is_valid_domain(domain_part,
                                                            valid_tlds) or domain_part in valid_tlds):
            domain_idna = validate_idna_domain(domain_part)
            if domain_idna is None or not test_domain_connectivity(domain_idna,
                                                                   proxy) or not dns_lookup(
                domain_idna):
                invalid_entries.append(line)

    # Continue processing even if there are invalid entries
    if invalid_entries:
        print(f"Invalid entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())


def sort_file_hierarchical(file_path, valid_tlds, proxy):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if
             line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines, key=lambda x: (x.strip().split(',')[0],
                                         x.strip().split(',')[
                                             1] if ',' in x and len(
                                             x.strip().split(
                                                 ',')) > 1 else ''))  # Sort FQDNs and CIDR

    invalid_entries = []
    for line in lines:
        parts = line.strip().split(',')
        if len(parts) > 1:
            domain, ip_arpa = parts[0], parts[1]
            if domain != "domain" and (not is_valid_domain(domain,
                                                           valid_tlds) and not is_valid_ip_arpa(
                ip_arpa)):
                domain_idna = validate_idna_domain(domain)
                if domain_idna is None or not test_domain_connectivity(
                    domain_idna, proxy) or not dns_lookup(domain_idna):
                    invalid_entries.append(line)
        else:
            domain = parts[0]
            if domain != "domain" and not is_valid_domain(domain, valid_tlds):
                domain_idna = validate_idna_domain(domain)
                if domain_idna is None or not test_domain_connectivity(
                    domain_idna, proxy) or not dns_lookup(domain_idna):
                    invalid_entries.append(line)

    # Continue processing even if there are invalid entries
    if invalid_entries:
        print(f"Invalid DNS or IP entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())


def sort_file_onion(file_path, valid_tlds):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if
             line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines, key=lambda x: x.strip().split(',')[
        0] if ',' in x else '')  # Sort FQDNs

    invalid_entries = [line for line in lines if line.strip().split(',')[
        0] != "domain" and not line.strip().endswith('.onion')]
    # Continue processing even if there are invalid entries
    if invalid_entries:
        print(f"Invalid .onion entries in {file_path}:")
        for entry in invalid_entries:
            print(entry.strip())


def sort_file_ip(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    lines = remove_duplicates(lines)  # Remove duplicate lines

    header = lines[0] if lines else ""
    lines = [line for line in lines[1:] if
             line.strip()]  # Remove empty lines and skip header if present
    lines = sorted(lines)  # Sort IPs directly

    with open(file_path, 'w') as file:
        if header:
            file.write(header)
        file.writelines(lines)
        file.write("")  # Ensure no additional newline


def commit_changes():
    try:
        check_output(["git", "add", "."])
        check_output(["git", "commit", "-m", "Automated sort and commit"])
        print("Changes committed successfully.")
    except CalledProcessError as e:
        print(f"Commit failed: {e}")


def main():
    parser = argparse.ArgumentParser(description="Sort and clean CSV files.")
    parser.add_argument('-v', '--version', action='version',
                        version=f"%(prog)s {VERSION}")
    parser.add_argument('-f', '--force', action='store_true',
                        help="Force run on all files, altered or not")
    parser.add_argument('-x', '--proxy', type=str, default=None,
                        help="Specify a proxy to use for downloading external files")
    parser.add_argument('--no-proxy', action='store_true',
                        help="Disable the default proxy setting")
    parser.add_argument('-d', '-s', '--donate', '--sponsor',
                        action='store_true',
                        help="Open the donate link in default browser")
    args = parser.parse_args()

    proxy = args.proxy
    if not args.no_proxy and not proxy and "GITHUB_ACTIONS" not in os.environ:
        proxy = "socks5h://localhost:9050"

    if args.donate:
        webbrowser.open('https://www.mypdns.org/donate')
        sys.exit(0)

    valid_tlds = fetch_valid_tlds(proxy)

    alphanum_filenames = ["wildcard.csv", "mobile.csv", "snuff.csv"]
    tld_filenames = ["tld.csv"]
    rpz_nsdname_filenames = ["wildcard.rpz-nsdname.csv",
                             "domains.rpz-nsdname.csv"]
    hierarchical_filenames = ["domains.csv", "onions.csv"]
    ip_filenames = ["rpz-ip.csv", "ip4.csv", "rpz-client-ip.csv",
                    "rpz-drop.csv", "ip6.csv"]

    modified_files = get_modified_files_in_last_commit()
    target_files_alphanum = find_files_by_name("source", alphanum_filenames)
    target_files_tld = find_files_by_name("source", tld_filenames)
    target_files_rpz_nsdname = find_files_by_name("source",
                                                  rpz_nsdname_filenames)
    target_files_hierarchical = find_files_by_name("source",
                                                   hierarchical_filenames)
    target_files_onion = find_files_by_name("source", ["onions.csv"])
    target_files_ip = find_files_by_name("source", ip_filenames)

    for file in target_files_alphanum:
        if args.force or any(
            file.endswith(modified) for modified in modified_files):
            sort_file_alphanum(file, valid_tlds, proxy)

    for file in target_files_tld:
        if args.force or any(
            file.endswith(modified) for modified in modified_files):
            sort_file_tld(file, valid_tlds, proxy)

    for file in target_files_rpz_nsdname:
        if args.force or any(
            file.endswith(modified) for modified in modified_files):
            sort_file_rpz_nsdname(file, valid_tlds, proxy)

    for file in target_files_hierarchical:
        if args.force or any(
            file.endswith(modified) for modified in modified_files):
            sort_file_hierarchical(file, valid_tlds, proxy)

    for file in target_files_onion:
        if args.force or any(
            file.endswith(modified) for modified in modified_files):
            sort_file_onion(file, valid_tlds)

    for file in target_files_ip:
        if args.force or any(
            file.endswith(modified) for modified in modified_files):
            sort_file_ip(file)

    # Commit the changes
    commit_changes()

    print(
        "Please consider sponsoring My Privacy DNS at https://www.mypdns.org/donate")


if __name__ == "__main__":
    main()
