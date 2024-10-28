#!/usr/bin/env sh

## This script should be placed in pre-commit-hooks
# set -xe

GIT_DIR="$(git rev-parse --show-toplevel)"

if [ -d "$GIT_DIR" ]; then
    cd "${GIT_DIR}" || exit 1

    for i in $(git ls-files -m | grep -iE "(domains|hosts).csv"); do
            python3 "$GIT_DIR/tools/domain-sort.py" <"${i}" | \
            sort -u --parallel="$(nproc --ignore=1)" | uniq -u >"${i}.tmp" &&
            sed "/^$/d" "${i}.tmp" >"${i}" && rm "${i}.tmp"
        done

    for i in $(git ls-files -m | grep -iE "(domains\.rpz-nsdname|onions|wildcard|rpz-ip).csv"); do
            sort -u --parallel="$(nproc --ignore=1)" "${i}" | \
            uniq -u >"${i}.tmp" && sed "/^$/d" "${i}.tmp" >"${i}" && \
            rm "${i}.tmp"
        done

fi
