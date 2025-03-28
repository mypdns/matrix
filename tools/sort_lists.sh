#!/usr/bin/env bash

#
# <Program Name>: <Brief Description of the Program>
# Copyright (C) 2025. My Privacy DNS
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#

## This script should be placed in pre-commit-hooks
# set -xe

# Run the command and capture its output
git_dir_output=$(git rev-parse --show-toplevel)
# Capture the exit status
git_dir_status=$?

# Check if the command was successful
if [ $git_dir_status -eq 0 ]; then
    export GIT_DIR="$git_dir_output"
    echo "GIT_DIR: $GIT_DIR"
else
    echo "Failed to get the Git directory. Status: $git_dir_status"
fi

if [ -d "$GIT_DIR" ]; then
    # shellcheck disable=SC2164
    cd "${GIT_DIR}"/source/

    ALPHABETICALLY=(
        "adware/tld.csv"
        "adware/wildcard.csv"
        "adware/wildcard.rpz-nsdname.csv"
        "alphabet/wildcard.csv"
        "alphabet/wildcard.rpz-nsdname.csv"
        "bait_sites/wildcard.csv"
        "coinblocker/wildcard.csv"
        "dns-servers/domains.rpz-nsdname.csv"
        "dns-servers/wildcard.rpz-nsdname.csv"
        "drugs/tld.csv"
        "drugs/wildcard.csv"
        "drugs/wildcard.rpz-nsdname.csv"
        "fake-news/wildcard.csv"
        "gambling/wildcard.csv"
        "gambling/wildcard.rpz-nsdname.csv"
        "malicious/wildcard.csv"
        "malicious/wildcard.rpz-nsdname.csv"
        "movies/tld.csv"
        "movies/wildcard.csv"
        "movies/wildcard.rpz-nsdname.csv"
        "news/tld.csv"
        "news/wildcard.csv"
        "news/wildcard.rpz-nsdname.csv"
        "phishing/wildcard.csv"
        "phishing/wildcard.rpz-nsdname.csv"
        "pirated/domains.rpz-nsdname.csv"
        "pirated/wildcard.csv"
        "pirated/wildcard.rpz-nsdname.csv"
        "politics/tld.csv"
        "politics/wildcard.csv"
        "politics/wildcard.rpz-nsdname.csv"
        "porn_filters/explicit_content/tld.csv"
        "porn_filters/explicit_content/wildcard.csv"
        "porn_filters/explicit_content/wildcard.rpz-nsdname.csv"
        "porn_filters/strict_filters/wildcard.csv"
        "porn_filters/strict_filters/wildcard.rpz-nsdname.csv"
        "redirector/wildcard.csv"
        "religion/tld.csv"
        "religion/wildcard.csv"
        "religion/wildcard.rpz-nsdname.csv"
        "scamming/wildcard.csv"
        "spam/tld.csv"
        "spam/wildcard.csv"
        "spam/wildcard.rpz-nsdname.csv"
        "spyware/tld.csv"
        "spyware/wildcard.csv"
        "spyware/wildcard.rpz-nsdname.csv"
        "suspected/tld.csv"
        "suspected/wildcard.csv"
        "suspected/wildcard.rpz-nsdname.csv"
        "torrent/tld.csv"
        "torrent/wildcard.csv"
        "torrent/wildcard.rpz-nsdname.csv"
        "tracking/tld.csv"
        "tracking/wildcard.csv"
        "tracking/wildcard.rpz-nsdname.csv"
        "typosquatting/wildcard.csv"
        "typosquatting/wildcard.rpz-nsdname.csv"
        "weapons/tld.csv"
        "weapons/wildcard.csv"
        "weapons/wildcard.rpz-nsdname.csv"
        "whitelist/wildcard.csv"
    )

    for ((a = 0; a < ${#ALPHABETICALLY[@]}; a++)); do
        sort -u --parallel="$(nproc --ignore=1)" "${ALPHABETICALLY[$a]}" \
            -o "${ALPHABETICALLY[$a]}"
        sed -i "/^$/d" "${ALPHABETICALLY[$a]}"
        echo "Sorting: ${ALPHABETICALLY[$a]}"
    done

    HIERARCHICALLY=(
        "adware/domains.csv"
        "adware/onions.csv"
        "adware/rpz-ip.csv"
        "bait_sites/domains.csv"
        "bait_sites/rpz-ip.csv"
        "coinblocker/domains.csv"
        "coinblocker/onions.csv"
        "coinblocker/rpz-ip.csv"
        "dns-servers/rpz-ip.csv"
        "drugs/domains.csv"
        "drugs/onions.csv"
        "drugs/rpz-ip.csv"
        "fake-news/domains.csv"
        "fake-news/rpz-ip.csv"
        "gambling/domains.csv"
        "gambling/onions.csv"
        "gambling/rpz-ip.csv"
        "ip-network-blocking/ip4.csv"
        "ip-network-blocking/ip6.csv"
        "ip-network-blocking/rpz-client-ip.csv"
        "ip-network-blocking/rpz-drop.csv"
        "ip-network-blocking/rpz-ip.csv"
        "malicious/domains.csv"
        "malicious/onions.csv"
        "malicious/rpz-ip.csv"
        "movies/domains.csv"
        "movies/onions.csv"
        "movies/rpz-ip.csv"
        "news/domains.csv"
        "news/onions.csv"
        "news/rpz-ip.csv"
        "phishing/domains.csv"
        "phishing/onions.csv"
        "phishing/rpz-ip.csv"
        "pirated/domains.csv"
        "pirated/rpz-ip.csv"
        "politics/domains.csv"
        "politics/onions.csv"
        "politics/rpz-ip.csv"
        "porn_filters/explicit_content/domains.csv"
        "porn_filters/explicit_content/hosts.csv"
        "porn_filters/explicit_content/mobile.csv"
        "porn_filters/explicit_content/onions.csv"
        "porn_filters/explicit_content/rpz-ip.csv"
        "porn_filters/explicit_content/snuff.csv"
        "porn_filters/strict_filters/domains.csv"
        "porn_filters/strict_filters/hosts.csv"
        "porn_filters/strict_filters/onions.csv"
        "porn_filters/strict_filters/rpz-ip.csv"
        "redirector/domains.csv"
        "redirector/onions.csv"
        "redirector/rpz-ip.csv"
        "religion/domains.csv"
        "religion/onions.csv"
        "religion/rpz-ip.csv"
        "scamming/domains.csv"
        "scamming/onions.csv"
        "scamming/rpz-ip.csv"
        "spam/domains.csv"
        "spam/onions.csv"
        "spam/rpz-ip.csv"
        "spyware/domains.csv"
        "spyware/onions.csv"
        "spyware/rpz-ip.csv"
        "suspected/domains.csv"
        "suspected/onions.csv"
        "suspected/rpz-ip.csv"
        "torrent/domains.csv"
        "torrent/onions.csv"
        "torrent/rpz-ip.csv"
        "tracking/domains.csv"
        "tracking/onions.csv"
        "tracking/rpz-ip.csv"
        "typosquatting/domains.csv"
        "typosquatting/onions.csv"
        "typosquatting/rpz-ip.csv"
        "weapons/domains.csv"
        "weapons/onions.csv"
        "weapons/rpz-ip.csv"
        "whitelist/domains.csv"
        "whitelist/onions.csv"
        "whitelist/rpz-ip.csv"
    )

    for ((h = 0; h < ${#HIERARCHICALLY[@]}; h++)); do
        sort -u "${HIERARCHICALLY[$h]}" -o "${HIERARCHICALLY[$h]}"
        python3 "$GIT_DIR/tools/domain-sort.py" <"${HIERARCHICALLY[$h]}" \
            >"${HIERARCHICALLY[$h]}.tmp" &&
            sed "/^$/d" "${HIERARCHICALLY[$h]}.tmp" \
                >"${HIERARCHICALLY[$h]}"

        echo "Sorting: ${HIERARCHICALLY[$h]}"
    done

    find "${GIT_DIR}"/source/ -maxdepth 4 -mindepth 1 -type f -iname '*.tmp' -delete

else
    echo "This is not a Git repo. Exiting"
    exit 1
fi
