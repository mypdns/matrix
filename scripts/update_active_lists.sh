#!/usr/bin/env bash

# This script is intended to list all active lists from the data/
# directory for easier imports from external sources....
# Happy harvesting :)

GIT_GIR="$(git rev-parse --show-toplevel)"

truncate -s 0 "$GIT_GIR/source/source.list"

cd "$GIT_GIR" || exit

for lists in $(find source/ -type f -name "*.list"); do
    printf "https://raw.githubusercontent.com/mypdns/matrix/master/source/%S\n" "$lists" | sort -u >>"$GIT_GIR/source/source.list"
    printf "%s/-/raw/master/%s\n" "$CI_PROJECT_URL" "$lists" | sort -u >>"$GIT_GIR/source/source.list"
done

ls -lh "$GIT_GIR/source/"
