#!/bin/sh

# Run this script as cron task
# set -x

GIT_DIR="$(git rev-parse --show-toplevel)"

if [ -d "$GIT_DIR" ]; then
    # shellcheck disable=SC2164
    cd "$GIT_DIR" || exit 1

    git pull --rebase origin master

    wget -O "$GIT_DIR/source/porn_filters/imported/adult.ShadowWhisperer" \
        https://raw.githubusercontent.com/ShadowWhisperer/BlockLists/master/RAW/Adult

    git commit -am "Updated ShadowWhisperer Adult list"

    git push origin master || git pull --rebase origin master && git push origin master

fi
