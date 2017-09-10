#!/bin/bash -x

set -euo pipefail

user=$1
host=$2
path=$3

if [ -d ~/backups ]; then
    backup_target=~/backups
else
    backup_target=.
fi

ssh $user@$host "tar -P -zcf - $path" > $path.tar.gz