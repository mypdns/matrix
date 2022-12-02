#!/bin/sh

# Run this script as cron task

REPO_DIR="/home/$USER/Downloads/git_projects/my_privacy_dns/matrix"

#GIT_DIR="$(git rev-parse --show-toplevel)"

if [ -d "$REPO_DIR" ]; then
    # shellcheck disable=SC2164
    cd "$REPO_DIR" || exit
    git pull --rebase origin master
    wget -O source/porn_filters/imported/adult.ShadowWhisperer https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/RAW/Adult
    git commit -am "Updated ShadowWhisperer Adult list"
    git push origin master
fi
