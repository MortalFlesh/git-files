#!/usr/bin/env bash

# include functions
. ~/www/git-files/functions.sh

set -e  # fail on error

title "PHP 7.3 - install extensions"
echo ""
echo "----"
echo "NOTE: keep in mind that php extensions need other libraries, which may be installed by 'brew install ...'"
echo "----"
echo ""

pecl install igbinary
pecl install rdkafka
pecl install memcached

title "PHP 7.3 - installed extensions"
pecl list

title "Done!"
