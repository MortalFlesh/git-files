#!/usr/bin/env bash

set -e

DIR="$HOME/Documents/repo/git-files"
DIR_RPI="$DIR/raspberry-pi"

# include functions
. "$DIR/functions.sh"

title "Symlinks:"
# - use ln -s -f ... will override files in your home
ln -s -f "$DIR_RPI/.gitconfig" "$HOME/.gitconfig"
ln -s -f "$DIR/.git-completion.bash" "$HOME/.git-completion.bash"
ln -s -f "$DIR_RPI/.gitignore_global" "$HOME/.gitignore_global"

title "Profile:"
ln -s -f "$DIR_RPI/.profile-rpi" "$HOME/.profile-rpi"

subTitle "Add loading .profile-rpi to .profile"
echo """

# include .profile-rpi if it exists
if [ -f \"$HOME/.profile-rpi\" ]; then
    . \"$HOME/.profile-rpi\"
fi
""" >> "$HOME/.profile"

subTitle "Reloading profile ..."
. ~/.profile

title "Done!"
echo "Now restart terminal and run other installations."
