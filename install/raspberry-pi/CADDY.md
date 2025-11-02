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

#### Install xcaddy

```sh
# Check your architecture
uname -m  # Should show aarch64
go env GOARCH  # Should show arm64

# If GOARCH doesn't match, set it explicitly
export GOARCH=arm64
export GOOS=linux

# Install xcaddy (Caddy build tool)
go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# Verify xcaddy installation
xcaddy version
```

**Note**: If you get a pointer size error (`_check_for_64_bit_pointer_matching_GoInt`), 
it means there's an architecture mismatch. Ensure `GOARCH=arm64` is set.

#### Build Caddy with L4 support

```sh
# Create a directory for the build
mkdir -p ~/caddy-build
cd ~/caddy-build

# Build Caddy with L4 module
xcaddy build \
    --with github.com/mholt/caddy-l4

# This will create a 'caddy' binary in the current directory
# Verify the build
./caddy version
./caddy list-modules | grep l4

# Install the custom Caddy binary
sudo mv caddy /usr/bin/caddy
sudo chown root:root /usr/bin/caddy
sudo chmod 755 /usr/bin/caddy

# Verify installation
caddy version
caddy list-modules | grep l4
```

#### Setup Caddy as a service

```sh
# Create Caddy group and user
sudo groupadd --system caddy
sudo useradd --system \
    --gid caddy \
    --create-home \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    --comment "Caddy web server" \
    caddy

# Create necessary directories
sudo mkdir -p /etc/caddy
sudo mkdir -p /var/log/caddy

# Set permissions
sudo chown -R caddy:caddy /etc/caddy
sudo chown -R caddy:caddy /var/log/caddy

# Create systemd service file
sudo tee /etc/systemd/system/caddy.service > /dev/null <<EOF
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=caddy
Group=caddy
ExecStart=/usr/bin/caddy run --environ --config /etc/caddy/Caddyfile
ExecReload=/usr/bin/caddy reload --config /etc/caddy/Caddyfile --force
TimeoutStopSec=5s
LimitNOFILE=1048576
LimitNPROC=512
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and enable Caddy
sudo systemctl daemon-reload
sudo systemctl enable caddy
sudo systemctl start caddy

# Check status
sudo systemctl status caddy
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
