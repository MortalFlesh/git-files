#!/bin/bash

# include functions
. ~/www/git-files/functions.sh

title "Dependencies":
brew update
brew install wget bash-completion curl-openssl git gnupg gnutls gpgme hadolint htop kafkacat libmemcached librdkafka libssh2 \
    libusb libxml2 libyaml libzip markdown memcached midnight-commander mysql nuget openldap openssl p7zip \
    postgresql pure-ftpd python ruby shellcheck sqlite tree zlib curl pkg-config

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
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
command -v nvm

title "Profile:"
ln -s -f ~/www/git-files/.profile-common ~/.profile-common
ln -s -f ~/www/git-files/.profile ~/.profile
. ~/.profile

title "Profile for bash:"
ln -s -f ~/www/git-files/.bashrc ~/.bashrc

title "Done!"
echo "Now restart terminal and run other installations."
