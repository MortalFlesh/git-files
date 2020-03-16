#!/bin/bash

# include functions
. ~/www/git-files/functions.sh

set -e  # fail on error

title "[PHP@7.4] - install extensions"
echo "NOTE: keep in mind that php extensions need other libraries, which may be installed by `brew install ...`"

pecl install rdkafka

pecl install igbinary

pip3 install fastlz
pecl install memcached

title "[PHP@7.4] - installed extensions"
pecl list

title "[PHP@7.4] - Done!"
php --version
