#!/usr/bin/env bash

# This script is intended to list all active lists from the data/
# directory for easier imports from external sources....
# Happy harvesting :)

GIT_GIR="$(git rev-parse --show-toplevel)"

truncate -s 0 "$GIT_GIR/source/source.csv"

cd "$GIT_GIR" || exit

# for i in
 find source/ -type f -name "*.csv" | while IFS= read -r i; do
    echo "https://raw.githubusercontent.com/mypdns/matrix/master/source/$i" \
        | sort -u >>"$GIT_GIR/source/source.csv"
    # echo "$CI_PROJECT_URL/-/raw/master/$i" | sort -u
    # >>"$GIT_GIR/source/source.csv"
done

ls -lh "$GIT_GIR/source/"
