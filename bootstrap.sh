#!/bin/bash -exv
# TODO: make this go through every file/dir in dotfiles repo instead of manually typing which
# files/dirs should be linked

# TODO: install i3, bin scripts, emacs.d, awesome?, Xdefaults
# required programs: urxvt, wmctrl (used for maximizing gvim), vim-gnome, emacs,
# inconsolata font, some stuff for installing youcompleteme, ctags, virtualenv, virtualenvwrapper
# ranger, cmus, i3blocks, curl, LAMP stack, dropbox, libre office suite, ack-grep, fzf, zsh, oh-my-zsh

# TODO: consider these:
# hosts file?
#

# TODO: remove not needed programs?
#

check_programs=(vim-gnome i3 curl cmus ranger zsh \
exuberant-ctags fonts-inconsolata rxvt-unicode-265color \
ack-grep)

install_programs=()

if [ $(whoami) != 'root' ]; then
    echo "Insufficient privileges found. Must be root."
    echo "Exiting."
    exit 1;
fi

echo "Updating sources list..."
#apt-get update
echo "Checking previous installations..."
for program in ${check_programs[@]}; do
    echo "Checking $program"
    if dpkg -s $program >/dev/null 2>&1; then
        echo "found $program"
    else
        echo "$program not found."
        echo "Searching for $program in repositories."
        search="$(apt-cache search $program)"
        if [ -n "$search" ]; then
            echo "Adding $program to install list."
            install_programs+=($program)
        else
            echo "Couldn't find $program, skipping."
        fi
        echo "Checking complete."
    fi
done

echo "Installing required programs..."
for program in ${install_programs[@]}; do
    echo "Installing $program"
    apt-get install $program
done

echo "All done."
echo "Welcome on board, Commander."
