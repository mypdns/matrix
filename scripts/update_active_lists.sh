#!/usr/bin/env bash

# This script is intended to list all active lists from the data/
# directory for easier imports from external sources....
# Happy harvesting :)

ROOT_DIR="$(git rev-parse --show-toplevel)"

truncate -s 0 "$ROOT_DIR/source/source.list"

cd "$ROOT_DIR" || exit

for lists in $(find source/ -type f -name "*.list")
do
	printf "https://raw.githubusercontent.com/mypdns/matrix/master/source/%S\n" "$lists" | sort -u >> "$ROOT_DIR/source/source.list"
	printf "%s/-/raw/master/%s\n" "$CI_PROJECT_URL" "$lists" | sort -u >> "$ROOT_DIR/source/source.list"
done

ls -lh "$ROOT_DIR/source/"
