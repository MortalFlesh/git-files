#!/bin/bash

####################################
# This is profile for default bash #
####################################

echo "Using default default profile"

export PROFILE="$HOME/.profile"

#
# Git
#

#git-autocomplete
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

#
# include bash-completion
# http://superuser.com/questions/819221/how-to-install-the-debian-bash-completion-using-homebrew
#
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
fi

# Load ssh config
[[ ! -f ~/.profile-ssh ]] || source ~/.profile-ssh

# Load common profiler
[[ ! -f ~/.profile-common ]] || source ~/.profile-common
