#!/usr/bin/env bash

set -e

# include functions
. ~/www/git-files/functions.sh

title "Profile:"
ln -s -f ~/www/git-files/.profile-common ~/.profile-common
ln -s -f ~/www/git-files/.profile ~/.profile
. ~/.profile

title "Profile for bash:"
ln -s -f ~/www/git-files/.bashrc ~/.bashrc

title "Karabiner profile:"
mkdir -p ~/.config/karabiner
rm -rf ~/.config/karabiner
ln -s -f ~/www/git-files/karabiner/ ~/.config/karabiner
