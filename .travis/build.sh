#!/usr/bin/env bash

# Exit on any errors
set -e

# Sort our lists for doublets and order by alphabet
find $TRAVIS_BUILD_DIR/source/ -type f -name '*.list' -exec bash -c "sort -i -u \
	-f '{}' -o '{}' " \;

# Sort our rpz-nsdname for doublets and order by alphabet
find $TRAVIS_BUILD_DIR/source/ -type f -name '*.rpz-nsdname' -exec bash -c "sort -i -u \
	-f '{}' -o '{}' " \;


# Combine domain and wildcard domains for external usages

cd $TRAVIS_BUILD_DIR/

find $TRAVIS_BUILD_DIR/source/ -type f -name 'combined.txt' -delete

for d in `find source/ -mindepth 1 -maxdepth 1 -type d`
do
    cat ${d[@]}/*.list > ${d[@]}/combined.txt
done

# Import latest working example of safesearch from safesearc.mypdns.cloud
rm $TRAVIS_BUILD_DIR/safesearch/safesearch.mypdns.cloud.rpz

dig axfr @axfr.ipv4.mypdns.cloud -p 5353 safesearch.mypdns.cloud | grep -vE '^($|;)' >> $TRAVIS_BUILD_DIR/safesearch/safesearch.mypdns.cloud.rpz

exit ${?}
