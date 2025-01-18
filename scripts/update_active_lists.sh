#!/usr/bin/env bash

# This script is intended to list all active lists from the data/
# directory for easier imports from external sources....
# Happy harvesting :)

GIT_GIR="$(git rev-parse --show-toplevel)"

truncate -s 0 "$GIT_GIR/source/source.csv"

cd "$GIT_GIR" || exit

find source/ -type f -name "*.csv" | \
    -ecex -P4 -I {} echo "https://raw.githubusercontent.com/mypdns/matrix/master/{}" \
    >> "$GIT_GIR/source/source.csv"

sort -u "$GIT_GIR/source/source.csv" -o "$GIT_GIR/source/source.csv"

ls -lh "$GIT_GIR/source/"
