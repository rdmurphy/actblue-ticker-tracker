#!/bin/bash

# Insert the header
echo "amount,timestamp" > diff.csv

# Loop through the commits and generate the file
for commit in $(git log --pretty=format:%h sitewide_raised_amount.txt)
do
  echo "$(git show ${commit}:sitewide_raised_amount.txt),$(git show -s --format=%at ${commit})" >> diff.csv
done

# Compare the generated version with the current version
diff -u amounts.csv diff.csv
