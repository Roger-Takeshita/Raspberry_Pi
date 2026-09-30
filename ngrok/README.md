# ngrok

## Install

- Raspberry Pi

  ```bash
  curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
    | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
    && echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
    | sudo tee /etc/apt/sources.list.d/ngrok.list \
    && sudo apt update \
    && sudo apt install ngrok
  ```

## Version

```bash
ngrok version

# ngrok version 3.39.11
```

## Login

```bash
ngrok config add-authtoken YOUR_EXISTING_TOKEN
```

## Config

```bash
vim ~/.config/ngrok/ngrok.yml

# version: "3"
# authtoken: YOUR_EXISTING_TOKEN
#
# endpoints:
#   - name: server
#     upstream:
#       url: 3001
```

- Check if config is correct

  ```bash
  ngrok config check

  # Valid configuration file at /home/roger-that/.config/ngrok/ngrok.yml
  ```

- Check ngrok dashboard/API locally

  ```bash
  curl http://localhost:4040/api/tunnels

  # {"tunnels":[{"name":"server","ID":"83ec935382123dfs123d8947dbe7f2b6","uri":"/api/tunnels/server","public_url":"https://88b2-123-123-34.ngrok-free.app","proto":"https","config":{"addr":"http://localhost:3001","inspect":true},"metrics":{"conns":{"count":0,"gauge":0,"rate1":0,"rate5":0,"rate15":0,"p50":0,"p90":0,"p95":0,"p99":0},"http":{"count":0,"rate1":0,"rate5":0,"rate15":0,"p50":0,"p90":0,"p95":0,"p99":0}}}],"uri":"/api/tunnels"}
  ```

## Startup Service

```bash
sudo ngrok service install --config /home/roger-that/.config/ngrok/ngrok.yml

# t=2026-09-30T04:43:49+0100 lvl=info msg="open config file" path=/home/roger-that/.config/ngrok/ngrok.yml err=<nil>
# t=2026-09-30T04:43:49+0100 lvl=warn msg="ignoring inspect: true because inspection database is disabled" name=server
# t=2026-09-30T04:43:49+0100 lvl=info msg="detect init system" sys=linux-systemd
# t=2026-09-30T04:43:50+0100 lvl=info msg="install ok"
```

- Start ngrok

  ```bash
  sudo ngrok service start

  # t=2026-09-30T04:44:44+0100 lvl=info msg="detect init system" sys=linux-systemd
  # t=2026-09-30T04:44:44+0100 lvl=info msg="start ok"
  ```

- Check status

  ```bash
  sudo systemctl status ngrok

  # ● ngrok.service - ngrok secure tunnel client
  #      Loaded: loaded (/etc/systemd/system/ngrok.service; enabled; preset: enabled)
  #      Active: active (running) since Wed 2026-09-30 04:44:44 BST; 1min 30s ago
  #    Main PID: 28806 (ngrok)
  #       Tasks: 9 (limit: 3914)
  #         CPU: 1.281s
  #      CGroup: /system.slice/ngrok.service
  #              └─28806 /usr/local/bin/ngrok service run --config /home/roger-that/.config/ngrok/ngrok.yml
  ```
