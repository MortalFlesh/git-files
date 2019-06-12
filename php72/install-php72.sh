#!/usr/bin/env bash

# include functions
. ./functions.sh

title "PHP 7.2 - installs"
echo "following installation has deprecations.."
exit 1
# https://gist.github.com/vukanac/e32c71d0d7c1444a1ac61469181ccaa6
brew tap homebrew/homebrew-php
# brew install php56 --without-ldap --without-legacy-mysql --with-httpd24   # apache version
# brew install php71 --without-legacy-mysql --without-ldap --with-httpd24   # apache version
brew install php72 --without-legacy-mysql --without-ldap php72

title "PHP 7.2 - Symlink ini"
# - use ln -s -f ... will override files in your home
ls -FGlh /usr/local/etc/php/7.2/php.ini
ln -s -f ~/www/git-files/php72/php.ini /usr/local/etc/php/7.2/php.ini
ls -FGlh /usr/local/etc/php/7.2/php.ini

title "PHP 7.2 - Symlink FPM config"
# - use ln -s -f ... will override files in your home
ls -FGlh /usr/local/etc/php/7.2/php-fpm.d/www.conf
ln -s -f ~/www/git-files/php72/www.conf /usr/local/etc/php/7.2/php-fpm.d/www.conf
ls -FGlh /usr/local/etc/php/7.2/php-fpm.d/www.conf

title "PHP 7.2 - Run FPM"
sudo brew services start php

title "Done!"
