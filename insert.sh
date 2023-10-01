#!/bin/bash

# get the commit hash of the latest commit of sitewide_raised_amount.txt
commit=$(git log -1 --pretty=format:%h sitewide_raised_amount.txt)

# get the amount from the latest commit of sitewide_raised_amount.txt
amount=$(git show ${commit}:sitewide_raised_amount.txt)

# get the timestamp from the latest commit of sitewide_raised_amount.txt
timestamp=$(git show -s --format=%at ${commit})

# insert the amount and timestamp into amounts.csv on the second line
sed -i "2i${amount},${timestamp}" amounts.csv
