#!/bin/bash

set -euo pipefail

# get the commit hash of the latest commit of sitewide_raised_amount.txt
commit=$(git log -1 --pretty=format:%h sitewide_raised_amount.txt)

# get the amount from the latest commit of sitewide_raised_amount.txt
amount=$(git show ${commit}:sitewide_raised_amount.txt)

# refuse to insert a row without a valid amount
if ! [[ "$amount" =~ ^[0-9]+$ ]]; then
  echo "::error::sitewide_raised_amount.txt does not contain a valid amount: '${amount}'" >&2
  exit 1
fi

# get the timestamp from the latest commit of sitewide_raised_amount.txt
timestamp=$(git show -s --format=%at ${commit})

# insert the amount and timestamp into amounts.csv on the second line
sed -i "2i${amount},${timestamp}" amounts.csv
