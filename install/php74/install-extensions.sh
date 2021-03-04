#!/bin/bash

# include functions
. ~/www/git-files/functions.sh

set -e  # fail on error

title "[PHP@7.4] - install extensions"
echo ""
echo "----"
echo "NOTE: keep in mind that php extensions need other libraries, which may be installed by 'brew install ...'"
echo "----"
echo ""

title "Prepare pear tmp dir"
mkdir -p /private/tmp/pear
sudo chown -R "$(whoami):wheel" /private/tmp/pear
sudo chown -R 0777 /private/tmp/pear

title "Install extensions"
pecl install rdkafkap
pecl install igbinary

pip3 install fastlz
pecl install memcached

title "[PHP@7.4] - installed extensions"
pecl list

title "[PHP@7.4] - Done!"
php --version
