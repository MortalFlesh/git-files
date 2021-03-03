#!/bin/bash

# include functions
. ~/www/git-files/functions.sh

title "Install oh-my-zsh"
# chsh -s "$(which zsh)"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

title "Install Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

title "Link Profile:"
ln -s -f ~/www/git-files/zsh/.zshrc ~/.zshrc

title "Check zsh"
$SHELL --version
subTitle "Above result should be: zsh 5.4.2 (or higher)"

title "Link Theme:"
ln -s -f ~/www/git-files/zsh/.p10k.zsh ~/.p10k.zsh

echo "done"
