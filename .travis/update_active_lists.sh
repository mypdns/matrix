#!/usr/bin/env bash

# This script is intended to list all active lists from the data/
# directory for easier imports from external sources....
# Happy havesting :)
set -e
set -x

truncate -s 0 "$TRAVIS_BUILD_DIR/source.list"

cd "$TRAVIS_BUILD_DIR"

for lists in `find source/ -type f -name "*.list"`
do
    printf "https://raw.githubusercontent.com/mypdns/matrix/master/$lists\n" | sort -u >> "$TRAVIS_BUILD_DIR/source.list"
done

#ls -lh $TRAVIS_BUILD_DIR/
