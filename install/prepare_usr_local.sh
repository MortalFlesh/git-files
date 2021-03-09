#!/usr/bin/env bash

set -e

sudo mkdir -p /usr/local/bin
sudo chown -R $(whoami) /usr/local/bin

sudo mkdir -p /usr/local/etc
sudo chown -R $(whoami) /usr/local/etc

sudo mkdir -p /usr/local/include
sudo chown -R $(whoami) /usr/local/include

sudo mkdir -p /usr/local/lib
sudo chown -R $(whoami) /usr/local/lib

sudo mkdir -p /usr/local/opt
sudo chown -R $(whoami) /usr/local/opt

sudo mkdir -p /usr/local/sbin
sudo chown -R $(whoami) /usr/local/sbin

sudo mkdir -p /usr/local/share
sudo chown -R $(whoami) /usr/local/share

sudo mkdir -p /usr/local/var
sudo chown -R $(whoami) /usr/local/var

sudo mkdir -p /usr/local/Cellar
sudo chown -R $(whoami) /usr/local/Cellar

sudo mkdir -p /usr/local/Frameworks
sudo chown -R $(whoami) /usr/local/Frameworks

echo "Done"
