#!/usr/bin/env bash

#
# Repository Source Sorter: normalize, dedupe and sort project CSV lists
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

set -euo pipefail

# Config
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$REPO_ROOT" ]; then
  printf 'Error: not inside a git repository\n' >&2
  exit 1
fi

cd "$REPO_ROOT/source" || exit 1

# Temporary file with cleanup trap
TEMP_FILE="$(mktemp --tmpdir="$(pwd)" sort.XXXXXX.tmp)"
cleanup() { rm -f "$TEMP_FILE"; }
trap cleanup EXIT INT TERM

# Use available parallelism but keep at least one core free
NPROC="$(nproc 2>/dev/null || echo 1)"
PARALLELISM=1
if [ "$NPROC" -gt 1 ]; then
  PARALLELISM=$((NPROC - 1))
fi

# Helper to sort, dedupe, remove blank lines and write back atomically
sort_file_atomic() {
  local file="$1"
  [ -f "$file" ] || return 0
  sort -u --parallel="$PARALLELISM" "$file" -o "$TEMP_FILE"
  sed -n '/\S/ p' "$TEMP_FILE" > "${file}.tmp" && mv "${file}.tmp" "$file"
}

# Files to sort lexicographically (alphabetical)
ALPHABETICALLY=(
  adware/tld.csv
  adware/wildcard.csv
  adware/wildcard.rpz-nsdname.csv
  alphabet/wildcard.csv
  alphabet/wildcard.rpz-nsdname.csv
  bait_sites/wildcard.csv
  coinblocker/wildcard.csv
  dns-servers/domains.rpz-nsdname.csv
  dns-servers/wildcard.rpz-nsdname.csv
  drugs/tld.csv
  drugs/wildcard.csv
  drugs/wildcard.rpz-nsdname.csv
  fake-news/wildcard.csv
  gambling/wildcard.csv
  gambling/wildcard.rpz-nsdname.csv
  malicious/wildcard.csv
  malicious/wildcard.rpz-nsdname.csv
  movies/tld.csv
  movies/wildcard.csv
  movies/wildcard.rpz-nsdname.csv
  news/tld.csv
  news/wildcard.csv
  news/wildcard.rpz-nsdname.csv
  phishing/wildcard.csv
  phishing/wildcard.rpz-nsdname.csv
  pirated/domains.rpz-nsdname.csv
  pirated/wildcard.csv
  pirated/wildcard.rpz-nsdname.csv
  politics/tld.csv
  politics/wildcard.csv
  politics/wildcard.rpz-nsdname.csv
  porn_filters/explicit_content/tld.csv
  porn_filters/explicit_content/wildcard.csv
  porn_filters/explicit_content/wildcard.rpz-nsdname.csv
  porn_filters/strict_filters/wildcard.csv
  porn_filters/strict_filters/wildcard.rpz-nsdname.csv
  redirector/wildcard.csv
  religion/tld.csv
  religion/wildcard.csv
  religion/wildcard.rpz-nsdname.csv
  scamming/wildcard.csv
  spam/tld.csv
  spam/wildcard.csv
  spam/wildcard.rpz-nsdname.csv
  spyware/tld.csv
  spyware/wildcard.csv
  spyware/wildcard.rpz-nsdname.csv
  suspected/tld.csv
  suspected/wildcard.csv
  suspected/wildcard.rpz-nsdname.csv
  torrent/tld.csv
  torrent/wildcard.csv
  torrent/wildcard.rpz-nsdname.csv
  tracking/tld.csv
  tracking/wildcard.csv
  tracking/wildcard.rpz-nsdname.csv
  typosquatting/wildcard.csv
  typosquatting/wildcard.rpz-nsdname.csv
  weapons/tld.csv
  weapons/wildcard.csv
  weapons/wildcard.rpz-nsdname.csv
  whitelist/wildcard.csv
)

# Files to sort hierarchically (treat as domains; use external domain-sort.py)
HIERARCHICALLY=(
  adware/domains.csv
  adware/onions.csv
  adware/rpz-ip.csv
  bait_sites/domains.csv
  bait_sites/rpz-ip.csv
  coinblocker/domains.csv
  coinblocker/onions.csv
  coinblocker/rpz-ip.csv
  dns-servers/rpz-ip.csv
  drugs/domains.csv
  drugs/onions.csv
  drugs/rpz-ip.csv
  fake-news/domains.csv
  fake-news/rpz-ip.csv
  gambling/domains.csv
  gambling/onions.csv
  gambling/rpz-ip.csv
  ip-network-blocking/ip4.csv
  ip-network-blocking/ip6.csv
  ip-network-blocking/rpz-client-ip.csv
  ip-network-blocking/rpz-drop.csv
  ip-network-blocking/rpz-ip.csv
  malicious/domains.csv
  malicious/onions.csv
  malicious/rpz-ip.csv
  movies/domains.csv
  movies/onions.csv
  movies/rpz-ip.csv
  news/domains.csv
  news/onions.csv
  news/rpz-ip.csv
  phishing/domains.csv
  phishing/onions.csv
  phishing/rpz-ip.csv
  pirated/domains.csv
  pirated/rpz-ip.csv
  politics/domains.csv
  politics/onions.csv
  politics/rpz-ip.csv
  porn_filters/explicit_content/domains.csv
  porn_filters/explicit_content/hosts.csv
  porn_filters/explicit_content/mobile.csv
  porn_filters/explicit_content/onions.csv
  porn_filters/explicit_content/rpz-ip.csv
  porn_filters/explicit_content/snuff.csv
  porn_filters/strict_filters/domains.csv
  porn_filters/strict_filters/hosts.csv
  porn_filters/strict_filters/onions.csv
  porn_filters/strict_filters/rpz-ip.csv
  redirector/domains.csv
  redirector/onions.csv
  redirector/rpz-ip.csv
  religion/domains.csv
  religion/onions.csv
  religion/rpz-ip.csv
  scamming/domains.csv
  scamming/onions.csv
  scamming/rpz-ip.csv
  spam/domains.csv
  spam/onions.csv
  spam/rpz-ip.csv
  spyware/domains.csv
  spyware/onions.csv
  spyware/rpz-ip.csv
  suspected/domains.csv
  suspected/onions.csv
  suspected/rpz-ip.csv
  torrent/domains.csv
  torrent/onions.csv
  torrent/rpz-ip.csv
  tracking/domains.csv
  tracking/onions.csv
  tracking/rpz-ip.csv
  typosquatting/domains.csv
  typosquatting/onions.csv
  typosquatting/rpz-ip.csv
  weapons/domains.csv
  weapons/onions.csv
  weapons/rpz-ip.csv
  whitelist/domains.csv
  whitelist/onions.csv
  whitelist/rpz-ip.csv
)

