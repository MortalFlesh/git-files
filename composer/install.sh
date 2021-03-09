#!/usr/bin/env bash

# include functions
. ~/www/git-files/functions.sh

set -e

title "Info"
composer --version

title "Link global composer"
mkdir -p ~/.composer
ln -sf ~/www/git-files/composer/composer.json ~/.composer/composer.json
ln -sf ~/www/git-files/composer/composer.lock ~/.composer/composer.lock

title "Install global dependencies"
composer global install

title "Link global tools"
mkdir -p ~/phive/tools
ln -sf ~/.composer/vendor/maglnet/composer-require-checker/bin/composer-require-checker ~/phive/tools/require-checker

title "Done!"
