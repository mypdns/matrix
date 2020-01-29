#!/usr/bin/env bash

# Exit on any errors
set -e
#set -x

PrepareTravis () {
    git remote rm origin
    git remote add origin https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git
    git config --global user.email "${GIT_EMAIL}"
    git config --global user.name "${GIT_NAME}"
    git config --global push.default simple
    git checkout "${GIT_BRANCH}"
    ulimit -u
}
PrepareTravis

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

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    printf "Skipping deploy; just doing a build."
    #syntaxTest
    exit 0
fi

# If there are no changes to the compiled out (e.g. this is a README update) then just bail.
if git diff --quiet; then
    printf "No changes to the output on this push; exiting."
    exit 0
fi

#syntaxTest () {
#	printf "\n\tHere we will do a syntax test and convert input to IDNA domains\n"
#}

exit ${?}
