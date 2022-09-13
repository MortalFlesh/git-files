Raspberry Pi (OS)
=================

## Install
```sh
# Install dependencies
sudo apt-get update && apt-get install -y vim git tree

mkdir -p ~/Documents/repo
cd ~/Documents/repo

# Clone this repo
git clone https://github.com/MortalFlesh/git-files.git
. ./git-files/install/raspberry-pi/install.sh
```

## MQTT
Install by `install-mqtt.sh`

More:
- https://randomnerdtutorials.com/how-to-install-mosquitto-broker-on-raspberry-pi/
- https://pimylifeup.com/raspberry-pi-mosquitto-mqtt-server/
- https://mosquitto.org/documentation/
- https://mosquitto.org/documentation/authentication-methods/

### Add More Users/Change Password
To add more users to an existing password file, or to change the password for an existing user, leave out the -c argument:
`mosquitto_passwd <password file> <username>`

For example, if I want to change the password for the sara user and taking into account that the password file we created was called passwd, the command will be as follows:
`sudo mosquitto_passwd /etc/mosquitto/passwd sara`


## Sensors
> https://github.com/Sennevds/system_sensors

Install by `install-sensors.sh`
