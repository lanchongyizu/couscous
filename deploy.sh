#!/bin/bash

set -ex

if [ -n "$GITHUB_TOKEN" ]; then
    USER=lanchongyizu
    USER_NAME="Jamie Zhuang"
    USER_EMAIL=$USER@gmail.com
    REPO=https://$USER:$GITHUB_TOKEN@github.com/$USER/$USER.github.io.git
    MSG=`git log --format=%B -n 1`
    git submodule add -b master $REPO public
    hugo
    cd public
    git add .
    cachedFiles=`git diff --cached --name-only`
    if [ -n "$cachedFiles" ]; then
        git -c user.name="$USER_NAME" -c user.email="$USER_EMAIL" commit -m "$MSG"
        git push origin master
    fi
fi
