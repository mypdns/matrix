#!/usr/bin/env bash

printf "\nEnter domain to handle as 'domain.tld':"

read domain

grep -i '.${domain}$' source/porno-sites/wildcard.list >> source/porno-sites/domain.list
sed -i '/.${domain}/d' source/porno-sites/wildcard.list
git commit -am "Moved ${domain}"

grep -iE '[a-z0-9]+\.[a-z]+\.[a-z]+' source/porno-sites/wildcard.list | grep -viE '(co.(uk|jp))|(com.br)$'
