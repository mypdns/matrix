#!/usr/bin/env bash

# Exit on any errors
set -e

find source/ -type f -name '*.list' -exec bash -c "sort -i -u -f '{}' -o '{}' " \;
