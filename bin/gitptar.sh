#!/bin/sh

if [ -d .git  ]; then
    branch=$(git branch | awk '{print $2}');
    for i in $(git remote -v | grep push | awk '{print $1}'); do
        git push "$i" "$branch"
    done
else
    echo "Not a git repository, exiting.";
    exit 1;
fi;
