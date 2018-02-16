#!/usr/bin/env bash
# https://gist.github.com/dtomasi/ab76d14338db82ec24a1fc137caff75b

# include functions
. ./functions.sh

title "Disable local mac apache"
# https://tosbourn.com/turn-off-the-built-in-apache-on-osx/
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist


title "PHP 7.2 - installs"
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
sudo brew services start homebrew/php/php72


title "Nginx - installs"
brew install nginx

title "Nginx - PHP FPM"
ln -s -f ~/www/git-files/nginx/php-fpm /usr/local/etc/nginx/conf.d/php-fpm

title "Nginx - make missing dirs"
mkdir -p /usr/local/etc/nginx/sites-available && \
  mkdir -p /usr/local/etc/nginx/sites-enabled && \
  mkdir -p /usr/local/etc/nginx/conf.d && \
  mkdir -p /usr/local/etc/nginx/ssl

title "Nginx - Symlink conf"
ln -s -f ~/www/git-files/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf

title "Nginx - vhosts - default"
ln -s -f ~/www/git-files/nginx/vhosts/default /usr/local/etc/nginx/sites-available/default
ln -s -f ~/www/git-files/nginx/vhosts/default /usr/local/etc/nginx/sites-enabled/default

if [ -f ~/www/nginx-vhosts/link.sh ]; then
    title "Nginx - vhosts - private"
    . ~/www/nginx-vhosts/link.sh
fi

title "Nginx - autostart"
sudo cp /usr/local/opt/nginx/*.plist /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/homebrew.mxcl.nginx.plist


title "Nginx - check"
brew services list
sudo nginx -t
sudo lsof -n -i:80


title "Done!"
