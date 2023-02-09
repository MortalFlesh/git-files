#!/usr/bin/env bash

# include functions
. ~/www/git-files/functions.sh

title "Update oh-my-zsh"
# see https://stackoverflow.com/questions/17648621/how-do-i-update-zsh-to-the-latest-version
omz update
omz version

title "Update Powerlevel10k"
# see https://github.com/romkatv/powerlevel10k#how-do-i-update-powerlevel10k
git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull

title "Check zsh"
$SHELL --version
subTitle "Above result should be: zsh 5.4.2 (or higher)"

echo "done"
