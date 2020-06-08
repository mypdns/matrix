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

## Set script root dir
pushd . > /dev/null
SCRIPT_PATH="${BASH_SOURCE[0]}";
if ([ -h "${SCRIPT_PATH}" ]) then
  while([ -h "${SCRIPT_PATH}" ]) do cd "$(dirname "$SCRIPT_PATH")"; SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"; done
fi
cd "$(dirname "${SCRIPT_PATH}".)" > /dev/null
SCRIPT_PATH=$(pwd);
popd  > /dev/null

export ROOT_DIR="$(dirname "$SCRIPT_PATH")"

# import config values from api.cfg
# https://stackoverflow.com/questions/5228345/how-to-reference-a-file-for-variables-using-bash/36164878#36164878
#

configfile='$ROOT_DIR/api/api.cfg'
if [ -f ${configfile} ]; then
    echo "Reading user config...." >&2

    # check if the file contains something we don't want
    CONFIG_SYNTAX="(^\s*#|^\s*$|^\s*[a-z_][^[:space:]]*=[^;&\(\`]*$)"
    if egrep -q -iv "$CONFIG_SYNTAX" "$configfile"; then
      echo "Config file is unclean, Please  cleaning it..." >&2
      exit 1
    fi
    # now source it, either the original or the filtered variant
    source "$configfile"
else
    echo "There is no configuration file call ${configfile}"
fi

# Do we have pdnsutil installed on this machine?
hash pdnsutil 2>/dev/null || { echo >&2 "pdnsutil Is required, but it's not installed.  Aborting..."; exit 1; }

# This Script is only to commit wildcard domains into porn list
# Next release will contain hosts style submissions

printf "\nNext porno domain issues\n\n"

#grep -ivE '[a-z0-9]+\.[a-z]+\.[a-z]+' "./tmp/rpz.missing" | head -n 1
#printf "\n"

read -e -r -p "Enter domain to handle as 'domain.tld': " \
  -i "$(grep -ivE '[a-z0-9]+\.[a-z]+\.[a-z]+' './tmp/rpz.missing' | head -n 1)" \
  domain

# Request for the needs of www. for primary domain
while true
do
read -r -p "Append WWW to ${domain} [Y/n] " www

case $www in
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
read -rp "Enter MyPdns.org Phabricator ID: " mypdns_id

# Setup some general functions and variables
export _branch_name="submit/${domain//\./_}"

git_commit () {
    git push origin "${_branch_name}"
    git checkout "${base}"
}

git_commit_mypdns () {
    git checkout "${base}"
    git merge --no-ff "${_branch_name}"
    git push origin "${base}"
    git push origin "${_branch_name}"
    git branch -D "${_branch_name}"
}

ScreenShot () {
    git checkout "${base}"
    $(command -v firefox) -CreateProfile CleanFF --headless
    $(command -v firefox) -P "CleanFF" --headless --screenshot "$_IP/screenshots/$domain.png" "http://$domain/"
    git add "screenshots/$domain.png"
    git commit -m "SCreenShot for $domain"
    git push
}

json () {

body="$(echo "${template}" | awk '{printf "%s\\r\\n", $0}')"

cat <<EOF > output.json
{
"title": "${domain}",
"head": "${_branch_name}",
"base": "${base}",
"body": "$body"
}
EOF

commit_msg="$(jq -c '.' output.json)"
}

PullRequest () {
    json
    apiurl=$(git remote get-url origin | sed -e 's/\.git//g' | awk -F ":" '{ printf ("%s\n",tolower($2)) }')


    "${_api_token}"
}

###
export base="master"

printf "Changing branch to %s\n" "${_branch_name}"
git checkout -b "submit/$_branch_name" "${base}"

printf "\nAdding domain: %s\n" "$domain"
printf "%s\n" >> "source/porno-sites/wildcard.list" "$domain"

printf "\nGit commit %s\nwith Pornhost issue ID: %s\n" "$domain" "$issue"

if [ -n "${mypdns_id}" ]
then
printf "\nGit commit $domain\n MypDNS Bug: T%s\n" "$mypdns_id"
fi

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

