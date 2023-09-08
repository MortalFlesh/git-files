#!/usr/bin/env bash

set -e

# include functions
. ~/www/git-files/functions.sh

title "Kitty 🐱 - install:"
# see: https://sw.kovidgoyal.net/kitty/binary/

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# link config
ln -sf ~/www/git-files/terminal/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/www/git-files/terminal/kitty/config.conf ~/.config/kitty/config.conf
ln -sf ~/www/git-files/terminal/kitty/mf-theme.conf ~/.config/kitty/theme.conf

title "Done"
