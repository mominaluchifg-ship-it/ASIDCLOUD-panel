#!/bin/bash
# =====================================================
#   ASIDCLOUD - One Click Installer
#   Theme: Purple + Black | Custom IP | 24/7 Service
# =====================================================

set -e

echo ">>> Starting ASIDCLOUD Installation..."

# Become root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (sudo su)"
  exit
fi

# Update + upgrade
apt update -y && apt upgrade -y

# Install basics
apt install -y curl git neofetch ufw

# Install Node.js 20
curl -sL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# Clone repo
cd /opt
if [ -d "asidcloud" ]; then
  rm -rf asidcloud
fi
git clone https://github.com/dragonlabsdev/panel-v1.0.0.git asidcloud
cd asidcloud

# Install dependencies + setup
npm install
npm run seed
npm run createUser

# Replace theme (purple + black)
cat > public/css/custom-theme.css <<'EOL'
body {
  background: linear-gradient(135deg, #1a001f, #2d004d);
  color: #e0d7ff;
}
.btn {
  background: #6a0dad;
  color: white;
}
EOL

# Create systemd service
cat > /etc/systemd/system/asidcloud.service <<'EOL'
[Unit]
Description=ASIDCLOUD Panel
After=network.target

[Service]
WorkingDirectory=/opt/asidcloud
ExecStart=/usr/bin/node .
Restart=always
User=root
Environment=NODE_ENV=production
StandardOutput=append:/var/log/asidcloud/asidcloud.log
StandardError=append:/var/log/asidcloud/asidcloud-error.log

[Install]
WantedBy=multi-user.target
EOL

# Enable service
systemctl daemon-reload
systemctl enable --now asidcloud

# Firewall open (Minecraft + Panel)
ufw allow 80
ufw allow 443
ufw allow 25565/tcp
ufw allow 19132/udp
ufw --force enable

echo "✅ ASIDCLOUD Panel Installed!"
echo "👉 Access via http://panel.ASIDCLOUD.com:3000
echo "👉 Logs: journalctl -u asidcloud -f"
