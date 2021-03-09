#!/usr/bin/env bash

. ~/www/git-files/functions.sh

title "Node:"
nvm install v10.16.3
nvm install node
nvm ls

echo "Done"
