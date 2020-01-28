#!/usr/bin/env bash
set -e
#set -x

# Do we have pdnsutil installed on this machine?
hash pdnsutil 2>/dev/null || { echo >&2 "pdnsutil Is required, but it's not installed.  Aborting..."; exit 1; }

# This Script is only to commit wildcard domains into porn list

printf "\nNext porno domain issues\n\n"

grep -ivE '[a-z0-9]+\.[a-z]+\.[a-z]+' "./tmp/67.list" | head -n 1

printf "\n"

read -p "Enter domain to handle as 'domain.tld': " domain
read -p "Enter issue number: " issue

printf "\nAdding domain: $domain\n"
printf "$domain\n" >> "source/porno-sites/wildcard.list"

printf "\nGit commit $domain\nwith issue ID: $issue\n"
git commit -am "Adding new porno domain ${domain} [skip ci]
Closes https://github.com/mypdns/matrix/issues/${issue}

Thanks to My Privacy DNS Firewall https://www.mypdns.org/"

printf "Adding ${domain} to our RPZ"
pdnsutil add-record "adult.mypdns.cloud" "${domain}" CNAME 86400 .
pdnsutil add-record "adult.mypdns.cloud" "*.${domain}" CNAME 86400 .

printf "Increase serial of our RPZ"
pdnsutil increase-serial 'adult.mypdns.cloud'

#git push

#printf "\nsed $domain\n"
sed -i "/${domain}/d" "./tmp/67.list"
sed -i "/${domain}/d" "./source/porno-sites/wildcard.list.old"

#grep -iE '[a-z0-9]+\.[a-z]+\.[a-z]+' source/porno-sites/wildcard.list | grep -viE '(co.(uk|jp|za))|(com.(au|br))$'

./adult.sh
