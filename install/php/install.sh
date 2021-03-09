#!/usr/bin/env bash

set -e

# include functions
. ~/www/git-files/functions.sh

title "Brew:"
brew install php

title "Sphp"
ln -s -f ~/www/git-files/install/php/sphp /usr/local/bin/sphp

echo "Done"
