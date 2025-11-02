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
