#!/usr/bin/env bash

set -e

# include functions
. ~/www/git-files/functions.sh

title "Brew:"
sudo mkdir -p /usr/local/var/homebrew
sudo chown -R $(whoami) /usr/local/var/homebrew
sudo mkdir -p /usr/local/etc/bash_completion.d
sudo mkdir -p /usr/local/share/doc
sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/zsh/site-functions
sudo chown -R $(whoami) /usr/local/etc/bash_completion.d /usr/local/share/doc /usr/local/share/man /usr/local/share/man/man1 /usr/local/share/zsh /usr/local/share/zsh/site-functions

title "Dependencies:"
brew update
brew install wget bash-completion git gnupg gnutls gpgme hadolint htop libmemcached librdkafka libssh2 \
    libusb libxml2 libyaml libzip markdown memcached midnight-commander mysql nuget openldap openssl p7zip \
    postgresql@14 pure-ftpd python ruby shellcheck sqlite tree zlib curl pkg-config \
    certbot consul-template helm jq pinentry-mac imagemagick kubectx kubernetes-cli kcat fzf

mkdir -p ~/bin

title "Done!"
