#!/usr/bin/env bash

# This script is intended to list all active lists from the data/
# directory for easier imports from external sources....
# Happy havesting :)

truncate -s 0 "$CI_PROJECT_DIR/source.list"

cd "$CI_PROJECT_DIR"

for lists in `find source/ -type f -name "*.list"`
do
	printf "$CI_PROJECT_URL/raw/master/$lists\n" | sort -u >> "$CI_PROJECT_DIR/source.list"
done

ls -lh $CI_PROJECT_DIR/
