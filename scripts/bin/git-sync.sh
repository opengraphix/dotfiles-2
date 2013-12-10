#!/bin/sh

set -e

echo "Sync'ing $PWD"
date

NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

GIT_BRANCH=`git branch --no-color | grep --color=never -E "\*\s+.*" | tr -d "* "`

if [[ $2 == "" ]]
then
    GIT_REMOTE_NAME='origin'
else
    GIT_REMOTE_NAME=$2
fi

GIT_REMOTE_URI="${GIT_REMOTE_NAME}/${GIT_BRANCH}"
STAGING_BRANCH="sync-${NEW_UUID}"
MODIFIED_FILES=`git status --short --porcelain -uno | wc -l | tr -d ' '`

if [[ ! $MODIFIED_FILES == "0" ]]
then
    echo "Couldn't sync local branch $GIT_BRANCH in $PWD from ${GIT_REMOTE}/${GIT_BRANCH}"
    git status --short -uno
    exit 1
fi

echo "Fetch latest commits from $GIT_REMOTE_URI"
git fetch $GIT_REMOTE_NAME $GIT_BRANCH

if [[ `git diff $GIT_REMOTE_URI | wc -l | tr -d ' '` == "0" ]]
then
    echo "Already up-to-date, bro. Sync exiting..."
    exit 0
fi

echo "Create staging branch $STAGING_BRANCH"
git branch $STAGING_BRANCH
echo "Replay $STAGING_BRANCH on top of ${GIT_REMOTE_URI}"
git rebase "${GIT_REMOTE_URI}" $STAGING_BRANCH
echo "Diff between $GIT_BRANCH and $STAGING_BRANCH"
git diff --minimal $GIT_BRANCH $STAGING_BRANCH
git checkout $GIT_BRANCH
git rebase $STAGING_BRANCH
echo "Updating submodules (if any)"
git submodule update --init --recursive

git branch -D -v $STAGING_BRANCH
echo "Done"
