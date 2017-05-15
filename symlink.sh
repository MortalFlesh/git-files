#!/usr/bin/env bash

# use ln -s -f ... will override files in your home

ln -s -f ~/www/git-files/.gitconfig ~/.gitconfig
ln -s -f ~/www/git-files/.git-completion.bash ~/.git-completion.bash
ln -s -f ~/www/git-files/.git-config.bash ~/.git-config.bash
ln -s -f ~/www/git-files/.gitignore_global ~/.gitignore_global

ln -s -f ~/www/git-files/.profile ~/.profile

. ~/.profile

echo "Done!"
