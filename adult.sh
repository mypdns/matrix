#!/usr/bin/env bash

# Copyright: https://www.mypdns.org/
# Content: https://gitlab.com/spirillen
# Source: https://github.com/Import-External-Sources/pornhosts
# License: https://www.mypdns.org/wiki/License
# License Comment: GNU AGPLv3, MODIFIED FOR NON COMMERCIAL USE
#
# License in short:
# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included.
#
# Please forward any additions, corrections or comments by logging an 
# issue at https://github.com/mypdns/matrix/issues

set -e
#set -x

# Do we have pdnsutil installed on this machine?
hash pdnsutil 2>/dev/null || { echo >&2 "pdnsutil Is required, but it's not installed.  Aborting..."; exit 1; }

# This Script is only to commit wildcard domains into porn list

printf "\nNext porno domain issues\n\n"

grep -ivE '[a-z0-9]+\.[a-z]+\.[a-z]+' "./tmp/67.list" | head -n 1

printf "\n"

read -p "Enter domain to handle as 'domain.tld': " domain
read -p "Enter GH issue ID: " issue
read -p "Enter Pornhost Issue ID: " pissue
printf "\nAdding domain: $domain\n"
printf "$domain\n" >> "source/porno-sites/wildcard.list"

printf "\nGit commit $domain\nwith issue ID: $issue\n"
git commit -am "Adding new porno domain \`${domain}\`
Closes https://github.com/mypdns/matrix/issues/${issue}

This submission enhanced the true power of My DNS Privacy Firewall
by https://www.mypdns.org/.

If you would like to learn more about how to use the RPZ powered DNS Firewall
with our zone files, you can read more about it here
https://www.mypdns.org/wiki/Rpz

You can read about about our different zones here
https://www.mypdns.org/wiki/RpzList

[ci skip]"

printf "Adding ${domain} to our RPZ"
pdnsutil add-record "adult.mypdns.cloud" "${domain}" CNAME 86400 .
pdnsutil add-record "adult.mypdns.cloud" "*.${domain}" CNAME 86400 .

printf "Increasing serial of our RPZ"
pdnsutil increase-serial 'adult.mypdns.cloud'

#git push

#printf "\nsed $domain\n"
sed -i "/${domain}/d" "./tmp/67.list"
sed -i "/${domain}/d" "./source/porno-sites/wildcard.list.old"

# Let's also commit to Import-External-Sources/pornhosts while are doing something

printf "\n\tStarting to commit to pornhosts\n"

cd "../../../github/pornhosts/"

printf "$domain\n" >> "submit_here/hosts.txt"

git commit -am "Adding new porno domain \`${domain}\`
Closes https://github.com/Import-External-Sources/pornhosts/issues/${pissue}

This submission enhanced the true power of My DNS Privacy Firewall
by https://www.mypdns.org/.

If you would like to learn more about how to use the RPZ powered DNS Firewall
with our zone files, you can read more about it here
https://www.mypdns.org/wiki/Rpz

You can read about about our different zones here
https://www.mypdns.org/wiki/RpzList

[ci skip]"

# Get back to script path (matrix)
cd "../../gitlab/matrix/matrix/"

#grep -iE '[a-z0-9]+\.[a-z]+\.[a-z]+' source/porno-sites/wildcard.list | grep -viE '(co.(uk|jp|za))|(com.(au|br))$'

# Let's start over.
./adult.sh
