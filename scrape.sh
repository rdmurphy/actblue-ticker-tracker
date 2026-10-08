#!/bin/bash

set -euo pipefail

# our input/output file
FILE=sitewide_raised_amount.txt
URL=https://secure.actblue.com/metrics/bignumber.json

PREVIOUS_AMOUNT=$(cat ${FILE})

# --fail makes curl exit non-zero on HTTP errors (like a 404) instead of
# happily passing along an error page
RESPONSE=$(curl --fail --silent --show-error --retry 3 "$URL")

# jq exits non-zero if the response isn't JSON; a missing key comes back as ""
NEW_AMOUNT=$(echo "$RESPONSE" | jq --raw-output '.sitewide_raised_amount // empty' | sed 's/,//g')

# make sure we actually got a number before we overwrite anything
if ! [[ "$NEW_AMOUNT" =~ ^[0-9]+$ ]]; then
  echo "::error::Did not get a valid amount from ${URL}. Response was: ${RESPONSE}" >&2
  exit 1
fi

echo -n "$NEW_AMOUNT" > "$FILE"

DIFFERENCE=$((${NEW_AMOUNT} - ${PREVIOUS_AMOUNT:-0}))

echo "difference=${DIFFERENCE}" >> $GITHUB_ENV
