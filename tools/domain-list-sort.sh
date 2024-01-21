#!/usr/bin/env sh

## This script should be placed in pre-commit-hooks

GIT_DIR="$(git rev-parse --show-toplevel)"

if [ -d "$GIT_DIR" ]; then
    # shellcheck disable=SC2164
    cd "${GIT_DIR}" || exit 1

    for i in $(git ls-files -m | grep -i "domains.list"); do
        python3.11 "$GIT_DIR/tools/domain-sort.py" <"${i}" >"${i}.tmp" &&
            sed "/^$/d" "${i}.tmp" >"${i}" && rm "${i}.tmp"
    done

fi
