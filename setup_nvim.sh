#!/usr/bin/env bash

set -euo pipefail

nvim_dir="$HOME/.config/nvim"
init_lua="$HOME/.config/nvim/init.lua"

if [ ! -d "$nvim_dir" ]; then
    mkdir "$nvim_dir"
fi


if [ ! -f "$init_lua" ]; then
    ln -s ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
fi

ln -s ~/dotfiles/nvim/lua ~/.config/nvim/lua
