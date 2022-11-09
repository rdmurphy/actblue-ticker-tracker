#!/bin/bash

# our input/output file
FILE=sitewide_raised_amount.txt

PREVIOUS_AMOUNT=$(cat ${FILE})
NEW_AMOUNT=$(curl https://secure.actblue.com/metrics/bignumber | jq --raw-output .sitewide_raised_amount | sed 's/,//g')

echo -n "$NEW_AMOUNT" > "$FILE"

DIFFERENCE=$((${NEW_AMOUNT} - ${PREVIOUS_AMOUNT}))

echo "difference=${DIFFERENCE}" >> $GITHUB_ENV
