# Startup Service

- Create a new service

  ```bash
  sudo vim /etc/systemd/system/server.service
  ```

  ```yaml
  [Unit]
  Description=Node Server
  Wants=network-online.target
  After=network-online.target mosquitto.service docker.service
  Requires=mosquitto.service docker.service

  [Service]
  Type=simple
  User=roger-that
  WorkingDirectory=/home/roger-that/Documents/Codes/home

  # Wait for Home Assistant to respond
  ExecStartPre=/bin/sh -c 'until curl -sf http://localhost:8123 >/dev/null; do sleep 2; done'
  ExecStart=/bin/zsh -lc 'pnpm prod'

  Restart=on-failure
  RestartSec=5

  [Install]
  WantedBy=multi-user.target
  ```

- Reload daemon, enable and start service

  ```bash
  sudo systemctl daemon-reload
  sudo systemctl enable server
  sudo systemctl start server
  ```

- Check status

  ```bash
  sudo systemctl status server
  ```

- View server logs

  ```bash
  journalctl -u server -f
  ```
