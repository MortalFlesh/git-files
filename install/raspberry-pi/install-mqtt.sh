#!/usr/bin/env bash

set -e

REPO_DIR="$HOME/Documents/repo"
GIT_DIR="$REPO_DIR/git-files"
RPI_DIR="$GIT_DIR/install/raspberry-pi"

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

subTitle "Enable auto-start"
sudo systemctl enable mosquitto.service
echo " -> Done"

subTitle "Check MQTT"
sudo systemctl status mosquitto
echo ""
mosquitto -v
echo " -> Done"

subTitle "Create a user"
sudo mosquitto_passwd -c /etc/mosquitto/passwd ant-man
echo " -> Done"

subTitle "Link configuration"
ln -s -f "$RPI_DIR/mosquitto.conf" /etc/mosquitto/mosquitto.conf
echo " -> Done"

subTitle "Restart Mosquitto"
sudo systemctl restart mosquitto
echo " -> Done"

subTitle "Check MQTT"
sudo systemctl status mosquitto
echo ""
mosquitto -v
echo " -> Done"

echo ""
echo "Done"
echo ""
