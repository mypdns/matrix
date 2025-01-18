#!/bin/bash

sort_alpha_numeric_natural() {
    local file="$1"
    sort -V -u --parallel=$(( $(nproc) - 1 )) -o "$file" "$file"
    sed -i '/^$/d' "$file"
    git add "$file"
    echo "Sorted alpha-numeric natural and staged: $file"
}

sort_hierarchically() {
    local file="$1"
    local tmp_file="${file}.tmp"
    sort -u --parallel=$(( $(nproc) - 1 )) "$file" |
    awk -F'.' '{n = split($0, a, "."); for (i = n; i >= 1; i--) printf "%s.", a[i]; print ""}' |
    sort -t '.' -k 2,2 -k 1,1 |
    awk -F'.' '{n = split($0, a, "."); for (i = n; i >= 1; i--) printf "%s.", a[i]; print ""}' > "$tmp_file"
    mv "$tmp_file" "$file"
    sed -i '/^$/d' "$file"
    git add "$file"
    echo "Sorted hierarchically and staged: $file"
}

main() {
    local GIT_DIR
    GIT_DIR=$(git rev-parse --show-toplevel)

    if [[ -d "$GIT_DIR" ]]; then
        cd "$GIT_DIR/source" || exit

        ALPHABETICALLY=(
            "adware/tld.csv" "adware/wildcard.csv" "adware/wildcard.rpz-nsdname.csv" "alphabet/wildcard.csv"
            "alphabet/wildcard.rpz-nsdname.csv" "bait_sites/wildcard.csv" "coinblocker/wildcard.csv"
            "dns-servers/domains.rpz-nsdname.csv" "dns-servers/wildcard.rpz-nsdname.csv" "drugs/tld.csv"
            "drugs/wildcard.csv" "drugs/wildcard.rpz-nsdname.csv" "fake-news/wildcard.csv" "gambling/wildcard.csv"
            "gambling/wildcard.rpz-nsdname.csv" "malicious/wildcard.csv" "malicious/wildcard.rpz-nsdname.csv"
            "movies/tld.csv" "movies/wildcard.csv" "movies/wildcard.rpz-nsdname.csv" "news/tld.csv"
            "news/wildcard.csv" "news/wildcard.rpz-nsdname.csv" "phishing/wildcard.csv" "phishing/wildcard.rpz-nsdname.csv"
            "pirated/domains.rpz-nsdname.csv" "pirated/wildcard.csv" "pirated/wildcard.rpz-nsdname.csv" "politics/tld.csv"
            "politics/wildcard.csv" "politics/wildcard.rpz-nsdname.csv" "porn_filters/explicit_content/tld.csv"
            "porn_filters/explicit_content/wildcard.csv" "porn_filters/explicit_content/wildcard.rpz-nsdname.csv"
            "porn_filters/strict_filters/wildcard.csv" "porn_filters/strict_filters/wildcard.rpz-nsdname.csv"
            "redirector/wildcard.csv" "religion/tld.csv" "religion/wildcard.csv" "religion/wildcard.rpz-nsdname.csv"
            "scamming/wildcard.csv" "spam/tld.csv" "spam/wildcard.csv" "spam/wildcard.rpz-nsdname.csv"
            "spyware/tld.csv" "spyware/wildcard.csv" "spyware/wildcard.rpz-nsdname.csv" "suspected/tld.csv"
            "suspected/wildcard.csv" "suspected/wildcard.rpz-nsdname.csv" "torrent/tld.csv" "torrent/wildcard.csv"
            "torrent/wildcard.rpz-nsdname.csv" "tracking/tld.csv" "tracking/wildcard.csv" "tracking/wildcard.rpz-nsdname.csv"
            "typosquatting/wildcard.csv" "typosquatting/wildcard.rpz-nsdname.csv" "weapons/tld.csv" "weapons/wildcard.csv"
            "weapons/wildcard.rpz-nsdname.csv" "whitelist/wildcard.csv"
        )

        HIERARCHICALLY=(
            "adware/domains.csv" "adware/onions.csv" "adware/rpz-ip.csv" "bait_sites/domains.csv"
            "bait_sites/rpz-ip.csv" "coinblocker/domains.csv" "coinblocker/onions.csv" "coinblocker/rpz-ip.csv"
            "dns-servers/rpz-ip.csv" "drugs/domains.csv" "drugs/onions.csv" "drugs/rpz-ip.csv"
            "fake-news/domains.csv" "fake-news/rpz-ip.csv" "gambling/domains.csv" "gambling/onions.csv"
            "gambling/rpz-ip.csv" "ip-network-blocking/ip4.csv" "ip-network-blocking/ip6.csv"
            "ip-network-blocking/rpz-client-ip.csv" "ip-network-blocking/rpz-drop.csv" "ip-network-blocking/rpz-ip.csv"
            "malicious/domains.csv" "malicious/onions.csv" "malicious/rpz-ip.csv" "movies/domains.csv"
            "movies/onions.csv" "movies/rpz-ip.csv" "news/domains.csv" "news/onions.csv" "news/rpz-ip.csv"
            "phishing/domains.csv" "phishing/onions.csv" "phishing/rpz-ip.csv" "pirated/domains.csv"
            "pirated/rpz-ip.csv" "politics/domains.csv" "politics/onions.csv" "politics/rpz-ip.csv"
            "porn_filters/explicit_content/domains.csv" "porn_filters/explicit_content/hosts.csv"
            "porn_filters/explicit_content/mobile.csv" "porn_filters/explicit_content/onions.csv"
            "porn_filters/explicit_content/rpz-ip.csv" "porn_filters/explicit_content/snuff.csv"
            "porn_filters/strict_filters/domains.csv" "porn_filters/strict_filters/hosts.csv"
            "porn_filters/strict_filters/onions.csv" "porn_filters/strict_filters/rpz-ip.csv" "redirector/domains.csv"
            "redirector/onions.csv" "redirector/rpz-ip.csv" "religion/domains.csv" "religion/onions.csv"
            "religion/rpz-ip.csv" "scamming/domains.csv" "scamming/onions.csv" "scamming/rpz-ip.csv"
            "spam/domains.csv" "spam/onions.csv" "spam/rpz-ip.csv" "spyware/domains.csv" "spyware/onions.csv"
            "spyware/rpz-ip.csv" "suspected/domains.csv" "suspected/onions.csv" "suspected/rpz-ip.csv"
            "torrent/domains.csv" "torrent/onions.csv" "torrent/rpz-ip.csv" "tracking/domains.csv"
            "tracking/onions.csv" "tracking/rpz-ip.csv" "typosquatting/domains.csv" "typosquatting/onions.csv"
            "typosquatting/rpz-ip.csv" "weapons/domains.csv" "weapons/onions.csv" "weapons/rpz-ip.csv"
            "whitelist/domains.csv" "whitelist/onions.csv" "whitelist/rpz-ip.csv"
        )

        last_commit_files=$(git diff-tree --no-commit-id --name-only -r HEAD)

        for file in $last_commit_files; do
            for alpha_file in "${ALPHABETICALLY[@]}"; do
                if [[ "$file" == "$alpha_file" ]]; then
                    sort_alpha_numeric_natural "$file"
                    break
                fi
            done
            for hier_file in "${HIERARCHICALLY[@]}"; do
                if [[ "$file" == "$hier_file" ]]; then
                    sort_hierarchically "$file"
                    break
                fi
            done
        done

        git commit -m "Sorted files in ALPHABETICALLY and HIERARCHICALLY arrays"
    fi
}

main "$@"
