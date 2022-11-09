#!/bin/bash

echo "amount,timestamp" > amounts.csv

for commit in $(git log --pretty=format:%h sitewide_raised_amount.txt)
do
  echo "$(git show ${commit}:sitewide_raised_amount.txt),$(git show -s --format=%at ${commit})" >> amounts.csv
done
