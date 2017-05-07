#!/bin/sh

# TODO: make it discover if it's git project by traversing tree

if [ -d .git  ]; then
    branch=$(git branch | grep "\*" | awk '{print $2}');
    for i in $(git remote -v | grep push | awk '{print $1}'); do
        git push "$i" "$branch"
    done
else
    echo "Not a git repository, exiting.";
    exit 1;
fi;
