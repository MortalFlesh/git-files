#!/usr/bin/env bash

# include functions
. ~/www/git-files/functions.sh

title "[PHP@8.2] - installs"
brew install php@8.2 # or just php

title "[PHP@8.2] - Backup originals"
mkdir -p ~/www/git-files/install/php82/backup
cp /opt/homebrew/etc/php/8.2/php.ini ~/www/git-files/install/php82/backup/
cp /usr/local/etc/php/8.2/php-fpm.d/www.conf ~/www/git-files/install/php82/backup/

title "[PHP@8.2] - Symlink ini"
# - use ln -s -f ... will override files in your home
ls -FGlh /opt/homebrew/etc/php/8.2/php.ini
ln -s -f ~/www/git-files/install/php82/php.ini /opt/homebrew/etc/php/8.2/php.ini
ls -FGlh /opt/homebrew/etc/php/8.2/php.ini

title "[PHP@8.2] - Symlink FPM config"
echo "-> skipped"
# - use ln -s -f ... will override files in your home
# ls -FGlh /usr/local/etc/php/8.2/php-fpm.d/www.conf
# ln -s -f ~/www/git-files/install/php82/www.conf /usr/local/etc/php/8.2/php-fpm.d/www.conf
# ls -FGlh /usr/local/etc/php/8.2/php-fpm.d/www.conf

title "[PHP@8.2] - Run FPM"
echo "-> skipped"
#sudo brew services start php

title "[PHP@8.2] - Done!"
php --version
