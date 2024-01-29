#!/usr/bin/env bash

# include functions
. ~/www/git-files/functions.sh

set -e  # fail on error

title "[PHP@8.3] - install extensions"
echo ""
echo "----"
echo "NOTE: keep in mind that php extensions need other libraries, which may be installed by 'brew install ...'"
echo "----"
echo ""

title "Prepare pear tmp dir"
mkdir -p /private/tmp/pear/temp
sudo chown -R "$(whoami):wheel" /private/tmp/pear
sudo chmod -R 0777 /private/tmp/pear

title "Update pecl"
pecl channel-update pecl.php.net

title "Install extensions"
#pecl install rdkafka
#pecl install igbinary

#pip3 install fastlz
#pecl install memcached

pecl install xdebug

title "[PHP@8.3] - installed extensions"
pecl list

title "[PHP@8.3] - Done!"
php --version
