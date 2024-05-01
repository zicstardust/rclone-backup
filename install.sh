#!/bin/sh
mkdir -p ${HOME}/.config/systemd/user

cat > ${HOME}/.config/systemd/user/rclone-backup.service << EOF
[Unit]
Description=Rclone Backup Service
Wants=rclone-backup.timer

[Service]
Type=oneshot
WorkingDirectory=${HOME}/.config/systemd/
ExecStart=${HOME}/.config/systemd/rclone-backup.sh

[Install]
WantedBy=multi-user.target
EOF

cat > ${HOME}/.config/systemd/user/rclone-backup.timer << EOF
[Unit]
Description=Rclone Backup Timer
Requires=rclone-backup.service

[Timer]
Unit=rclone-backup.service
AccuracySec=1ms
RandomizedDelaySec=0
OnCalendar=*-*-* *:00:00

[Install]
WantedBy=timers.target
EOF
systemctl --user daemon-reload

curl https://raw.githubusercontent.com/zicstardust/rclone-backup/main/run.sh > ${HOME}/.config/systemd/rclone-backup.sh
chmod +x ${HOME}/.config/systemd/rclone-backup.sh
