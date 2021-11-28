#!/usr/bin/env bash

# This script is intended to list all active lists from the data/
# directory for easier imports from external sources....
# Happy harvesting :)

ROOT_DIR="$(git rev-parse --show-toplevel)"

truncate -s 0 "$ROOT_DIR/source/source.list"

cd "$ROOT_DIR"

for lists in `find source/ -type f -name "*.list"`
do
	printf "https://raw.githubusercontent.com/mypdns/matrix/master/source/$lists\n" | sort -u >> "$ROOT_DIR/source/source.list"
	printf "$CI_PROJECT_URL/-/raw/master/$lists\n" | sort -u >> "$ROOT_DIR/source/source.list"
done

ls -lh $ROOT_DIR/source/
