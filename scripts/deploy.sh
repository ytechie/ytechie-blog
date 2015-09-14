#!/bin/bash

cd out

echo 'Initializing repository...'
git init

echo 'Configuring environment...'
git config user.name "Travis CI"
git config user.email "jason@ytechie.com"

echo 'Adding files to local repo...'
git add .
echo 'Comitting local files...'
git commit -m "Deploy"

# We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
echo 'Pushing to Git'
git push --force "https://${git_user}:${git_password}@${git_target}" master:master > /dev/null 2>&1
echo 'Git push complete'

exit 0