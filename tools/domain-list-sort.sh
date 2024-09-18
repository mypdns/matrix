#!/usr/bin/env sh

## This script should be placed in pre-commit-hooks
# set -xe

GIT_DIR="$(git rev-parse --show-toplevel)"

if [ -d "$GIT_DIR" ]; then
    cd "${GIT_DIR}" || exit 1

    for i in $(git ls-files -m | grep -i "domains.list"); do
        python3 "$GIT_DIR/tools/domain-sort.py" <"${i}" | sort -u >"${i}.tmp" &&
            sed "/^$/d" "${i}.tmp" >"${i}" && rm "${i}.tmp"
    done

    for i in $(git ls-files -m | grep -i "hosts.list"); do
            python3 "$GIT_DIR/tools/domain-sort.py" <"${i}" | sort -u >"${i}.tmp" &&
                sed "/^$/d" "${i}.tmp" >"${i}" && rm "${i}.tmp"
    done

fi
