#!/bin/bash

set -e

echo "travis_deploy.sh started"
echo $GITHUB_TOKEN > ~/.git-credentials && chmod 0600 ~/.git-credentials
git config --global credential.helper store
git config --global user.email "admin@thefullertonian.com"
git config --global user.name "Travis.ci as Mark Stouffer"
git config --global push.default simple

echo "pushing to deployment/"
rm -rf deployment
git clone -b master https://github.com/InTEGr8or/hugo_nofakingway deployment
rsync -av --delete --exclude ".git" public/ deployment
cd deployment
git add -A
# we need the || true, as sometimes you do not have any content changes
# and git woundn't commit and you don't want to break the CI because of that
git commit -m "rebuilding site on `date`, commit ${TRAVIS_COMMIT} and job ${TRAVIS_JOB_NUMBER}" || true
git push

cd ..
rm -rf deployment
