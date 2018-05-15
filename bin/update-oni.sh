#!/bin/zsh

set -euo pipefail

release_url=$(curl -s -L https://github.com/onivim/oni/releases/latest | grep releases/download | grep amd64-linux | grep -o -P '"[a-zA-Z_\-.\/0-9]+"' | head -n 1 | tr -d '"')

final_download_url="https://github.com$release_url"

cd /tmp

wget -O oni.deb $final_download_url

sudo dpkg -i oni.deb

rm oni.deb
