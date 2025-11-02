Install caddy on RPi
====================

uname -m
aarch64

dpkg --print-architecture
armhf


## Caddy
> 2.10.2

### Caddy L4

#### Go
```sh
# Remove old Go installation
sudo rm -rf /usr/local/go

# Download Go 1.25.3 for ARM64
cd /tmp
wget https://go.dev/dl/go1.25.3.linux-arm64.tar.gz

# Extract to /usr/local
sudo tar -C /usr/local -xzf go1.25.3.linux-arm64.tar.gz

# Verify installation
/usr/local/go/bin/go version
```

go version go1.25.3 linux/arm64

```sh
# Add Go to PATH (already configured in .profile-rpi)
# Reload profile
. ~/.profile-rpi

# Verify Go is in PATH
go version
```

#### Caddyfile Configuration

```sh
# Create symlink to Caddyfile from this repo
sudo ln -sf ~/Documents/repo/git-files/install/raspberry-pi/Caddyfile /etc/caddy/Caddyfile

# Verify the symlink
ls -la /etc/caddy/Caddyfile

# Reload Caddy configuration (if Caddy is already running)
sudo systemctl reload caddy
```
