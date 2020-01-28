#!/usr/bin/env bash
# To generate the list do
# for n in $(seq -w 2 0 300); do printf "domain${n}.tld\n"; done

# Then run this script to output lines for powerdns

while IFS= read -r line; do
    printf "pdnsutil add-record rpz.mypdns.cloud '$line' CNAME 345600 .\n"
    printf "pdnsutil add-record rpz.mypdns.cloud '*.$line' CNAME 345600 .\n"
done < "$1"
