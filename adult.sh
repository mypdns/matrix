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
git commit -am "Implement #$issue by adding ${domain} Related #815 [skip ci]"
#git push

#printf "\nsed $domain\n"
sed -i "/${domain}/d" "./tmp/67.list"

#grep -iE '[a-z0-9]+\.[a-z]+\.[a-z]+' source/porno-sites/wildcard.list | grep -viE '(co.(uk|jp|za))|(com.(au|br))$'

./adult.sh
