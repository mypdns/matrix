#!/usr/bin/env bash
# To generate the list do
# for n in $(seq -w 2 0 300); do printf "domain${n}.tld\n"; done

# Then run this script to output lines for powerdns

while IFS= read -r line; do
    printf "pdnsutil add-record rpz.mypdns.cloud '%S' CNAME 345600 .\n" "$line"
    printf "pdnsutil add-record rpz.mypdns.cloud '*.%s' CNAME 345600 .\n" "$line"
done < "$1"
