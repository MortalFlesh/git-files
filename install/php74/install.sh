#!/usr/bin/env bash

# include functions
. ~/www/git-files/functions.sh

title "[PHP@7.4] - installs"
brew install php@7.4 # or just php

title "[PHP@7.4] - Backup originals"
mkdir -p ~/www/git-files/install/php74/backup
cp /usr/local/etc/php/7.4/php.ini ~/www/git-files/install/php74/backup/
cp /usr/local/etc/php/7.4/php-fpm.d/www.conf ~/www/git-files/install/php74/backup/

title "[PHP@7.4] - Symlink ini"
# - use ln -s -f ... will override files in your home
ls -FGlh /usr/local/etc/php/7.4/php.ini
ln -s -f ~/www/git-files/install/php74/php.ini /usr/local/etc/php/7.4/php.ini
ls -FGlh /usr/local/etc/php/7.4/php.ini

title "[PHP@7.4] - Symlink FPM config"
# - use ln -s -f ... will override files in your home
ls -FGlh /usr/local/etc/php/7.4/php-fpm.d/www.conf
ln -s -f ~/www/git-files/install/php74/www.conf /usr/local/etc/php/7.4/php-fpm.d/www.conf
ls -FGlh /usr/local/etc/php/7.4/php-fpm.d/www.conf

title "[PHP@7.4] - Run FPM"
sudo brew services start php

title "[PHP@7.4] - Done!"
php --version
