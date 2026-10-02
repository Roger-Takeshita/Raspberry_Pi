# Home Assistant

- [Local Home Assistant](http://localhost:8123/)

## Start

```bash
cd ~/Documents/Codes/Raspberry_Pi/HomeAssistant
docker compose up -d
```

## Check Status

```bash
docker compose ps

# NAME            IMAGE                                          COMMAND   SERVICE         CREATED              STATUS              PORTS
# homeassistant   ghcr.io/home-assistant/home-assistant:stable   "/init"   homeassistant   About a minute ago   Up About a minute
```

## Start Logs

```bash
docker compose logs -f homeassistant

# homeassistant  | s6-rc: info: service s6rc-oneshot-runner: starting
# homeassistant  | s6-rc: info: service s6rc-oneshot-runner successfully started
# homeassistant  | s6-rc: info: service fix-attrs: starting
# homeassistant  | s6-rc: info: service fix-attrs successfully started
# homeassistant  | s6-rc: info: service legacy-cont-init: starting
# homeassistant  | s6-rc: info: service legacy-cont-init successfully started
# homeassistant  | s6-rc: info: service legacy-services: starting
# homeassistant  | services-up: info: copying legacy longrun home-assistant (no readiness notification)
# homeassistant  | s6-rc: info: service legacy-services successfully started
# homeassistant  | 2026-09-27 23:18:41.670 WARNING (ImportExecutor_0) [py.warnings] /usr/local/lib/python3.14/site-packages/rich/segment.py:547: SyntaxWarning: 'return' in a 'finally' block
# homeassistant  |   return
# homeassistant  |
```

## Remove Docker

```bash
docker stop homeassistant
docker rm homeassistant
```

- Check if homeassistant was removed

  ```bash
  docker ps -a
  ```

## Remove Home Assistant Image

```bash
docker image rm ghcr.io/home-assistant/home-assistant:stable
```
