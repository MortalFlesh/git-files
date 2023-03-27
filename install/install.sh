#!/usr/bin/env bash

set -e

# include functions
. ~/www/git-files/functions.sh

title "Brew:"
mkdir -p /usr/local/var/homebrew
sudo chown -R $(whoami) /usr/local/var/homebrew
mkdir -p /usr/local/etc
mkdir -p /usr/local/share/doc
mkdir -p /usr/local/share/man/man1
mkdir -p /usr/local/share/zsh/site-functions
sudo chown -R $(whoami) /usr/local/etc/bash_completion.d /usr/local/share/doc /usr/local/share/man /usr/local/share/man/man1 /usr/local/share/zsh /usr/local/share/zsh/site-functions

title "Dependencies:"
brew update
brew install wget bash-completion curl-openssl git gnupg gnutls gpgme hadolint htop kafkacat libmemcached librdkafka libssh2 \
    libusb libxml2 libyaml libzip markdown memcached midnight-commander mysql nuget openldap openssl p7zip \
    postgresql pure-ftpd python ruby shellcheck sqlite tree zlib curl pkg-config \
    certbot consul-template helm jq pinentry-mac imagemagick kubectx kubernetes-cli

mkdir -p ~/bin

title "Symlinks:"
# - use ln -s -f ... will override files in your home
ln -s -f ~/www/git-files/.gitconfig ~/.gitconfig
ln -s -f ~/www/git-files/.git-completion.bash ~/.git-completion.bash
ln -s -f ~/www/git-files/.git-config.bash ~/.git-config.bash
ln -s -f ~/www/git-files/.gitignore_global ~/.gitignore_global

title "Sublime 3:"
ln -s -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/sublime

title "Phive tools:"
mkdir -p ~/phive
ln -s -f ~/www/git-files/phive/phive.xml ~/phive/phive.xml

title "NVM:"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
command -v nvm

title "Profile:"
ln -s -f ~/www/git-files/.profile-common ~/.profile-common
ln -s -f ~/www/git-files/.profile ~/.profile
. ~/.profile

title "Profile for bash:"
ln -s -f ~/www/git-files/.bashrc ~/.bashrc

title "Karabiner profile:"
mkdir -p ~/.config/karabiner
rm -rf ~/.config/karabiner
ln -s -f ~/www/git-files/karabiner/ ~/.config/karabiner

title "Done!"
echo "Now restart terminal and run other installations."
