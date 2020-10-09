#!/bin/bash

# include functions
. ~/www/git-files/functions.sh

title "Link Profile:"
ln -s -f ~/www/git-files/zsh/.zshrc ~/.zshrc

title "Check zsh"
$SHELL --version
subTitle "Above result should be: zsh 5.4.2 (or higher)"

title "Link Theme:"
ln -s -f ~/www/git-files/zsh/.p10k.zsh ~/.p10k.zsh

echo "done"
