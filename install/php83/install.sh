#!/usr/bin/env bash

# include functions
. ~/www/git-files/functions.sh

title "[PHP@8.3] - installs"
brew install php@8.3 # or just php

title "[PHP@8.3] - Backup originals"
mkdir -p ~/www/git-files/install/php83/backup
cp /usr/local/etc/php/8.3/php.ini ~/www/git-files/install/php83/backup/
cp /usr/local/etc/php/8.3/php-fpm.d/www.conf ~/www/git-files/install/php83/backup/

title "[PHP@8.3] - Symlink ini"
# - use ln -s -f ... will override files in your home
ls -FGlh /usr/local/etc/php/8.3/php.ini
ln -s -f ~/www/git-files/install/php83/php.ini /usr/local/etc/php/8.3/php.ini
ls -FGlh /usr/local/etc/php/8.3/php.ini

title "[PHP@8.3] - Symlink FPM config"
echo "-> skipped"
# - use ln -s -f ... will override files in your home
# ls -FGlh /usr/local/etc/php/8.3/php-fpm.d/www.conf
# ln -s -f ~/www/git-files/install/php83/www.conf /usr/local/etc/php/8.3/php-fpm.d/www.conf
# ls -FGlh /usr/local/etc/php/8.3/php-fpm.d/www.conf

title "[PHP@8.3] - Run FPM"
echo "-> skipped"
#sudo brew services start php

title "[PHP@8.3] - Done!"
php --version
