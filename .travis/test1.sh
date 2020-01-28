#!/usr/bin/env bash

# Exit on any errors
set -e

find $TRAVIS_BUILD_DIR/source/ -type f -name '*.list' -exec bash -c "sort -i -u \
	-f '{}' -o '{}' " \;

# Combine domain and wildcard domains for external usages

cd $TRAVIS_BUILD_DIR/

find $TRAVIS_BUILD_DIR/source/ -type f -name 'combined.txt' -delete

for d in `find source/ -mindepth 1 -maxdepth 1 -type d`
do
    cat ${d[@]}/*.list > ${d[@]}/combined.txt
done

exit ${?}
