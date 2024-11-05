#!/usr/bin/env bash

# Copyright: https://mypdns.org/
# Content: https://kb.mypdns.org/users/spirillen
# Source: https://github.com/mypdns/matrix
# LICENCE: https://github.com/mypdns/matrix/blob/master/LICENCE.md
# LICENCE Comment: GNU AGPLv3, MODIFIED FOR NON COMMERCIAL USE
#
# LICENCE in short:
# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included.
#
# Please forward any additions, corrections or comments by logging an
# issue at https://kb.mypdns.org/issues?q=project:%20Matrix

# Exit on any errors
set -e

# Determine CI root dir
if [ -d "${TRAVIS_BUILD_DIR}" ]; then
    ROOT_DIR="${TRAVIS_BUILD_DIR}"

elif [ -d "${CI_BUILDS_DIR}" ]; then
    ROOT_DIR="${CI_BUILDS_DIR}"

else
    printf "\nNo CI Dir found\n"
    exit 1
fi

# Sort our lists for doublets and order by alphabet
find "$ROOT_DIR/source/" -type f -name '*.list' -exec \
    bash -c "awk '{$1=$1}1' '{}' | sort -i -u -o '{}' " \;

# Sort our rpz-nsdname for doublets and order by alphabet
find "$ROOT_DIR/source/" -type f -name '*.rpz-nsdname' -exec bash -c "sort -i -u \
	-f '{}' -o '{}' " \;

# Combine domain and wildcard domains for external usages

cd "$ROOT_DIR/"

find "$ROOT_DIR/source/" -type f -name 'combined.txt' -delete

for d in $(find source/ -mindepth 1 -maxdepth 1 -type d); do
    cat "${d[@]}/*.list" >"${d[@]}/combined.txt"
done

# Import latest working example of safesearch from safesearc.mypdns.cloud
# rm "$ROOT_DIR/safesearch/safesearch.mypdns.cloud.rpz"

# dig axfr @axfr.mypdns.cloud -p 5353 safesearch.mypdns.cloud | \
#     grep -vE '^($|;)' >> "$ROOT_DIR/safesearch/safesearch.mypdns.cloud.rpz"

exit ${?}