if [ -z "${mypdns_id}" ]
then
git commit -am "Adding new porno domain \`${domain}\`

Related issue: https://github.com/spirillen/pornhosts/issues/${issue}

${footer}"

else

git commit -am "Adding new porno domain \`${domain}\`

Closes T${mypdns_id}

- https://www.mypdns.org/T${mypdns_id}

Related issue: https://github.com/spirillen/pornhosts/issues/${issue}

${footer}"

fi

git_commit_mypdns

# Following code will only succeed if you have admin access to the DNS
# Servers at https://www.mypdns.org/
# Everybody else needs to out comment the following lines
printf "\nAdding %s to our RPZ\n" "$domain"
pdnsutil add-record "adult.mypdns.cloud" "${domain}" CNAME 86400 .
pdnsutil add-record "adult.mypdns.cloud" "*.${domain}" CNAME 86400 .

printf "\nIncreasing serial of our RPZ\n"
pdnsutil increase-serial 'adult.mypdns.cloud'

# Let's also commit to Import-External-Sources/pornhosts while are at it

printf "\n\tStarting to commit to pornhosts\n\n"

cd "$_IP"
base="master"

# Get the screenshot
ScreenShot

# Change branch
git checkout -b "submit/$_branch_name" "${base}"

# Adding primary domain
printf "%s\n" >> "submit_here/hosts.txt" "$domain"

# Are we going to submit the domain with or without _www.domain?
if [ ${_www} == "true" ]
then
printf "www.%s\n" >> "submit_here/hosts.txt" "$domain"
fi

# Append hosts file specific requirements
if [ -n "${additional[1]}" ]
then
    printf '%s\n' "Appending additional hosts requirements:"
    printf '%s\n' "${additional[@]}" >> "submit_here/hosts.txt"
fi


if [ -z "${mypdns_id}" ]
then
git commit -am "Adding new porno domain \`${domain}\`

Closes https://github.com/Import-External-Sources/pornhosts/issues/${issue}

${footer}"

else

git commit -am "Adding new porno domain \`${domain}\`

Closes https://github.com/Import-External-Sources/pornhosts/issues/${issue}

Related issue: https://www.mypdns.org/T${mypdns_id}

${footer}"
fi

git_commit

bash api/pr_template.sh

# Let's also commit to clefspeare13/pornhosts while are at it
# but only in new style

printf "\n\tStarting to commit to clefspeare13\n\n"

cd "$_CP"

export base="feature/one_place_to_commit"

# Change branch
git checkout -b "submit/$_branch_name" "${base}"

# Adding primary domain
printf "%s\n" >> "submit_here/hosts.txt" "$domain"

# Are we going to submit the domain with or without _www.domain?
if [ ${_www} == "true" ]
then
printf "www.%s\n" >> "submit_here/hosts.txt" "$domain"
fi

# Append hosts file specific requirements
if [ -n "${additional[1]}" ]
then
    printf '%s\n' "Appending additional hosts requirements:"
    printf '%s\n' "${additional[@]}" >> "submit_here/hosts.txt"
fi

if [ -z "${mypdns_id}" ]
then
git commit -am "Adding new porno domain \`${domain}\`

Closes https://github.com/Import-External-Sources/pornhosts/issues/${issue}

${footer}"

else

git commit -am "Adding new porno domain \`${domain}\`

Closes https://github.com/Import-External-Sources/pornhosts/issues/${issue}

Related issue: https://www.mypdns.org/T${mypdns_id}

${footer}"
fi

git_commit

bash api/pr_template.sh

# Get back to script path (matrix)
cd "${ROOT_DIR}"


#grep -iE '[a-z0-9]+\.[a-z]+\.[a-z]+' source/porno-sites/wildcard.list | grep -viE '(co.(uk|jp|za))|(com.(au|br))$'

# Let's start over.
# https://askubuntu.com/questions/356800/how-to-completely-restart-script-from-inside-the-script-itself/356964#356964
exec ${0} && exit
