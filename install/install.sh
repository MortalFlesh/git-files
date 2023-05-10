#!/usr/bin/env bash

set -e

# include functions
. ~/www/git-files/functions.sh

# install brew
. ~/www/git-files/install/install-brew.sh
. ~/www/git-files/install/install-tools.sh
. ~/www/git-files/install/install-profiles.sh

title "Done!"
echo "Now restart terminal and run other installations."
