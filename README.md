# ASIDCLOUD Panel

One-click installer for ASIDCLOUD game panel with purple/black theme, custom IP support, and 24/7 systemd service.

## 🚀 Installation

Run this command on your VPS:

```bash
bash <(curl -s https://raw.githubusercontent.com/ASIDCLOUD/ASIDCLOUD-Panel/main/asidcloud.sh)
```

## ✨ Features
- Purple + Black theme
- Minecraft & Bedrock ports opened (25565, 19132)
- 24/7 service (systemd auto restart)
- Custom domain + SSL supported
- Lightweight & smooth design

## 🔧 After Install
- Panel URL: `http://panel.ASIDCLOUD.com:3000`
- Logs: `journalctl -u asidcloud -f`
- Add SSL: `certbot --nginx -d panel.ASIDCLOUD.com`
