#!/usr/bin/env bash

# Exit on any errors
set -e -u

# Change GIT upstream from git to https
git remote set-url origin https://mypdns:$MypDNS_CI@gitlab.com/$CI_PROJECT_PATH.git

git add .
git status
git commit -am '[skip ci] commit from CI runner'
git push -u origin master

# Tell REPO_NAME to run the CI
sleep 5 curl -X POST -F token="$hosts_token" -F ref=master https://gitlab.com/api/v4/projects/14278031/trigger/pipeline
