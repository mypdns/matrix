#!/usr/bin/env bash

# Exit on any errors
set -e -u

# Change GIT upstream from git to https
git remote set-url origin "https://git:$DEPLOY_KEY@gitlab.com/$CI_PROJECT_PATH.git"

# Step 1. Fetch and check out the branch for this merge request
git fetch origin
git checkout -b "$CI_MERGE_REQUEST_SOURCE_BRANCH_NAME origin/$CI_MERGE_REQUEST_SOURCE_BRANCH_NAME"

# Step 2. Review the changes locally

# Step 3. Merge the branch and fix any conflicts that come up

git fetch origin
git checkout origin/master
git merge --no-ff "$CI_MERGE_REQUEST_SOURCE_BRANCH_NAME"

# Step 4. Push the result of the merge to into master
git push origin master

#git add .
#git status
#git commit -m '[skip ci] commit from CI runner'
#git push -u origin master
