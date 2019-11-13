#!/usr/bin/env bash

# Exit on any errors
set -e -u

# Make sure we are in the projects root folder
cd $CI_PROJECT_DIR

# Change GIT upstream from git to https
#git remote set-url origin https://mypdns:$MypDNS_CI@gitlab.com/$CI_PROJECT_PATH.git

git add .
git status
git commit -am 'Auto committed from the CI runner [skip ci]'
git push -u origin ${CI_COMMIT_REF_NAME}

printf "\n\nPushed to Repository\n\n"

# Tell REPO_NAME to run the CI
# But first wait for the commit to land
sleep 5s 

"curl -X POST -F token="$hosts_token" -F ref=master https://gitlab.com/api/v4/projects/14278031/trigger/pipeline"
"curl -X POST -F token="$unbound_token" -F ref=matrix https://gitlab.com/api/v4/projects/14276081/trigger/pipeline"
printf "\n\nApi executed\n\n"

exit ${?}
