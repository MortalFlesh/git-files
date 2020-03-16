#!/bin/bash
# https://gist.github.com/dtomasi/ab76d14338db82ec24a1fc137caff75b

# include functions
. ~/www/git-files/functions.sh

title "Disable local mac apache"
# https://tosbourn.com/turn-off-the-built-in-apache-on-osx/
sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist


# ---- same as install-php.sh -------------
# title "PHP 7.2 - installs"
# echo "Check and install correct PHP (phpXY/install-phpXY.sh)"
# exit 1
# # https://gist.github.com/vukanac/e32c71d0d7c1444a1ac61469181ccaa6
# brew tap homebrew/homebrew-php
# # brew install php56 --without-ldap --without-legacy-mysql --with-httpd24   # apache version
# # brew install php71 --without-legacy-mysql --without-ldap --with-httpd24   # apache version
# brew install php72 --without-legacy-mysql --without-ldap php72
#
# title "PHP 7.2 - Symlink ini"
# # - use ln -sf ... will override files in your home
# ls -FGlh /usr/local/etc/php/7.2/php.ini
# ln -sf ~/www/git-files/php72/php.ini /usr/local/etc/php/7.2/php.ini
# ls -FGlh /usr/local/etc/php/7.2/php.ini
#
# title "PHP 7.2 - Symlink FPM config"
# # - use ln -sf ... will override files in your home
# ls -FGlh /usr/local/etc/php/7.2/php-fpm.d/www.conf
# ln -sf ~/www/git-files/php72/www.conf /usr/local/etc/php/7.2/php-fpm.d/www.conf
# ls -FGlh /usr/local/etc/php/7.2/php-fpm.d/www.conf
#
# title "PHP 7.2 - Run FPM"
# sudo brew services start php
# --------------------------------------------


title "[Nginx] - installs"
brew install nginx

title "[Nginx] - make missing dirs"
mkdir -p /usr/local/etc/nginx/sites-available && \
  mkdir -p /usr/local/etc/nginx/sites-enabled && \
  mkdir -p /usr/local/etc/nginx/conf.d && \
  mkdir -p /usr/local/etc/nginx/ssl && \
  sudo mkdir -p /var/log/nginx/

title "[Nginx] - PHP FPM"
ln -sf ~/www/git-files/install/nginx/php-fpm /usr/local/etc/nginx/conf.d/php-fpm

title "[Nginx] - Symlink conf"
ln -sf ~/www/git-files/install/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf

title "[Nginx] - vhosts - default"
ln -sf ~/www/git-files/install/nginx/vhosts/default /usr/local/etc/nginx/sites-available/00-default
ln -sf ~/www/git-files/install/nginx/vhosts/default /usr/local/etc/nginx/sites-enabled/00-default

if [ -f ~/www/nginx-vhosts/link.sh ]; then
    title "[Nginx] - vhosts - private"
    . ~/www/nginx-vhosts/link.sh
fi

title "[Nginx] - autostart"
sudo cp /usr/local/opt/nginx/*.plist /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/homebrew.mxcl.nginx.plist


title "[Nginx] - check"
brew services list  # list all brew services
sudo nginx -t       # validate nginx configuration
sudo lsof -n -i:80  # check port 80


title "[Nginx] - Done!"
