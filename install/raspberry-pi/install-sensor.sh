#!/usr/bin/env bash

set -e

REPO_DIR="$HOME/Documents/repo"
GIT_DIR="$REPO_DIR/git-files"
RPI_DIR="$GIT_DIR/install/raspberry-pi"
SENSORS_DIR="$REPO_DIR/system_sensors"

# include functions
. "$GIT_DIR/functions.sh"

cd "$REPO_DIR"

title "Install Sensors for RPi"
echo " > see more at: https://github.com/Sennevds/system_sensors"
echo ""

subTitle "Update and Install dependencies"
echo " - Install system dependencies ..."
sudo apt update
sudo apt upgrade
sudo apt-get install -y python3-apt

echo " - Install python dependencies ..."
cd "$SENSORS_DIR"
pip3 install -r requirements.txt
echo " -> Done"

subTitle "Symlink settings"
ln -s -f "$RPI_DIR/sensors-settings.yaml" "$SENSORS_DIR/src/settings_example.yaml"
echo " -> Done"

subTitle "Set up MQTT user password"
echo -n "Password: "
read -sr password
echo

echo " -> replace password in config"
sed -i "s/<PASS>/$password/" "$SENSORS_DIR/src/settings_example.yaml"
echo " -> Done"

echo "Done"
echo ""
