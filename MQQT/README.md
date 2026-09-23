# MQQT

## Install

```bash
sudo apt update
sudo apt install -y mosquitto mosquitto-clients
```

## Start After Rebot

```bash
sudo systemctl enable mosquitto
sudo systemctl start mosquitto
```

## Check Status

```bash
sudo systemctl status mosquitto

# ● mosquitto.service - Mosquitto MQTT Broker
#      Loaded: loaded (/lib/systemd/system/mosquitto.service; enabled; preset: enabled)
#      Active: active (running) since Wed 2026-09-23 19:27:39 BST; 1min 57s ago
#        Docs: man:mosquitto.conf(5)
#              man:mosquitto(8)
#    Main PID: 31019 (mosquitto)
#       Tasks: 1 (limit: 3914)
#         CPU: 68ms
#      CGroup: /system.slice/mosquitto.service
#              └─31019 /usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
#
# Sep 23 19:27:39 roger-that systemd[1]: Starting mosquitto.service - Mosquitto MQTT Broker...
# Sep 23 19:27:39 roger-that systemd[1]: Started mosquitto.service - Mosquitto MQTT Broker.
```

## Test Connectivity

```bash
# Terminal 1
mosquitto_sub -h localhost -t "home/test"

# Terminal 2
mosquitto_pub -h localhost -t "home/test" -m "Hello from Raspberry Pi"
```

## Config

1. Username and Password
   - Create

     ```bash
     sudo mosquitto_passwd -c /etc/mosquitto/passwd Roger-That
     ```

   - Delete

     ```bash
     sudo mosquitto_passwd -D /etc/mosquitto/passwd Roger-That
     ```

   - Update

     ```bash
     sudo mosquitto_passwd /etc/mosquitto/passwd Roger-That
     sudo systemctl restart mosquitto
     ```

   - Check Users

     ```bash
     sudo cat /etc/mosquitto/passwd
     ```

2. After configuring password, create a local config

   ```bash
   # Raspberry Pi
   sudo vim /etc/mosquitto/conf.d/local.conf

   # MacOs
   vim /opt/homebrew/etc/mosquitto/mosquitto.conf
   ```

   - Paste the following settings

   ```bash
   # Raspberry Pi
   listener 1883
   allow_anonymous false
   password_file /etc/mosquitto/passwd

   # MacOs
   listener 1883
   allow_anonymous false
   password_file /opt/homebrew/etc/mosquitto/passwd
   log_dest stdout
   ```

## Test

```bash
# Terminal 1
mosquitto_sub \
  -h localhost \
  -p 1883 \
  -u Roger-That \
  -P 'PASSWORD' \
  -t 'home/test'

# Terminal 2
mosquitto_pub \
  -h localhost \
  -p 1883 \
  -u Roger-That \
  -P 'PASSWORD' \
  -t 'home/test' \
  -m 'password works'
```
