#!/usr/bin/env bash

set -e

REPO_DIR="$HOME/Documents/repo"
GIT_DIR="$REPO_DIR/git-files"
RPI_DIR="$GIT_DIR/install/raspberry-pi"

# include functions
. "$GIT_DIR/functions.sh"

title "Symlinks:"
# - use ln -s -f ... will override files in your home
ln -s -f "$RPI_DIR/.gitconfig" "$HOME/.gitconfig"
ln -s -f "$DIR/.git-completion.bash" "$HOME/.git-completion.bash"
ln -s -f "$RPI_DIR/.gitignore_global" "$HOME/.gitignore_global"

title "Profile:"
ln -s -f "$RPI_DIR/.profile-rpi" "$HOME/.profile-rpi"

subTitle "Add loading .profile-rpi to .profile"
echo """

# include .profile-rpi if it exists
if [ -f \"\$HOME/.profile-rpi\" ]; then
    . \"\$HOME/.profile-rpi\"
fi
""" >> "$HOME/.profile"

subTitle "Reloading profile ..."
. ~/.profile

title "Done!"
echo "Now restart terminal and run other installations."
