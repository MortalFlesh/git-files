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
**Important**: Your system has aarch64 kernel but armhf userland (32-bit), so you need 32-bit ARM Go!

```sh
# Remove old Go installation
sudo rm -rf /usr/local/go

# Download Go 1.25.3 for 32-bit ARM (armv6l)
cd /tmp
wget https://go.dev/dl/go1.25.3.linux-armv6l.tar.gz

# Extract to /usr/local
sudo tar -C /usr/local -xzf go1.25.3.linux-armv6l.tar.gz

# Verify installation
/usr/local/go/bin/go version
```

Expected output: `go version go1.25.3 linux/arm`

**Note**: Use `armv6l` (32-bit) not `arm64` because `dpkg --print-architecture` shows `armhf`.

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
uname -m  # Shows: aarch64 (64-bit kernel)
dpkg --print-architecture  # Shows: armhf (32-bit userland)

# This is a hybrid setup - we need to build for 32-bit ARM
go env GOARCH  # Should show arm (already set in .profile-rpi)

# If not set, configure it:
# export GOARCH=arm
# export GOARM=7
# export GOOS=linux

# Install xcaddy (Caddy build tool)
go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# If go install doesn't show any output, verify:
echo $GOPATH  # Should show: /home/pi/go (or similar)
ls -la $GOPATH/bin  # Check if xcaddy binary exists

# Verify xcaddy installation
xcaddy version

# If xcaddy is not found, check:
which xcaddy
echo $PATH | grep go
```

**Troubleshooting go install**:
- `go install` is silent on success - no output is normal
- Binary is installed to `$GOPATH/bin/xcaddy`
- If you get errors, try with verbose flag: `go install -v github.com/caddyserver/xcaddy/cmd/xcaddy@latest`
- Check Go module mode: `go env GO111MODULE` (should be empty or "on")

**Cross-compilation issue**:
If you get "cannot install cross-compiled binaries", it's because GOARCH/GOOS are set 
for building Caddy later. For installing xcaddy itself, temporarily unset them:

```sh
# Unset cross-compilation flags temporarily
unset GOARCH GOARM GOOS

# Install xcaddy
go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# Verify installation
xcaddy version

# Re-export the flags for building Caddy with L4
export GOARCH=arm
export GOARM=7
export GOOS=linux
```

**Alternative: Build xcaddy from source**:
```sh
cd /tmp
git clone https://github.com/caddyserver/xcaddy.git
cd xcaddy/cmd/xcaddy
go build -v -o xcaddy
sudo mv xcaddy /usr/local/bin/
xcaddy version
```

**Note**: RPi with aarch64 kernel + armhf userland needs `GOARCH=arm` (32-bit), not `arm64`.

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
./caddy list-modules | grep layer4

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
