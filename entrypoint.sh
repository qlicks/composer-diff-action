#!/bin/bash

set -e

OUTPUT=$(composer diff $*)
echo "$OUTPUT"

OUTPUT=$(echo "$OUTPUT" | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g')
#OUTPUT="${OUTPUT//'%'/'%25'}"
#OUTPUT="${OUTPUT//$'\n'/'%0A'}"
#OUTPUT="${OUTPUT//$'\r'/'%0D'}"

PR_NUMBER=$(echo $CI_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')

curl -s -H "Authorization: token ${GITHUB_TOKEN} " -X POST -d '{"body": "$OUTPUT"}' "${GITHUB_API_URL}/repos/${GITHUB_REPOSITORY_OWNER}/${CI_REPOSITORY_NAME}/issues/${PR_NUMBER}/comments"

echo "::set-output name=composer_diff::$OUTPUT"
echo $OUTPUT > composer.diff
