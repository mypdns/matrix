#!/usr/bin/env bash

# Exit on any errors
set -e -u

find -name '*.sh' -exec shellcheck '{}' \;
