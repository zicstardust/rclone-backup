# Schedule rclone systemd timer

## Install
```bash
curl https://raw.githubusercontent.com/zicstardust/rclone-backup/main/install.sh | bash
```
## Config
```bash
~/.config/systemd/rclone-backup.sh gen-config-file
vi ~/.config/systemd/rclone-backup.config
```
## Enable
```bash
systemctl --user enable --now rclone-backup.timer
```