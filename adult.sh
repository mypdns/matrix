#!/usr/bin/env bash

# Copyright: https://www.mypdns.org/
# Content: https://www.mypdns.org/p/Spirillen/
# Source: https://github.com/Import-External-Sources/pornhosts
# License: https://www.mypdns.org/w/License
# License Comment: GNU AGPLv3, MODIFIED FOR NON COMMERCIAL USE
#
# License in short:
# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included.
#
# Please forward any additions, corrections or comments by logging an
# issue at https://www.mypdns.org/maniphest/

set -e #-x

# Do we have pdnsutil installed on this machine?
hash pdnsutil 2>/dev/null || { echo >&2 "pdnsutil Is required, but it's not installed.  Aborting..."; exit 1; }

# This Script is only to commit wildcard domains into porn list
# Next release will contain hosts style submissions

printf "\nNext porno domain issues\n\n"

grep -ivE '[a-z0-9]+\.[a-z]+\.[a-z]+' "./tmp/rpz.missing" | head -n 1

printf "\n"

read -e -r -p "Enter domain to handle as 'domain.tld': " -i "$(grep -ivE '[a-z0-9]+\.[a-z]+\.[a-z]+' './tmp/rpz.missing' | head -n 1)" domain

# Request for the needs of www. for primary domain
while true
do
read -r -p "Append WWW to ${domain} [Y/n] " input

case $input in
	[yY][eE][sS]|[yY])
 _www="true"
 break
 ;;
	[nN][oO]|[nN])
 _www="false"
 break
        ;;
     *)
 echo "Invalid input..."
 ;;
 esac
done

read -rp "Enter Pornhost Issue ID: " issue
#read -rp "Enter MyPdns.org Phabricator ID: " tissue

printf "\nAdding domain: $domain\n"
printf "$domain\n" >> "source/porno-sites/wildcard.list"

printf "\nGit commit $domain\nwith Pornhost issue ID: $issue\n"
#printf "\nGit commit $domain\n MypDNS Bug: T$tissue\n"

# https://askubuntu.com/questions/29215/how-can-i-read-user-input-as-an-array-in-bash/29582#29582
additional=()
while IFS= read -r -p "Additional requirements for hosts (end with an empty line): " line; do
    [[ $line ]] || break  # break if line is empty
    additional+=("$line")
done

#printf "\nsed $domain\n"
sed -i "/${domain}/d" "./tmp/t2.list"
sed -i "/${domain}/d" "./tmp/67.list"
sed -i "/${domain}/d" "./tmp/rpz.missing"
sed -i "/${domain}/d" "./tmp/rpz.missing.bak"
sed -i "/${domain}/d" "./source/porno-sites/wildcard.list.old"

git commit -am "Adding new porno domain \`${domain}\`

Related issue: https://github.com/spirillen/pornhosts/issues/${issue}

You can read more about this particular Porn blocking project at
https://www.mypdns.org/project/view/10/

If you would like to learn more about how to use the RPZ powered DNS
Firewall with our zone files, you can read more about it here
https://www.mypdns.org/w/rpz

You can read about about our different zones here
https://www.mypdns.org/w/rpzList"

# Following code will only succeed if you have admin access to our DNS
# Servers at https://www.mypdns.org/
# Everybody else needs to out comment the following lines
printf "\nAdding ${domain} to our RPZ\n"
pdnsutil add-record "adult.mypdns.cloud" "${domain}" CNAME 86400 .
pdnsutil add-record "adult.mypdns.cloud" "*.${domain}" CNAME 86400 .

printf "\nIncreasing serial of our RPZ\n"
pdnsutil increase-serial 'adult.mypdns.cloud'

#git push

# Let's also commit to Import-External-Sources/pornhosts while are doing something

printf "\n\tStarting to commit to pornhosts\n\n"

cd "../../../github/pornhosts/"

# Adding primary domain
printf "$domain\n" >> "submit_here/hosts.txt"

# Are we going to submit the domain with or without _www.domain?
if [ ${_www} == "true" ]
then
printf "www.$domain\n" >> "submit_here/hosts.txt"
fi

# Append hosts file specific requirements
printf '%s\n' "Appending additional hosts requirements:"
printf '%s\n' "${additional[@]}"

# The next part should be a seperate branch with a MR
printf "Added ${domain} Closes https://github.com/Import-External-Sources/pornhosts/issues/${issue}\n\n" >> commit.msg

#git commit -am "Adding new porno domain \`${domain}\`

#Closes https://github.com/spirillen/pornhosts/issues/${issue}

#Source: https://github.com/Sinfonietta/hostfiles/pull/100

#This submission enhanced the true power of My DNS Privacy Firewall
#by https://www.mypdns.org/.

#If you would like to learn more about how to use the RPZ powered DNS Firewall
#with our zone files, you can read more about it here
#https://www.mypdns.org/w/rpz

#You can read about about our different zones here
#https://www.mypdns.org/w/rpzList

#[ci skip]"

# Get back to script path (matrix)
cd "../../gitlab/matrix/matrix/"

#grep -iE '[a-z0-9]+\.[a-z]+\.[a-z]+' source/porno-sites/wildcard.list | grep -viE '(co.(uk|jp|za))|(com.(au|br))$'

# Let's start over.
# https://askubuntu.com/questions/356800/how-to-completely-restart-script-from-inside-the-script-itself/356964#356964
exec ${0} && exit
