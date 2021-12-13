#!/usr/bin/env bash

set -e

# include functions
. ~/www/git-files/functions.sh

title "Brew:"
brew install php brew-php-switcher

echo "Done"
