#!/usr/bin/env bash

# This Script is only to commit wildcard domains into porn list

printf "\nNext porno domain issues\n\n"

grep -ivE '[a-z0-9]+\.[a-z]+\.[a-z]+' "./tmp/67.list" | head -n 1

printf "\n"

read -p "Enter domain to handle as 'domain.tld': " domain
read -p "Enter issue number: " issue

printf "\nAdding domain: $domain\n"
printf "$domain\n" >> "source/porno-sites/wildcard.list"

printf "\nGit commit $domain\nwith issue ID: $issue\n"
git commit -am "Adding new porno domain ${domain} [skip ci]\n\nCloses https://gitlab.com/my-privacy-dns/matrix/matrix/issues/${issue}\n\nThanks to My Privacy DNS Firewall https://www.mypdns.org/"

pdnsutil add-record "adult.mypdns.cloud" "${domain}" CNAME 86400 .
pdnsutil increase-serial 'adult.mypdns.cloud'

#git push

#printf "\nsed $domain\n"
sed -i "/${domain}/d" "./tmp/67.list"

#grep -iE '[a-z0-9]+\.[a-z]+\.[a-z]+' source/porno-sites/wildcard.list | grep -viE '(co.(uk|jp|za))|(com.(au|br))$'

./adult.sh
