#!/bin/sh

# Run this script as cron task
set -e
REPO_DIR="/home/$USER/Downloads/git_projects/my_privacy_dns/matrix"

GIT_DIR="$(git rev-parse --show-toplevel)"

if [ -d "$REPO_DIR" ]; then
    # shellcheck disable=SC2164
    cd "$REPO_DIR" || exit 1
    cd "$GIT_DIR" || exit 1

    git pull --rebase origin master

    wget -O source/porn_filters/imported/adult.ShadowWhisperer https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/RAW/Adult

    git commit -am "Updated ShadowWhisperer Adult list"

    git pull --rebase origin master
    git push origin master
fi
