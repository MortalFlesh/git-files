#!/usr/bin/env bash

set -e

REPO_DIR="$HOME/Documents/repo"
GIT_DIR="$REPO_DIR/git-files"

# include functions
. "$GIT_DIR/functions.sh"

title "Install MQTT"
echo " > see more at: https://randomnerdtutorials.com/how-to-install-mosquitto-broker-on-raspberry-pi/"
echo ""

subTitle "Update and Install dependencies"
sudo apt update
sudo apt upgrade
sudo apt install -y mosquitto mosquitto-clients
echo " -> Done"

echo "Enable auto-start"
sudo systemctl enable mosquitto.service
echo " -> Done"

echo "Check MQTT"
mosquitto -v

echo ""
echo "Done"
echo ""
