#!/usr/bin/env bash

# include functions
. ./functions.sh

title "Dependencies":
brew install wget

mkdir -p ~/bin

title "Symlinks:"
# - use ln -s -f ... will override files in your home
ln -s -f ~/www/git-files/.gitconfig ~/.gitconfig
ln -s -f ~/www/git-files/.git-completion.bash ~/.git-completion.bash
ln -s -f ~/www/git-files/.git-config.bash ~/.git-config.bash
ln -s -f ~/www/git-files/.gitignore_global ~/.gitignore_global

title "Sublime 3:"
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/sublime

title "NVM and Node:"
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
command -v nvm
nvm install node

title "Profile:"
ln -s -f ~/www/git-files/.profile ~/.profile
. ~/.profile

title "Done!"
