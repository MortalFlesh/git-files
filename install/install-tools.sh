#!/usr/bin/env bash

set -e

# include functions
. ~/www/git-files/functions.sh

title "Symlinks:"
# - use ln -s -f ... will override files in your home
ln -s -f ~/www/git-files/.gitconfig ~/.gitconfig
ln -s -f ~/www/git-files/.git-completion.bash ~/.git-completion.bash
ln -s -f ~/www/git-files/.git-config.bash ~/.git-config.bash
ln -s -f ~/www/git-files/.gitignore_global ~/.gitignore_global

title "Sublime 3:"
ln -s -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/sublime

title "Phive tools:"
mkdir -p ~/phive
ln -s -f ~/www/git-files/phive/phive.xml ~/phive/phive.xml

title "NVM:"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
command -v nvm
