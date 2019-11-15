#!/usr/bin/env bash

#echo "Enter domain to handle as 'domain.tld': "

read -p "Enter domain to handle as 'domain.tld': " domain

printf "\n$domain\n"

printf "\ngrep $domain\n"
grep -i ".${domain}$" "source/porno-sites/wildcard.list" >> "source/porno-sites/domain.list"

printf "\nsed $domain\n"
sed -i "/.${domain}/d" "source/porno-sites/wildcard.list"

printf "\nGit $domain\n"
git commit -am "Moved ${domain}"

grep -iE '[a-z0-9]+\.[a-z]+\.[a-z]+' source/porno-sites/wildcard.list | grep -viE '(co.(uk|jp))|(com.(au|br))$'
