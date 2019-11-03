#!/usr/bin/env bash

# Exit on any errors
set -e

find $CI_PROJECT_DIR/source/ -type f -name '*.list' -exec bash -c "sort -i -u \
	-f '{}' -o '{}' " \;
