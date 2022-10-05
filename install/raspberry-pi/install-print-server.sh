#!/usr/bin/env bash

set -e

REPO_DIR="$HOME/Documents/repo"
GIT_DIR="$REPO_DIR/git-files"
RPI_DIR="$GIT_DIR/install/raspberry-pi"
SENSORS_DIR="$REPO_DIR/system_sensors"

# include functions
. "$GIT_DIR/functions.sh"

cd "$REPO_DIR"

title "Install Cups"
echo " > see more at: https://www.tomshardware.com/how-to/raspberry-pi-print-server"
echo ""

subTitle "Update and Install dependencies"
echo " - Install system dependencies ..."
sudo apt update
sudo apt upgrade
sudo apt-get install -y cups \
    hpijs-ppds printer-driver-hpijs # from: https://serverfault.com/questions/602523/cups-is-not-printing-with-filter-failed-message-how-to-get-more-info
echo " -> Done"

subTitle "Allow user pi to print"
sudo usermod -a -G lpadmin pi
echo " -> Done"

subTitle "Configure CUPS so that it is accessible across the network."
sudo cupsctl --remote-any
echo " -> Done"

subTitle "Configure CUPS in admin."
echo " > go to http://192.168.1.2:631/"
echo ""

echo "Done"
echo ""

echo "TIP: if you have a problem with HP printer, use: sudo hp-setup -i"
echo ""
