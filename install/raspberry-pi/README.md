Raspberry Pi (OS)
=================

## Install
```sh
# Install dependencies
sudo apt-get update
sudo apt-get install -y vim git tree

mkdir -p ~/Documents/repo
cd ~/Documents/repo

# Clone this repo
git clone https://github.com/MortalFlesh/git-files.git
. ./git-files/install/raspberry-pi/install.sh
```

## Sensors
> https://github.com/Sennevds/system_sensors

Install dependencies
```sh
sudo apt-get install -y python3-apt
```