# Sort alphabetical lists (normalize, UTF-8 safe, lowercase, uniq, atomic)
for f in "${ALPHABETICALLY[@]}"; do
  if [ -f "$f" ]; then
    tmp1="$(mktemp --tmpdir="$(pwd)" alpha1.XXXXXX)" || { echo "mktemp failed" >&2; exit 1; }
    tmp_out="$(mktemp --tmpdir="$(pwd)" alpha_out.XXXXXX)" || { rm -f "$tmp1"; echo "mktemp failed" >&2; exit 1; }

    cleanup_alpha() { rm -f "$tmp1" "$tmp_out"; }
    trap cleanup_alpha EXIT INT TERM

    # normalize encoding to UTF-8 if iconv available, lowercase, trim, remove blank lines, dedupe
    if command -v iconv >/dev/null 2>&1; then
      iconv -f UTF-8 -t UTF-8//IGNORE "$f" | awk '{$1=$1; print tolower($0)}' | sed -n '/\S/ p' > "$tmp1"
    else
      awk '{$1=$1; print tolower($0)}' "$f" | sed -n '/\S/ p' > "$tmp1"
    fi

    # sort lexicographically, dedupe (sort -u), write to tmp_out
    LC_ALL="${LC_ALL:-C.UTF-8}" sort -u --parallel="$PARALLELISM" "$tmp1" -o "$tmp_out"

    # atomic move back to original file
    mv "$tmp_out" "$f"

    # cleanup & remove trap for next iteration
    trap - EXIT INT TERM
    cleanup_alpha

    echo "Sorted: $f"
  else
    echo "Missing: $f" >&2
  fi
done


# Sort hierarchical lists (pure shell; ensures UTF-8, lowercase, uniq, stable sort)
for f in "${HIERARCHICALLY[@]}"; do
  if [ -f "$f" ]; then
    # tmp files (unique per run to avoid races)
    tmp1="$(mktemp --tmpdir="$(pwd)" sort1.XXXXXX)" || exit 1
    tmp2="$(mktemp --tmpdir="$(pwd)" sort2.XXXXXX)" || { rm -f "$tmp1"; exit 1; }
    tmp3="$(mktemp --tmpdir="$(pwd)" sort3.XXXXXX)" || { rm -f "$tmp1" "$tmp2"; exit 1; }

    cleanup_tmp() { rm -f "$tmp1" "$tmp2" "$tmp3"; }
    trap cleanup_tmp EXIT INT TERM

    # 1) normalize to UTF-8, trim, lowercase, remove blanks, dedupe
    # use iconv if available to ensure UTF-8, otherwise pass through
    if command -v iconv >/dev/null 2>&1; then
      iconv -f UTF-8 -t UTF-8//IGNORE "$f" | \
        awk '{$1=$1; print tolower($0)}' | sed -n '/\S/ p' | sort -u > "$tmp1"
    else
      awk '{$1=$1; print tolower($0)}' "$f" | sed -n '/\S/ p' | sort -u > "$tmp1"
    fi

    # 2) build reversed-label key (tld-first) and keep original as stable second key
    # output: key<TAB>domain
    awk -F'.' '
    function trim(s){ gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
    {
      line = trim($0)
      if (line == "") next
      # split into labels
      n = split(line, a, ".")
      key = a[n]
      for (i = n-1; i >= 1; i--) key = key "." a[i]
      # print key and original domain (both already lowercased)
      print key "\t" line
    }' "$tmp1" > "$tmp2"

    # 3) stable sort by key then domain (ensures deterministic order), extract domain
    # use LC_ALL=C.UTF-8 if available to ensure consistent UTF-8 collation
    LC_ALL="${LC_ALL:-C.UTF-8}" sort -t$'\t' -k1,1 -k2,2 "$tmp2" | awk -F'\t' '{ print $2 }' > "$tmp3"

    # 4) write back atomically
    mv "$tmp3" "$f"

    # cleanup & remove trap for next iteration
    trap - EXIT INT TERM
    cleanup_tmp

    echo "Sorted (hierarchical): $f"
  else
    echo "Missing: $f" >&2
  fi
done


# Clean any leftover .tmp files
find "$REPO_ROOT/source" -type f -name '*.tmp' -delete

exit 0
