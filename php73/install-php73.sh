#!/bin/bash

# include functions
. ./functions.sh

title "PHP 7.3 - installs"
brew install php@73 # or just php

title "PHP 7.3 - Symlink ini"
# - use ln -s -f ... will override files in your home
ls -FGlh /usr/local/etc/php/7.3/php.ini
ln -s -f ~/www/git-files/php73/php.ini /usr/local/etc/php/7.3/php.ini
ls -FGlh /usr/local/etc/php/7.3/php.ini

title "PHP 7.3 - Symlink FPM config"
# - use ln -s -f ... will override files in your home
ls -FGlh /usr/local/etc/php/7.3/php-fpm.d/www.conf
ln -s -f ~/www/git-files/php73/www.conf /usr/local/etc/php/7.3/php-fpm.d/www.conf
ls -FGlh /usr/local/etc/php/7.3/php-fpm.d/www.conf

title "PHP 7.3 - Run FPM"
sudo brew services start php

title "Done!"
