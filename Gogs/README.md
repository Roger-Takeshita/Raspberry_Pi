# GOGS

<details>
  <summary id='table-of-contents'>
    <strong>Table of Contents</strong>
  </summary>

<!-- Begin Table of Contents GFM -->

- [Links](#links)
- [Check Gogs Version](#check-gogs-version)
- [Before Run Script](#before-run-script)
- [Service Config](#service-config)
- [Server Config](#server-config)
- [Copy Existing Data](#copy-existing-data)
- [Commands](#commands)

<!-- End Table of Contents -->

</details>

## Links

[☰ Contents](#table-of-contents)

- [Adduser command missing](https://raspberrypi.stackexchange.com/questions/95472/adduser-command-missing)
- [How to install Gogs on the Raspberry Pi](https://pimylifeup.com/raspberry-pi-gogs/)
- [Check Gogs version](https://github.com/gogs/gogs/discussions/6910)

## Check Gogs Version

[☰ Contents](#table-of-contents)

```bash
file gogs

# gogs: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 2.6.32, Go BuildID=tu19gEqiEk8Th1qUh1ij/JS0Rsyp-GJrIMzl9aLd7/xmOiyUqcpIoKdAs-P5Qs/gt1yNDUnK85t58WhORk9, BuildID[sha1]=70510f86c8dbb56192146a1167408e787a57c358, with debug_info, not stripped
```

## Before Run Script

[☰ Contents](#table-of-contents)

- Install `adduser`

  ```bash
  sudo apt-get install adduser
  ```

- Add `PATH` to your terminal

  ```bash
  echo 'export PATH="/usr/sbin:$PATH"' >> ~/.zprofile_user
  ```

- Create a new user called `git`

  ```bash
  sudo adduser --disabled-login git
  ```

## Service Config

[☰ Contents](#table-of-contents)

- **Default**, `/home/git/gogs/scripts/systemd/gogs.service`

  ```yaml
  [Unit]
  Description=Gogs
  After=syslog.target
  After=network.target
  After=mariadb.service mysql.service mysqld.service postgresql.service memcached.service redis.service

  [Service]
  # Modify these two values and uncomment them if you have
  # repos with lots of files and get an HTTP error 500 because
  # of that
  ###
  #LimitMEMLOCK=infinity
  #LimitNOFILE=65535
  Type=simple
  User=git
  Group=git
  WorkingDirectory=/home/git/gogs
  ExecStart=/home/git/gogs/gogs web
  Restart=always
  Environment=USER=git HOME=/home/git

  # Some distributions may not support these hardening directives. If you cannot start the service due
  # to an unknown option, comment out the ones not supported by your version of systemd.
  ProtectSystem=full
  PrivateDevices=yes
  PrivateTmp=yes
  NoNewPrivileges=true

  [Install]
  WantedBy=multi-user.target
  ```

- **Custom service**, `/etc/systemd/system/gogs.service`

  ```bash
  vi /etc/systemd/system/gogs.service
  ```

  ```yaml
  [Unit]
  Description=Gogs
  After=syslog.target
  After=network.target
  After=mariadb.service mysql.service mysqld.service postgresql.service memcached.service redis.service

  [Service]
  # Modify these two values and uncomment them if you have
  # repos with lots of files and get an HTTP error 500 because
  # of that
  ###
  #LimitMEMLOCK=infinity
  #LimitNOFILE=65535
  Type=simple
  User=git
  Group=git
  WorkingDirectory=/home/pi/Documents/Codes/gogs
  ExecStart=/home/pi/Documents/Codes/gogs/gogs web
  Restart=always
  Environment=USER=git HOME=/home/pi

  # Some distributions may not support these hardening directives. If you cannot start the service due
  # to an unknown option, comment out the ones not supported by your version of systemd.
  ProtectSystem=full
  PrivateDevices=yes
  PrivateTmp=yes
  NoNewPrivileges=true

  [Install]
  WantedBy=multi-user.target
  ```

## Server Config

[☰ Contents](#table-of-contents)

- In `/home/git/gogs/custom/conf/app.ini`

  ```bash
  mkdir -p /home/git/gogs/custom/conf
  touch /home/git/gogs/custom/conf/app.ini
  vi /home/git/gogs/custom/conf/app.ini
  ```

  ```yaml
  BRAND_NAME = GitHub
  RUN_USER   = git
  RUN_MODE   = prod

  [database]
  TYPE     = sqlite3
  HOST     = 127.0.0.1:5432
  NAME     = gogs
  SCHEMA   = public
  USER     = root
  PASSWORD =
  SSL_MODE = disable
  PATH     = data/gogs.db

  [repository]
  ROOT           = /home/git/gogs-repositories
  DEFAULT_BRANCH = main

  [server]
  DOMAIN           = http://10.0.0.100
  HTTP_PORT        = 9000
  EXTERNAL_URL     = http://10.0.0.100:9000/
  DISABLE_SSH      = false
  SSH_PORT         = 22
  START_SSH_SERVER = false
  OFFLINE_MODE     = false

  [mailer]
  ENABLED = false

  [auth]
  REQUIRE_EMAIL_CONFIRMATION  = false
  DISABLE_REGISTRATION        = false
  ENABLE_REGISTRATION_CAPTCHA = true
  REQUIRE_SIGNIN_VIEW         = false

  [user]
  ENABLE_EMAIL_NOTIFICATION = false

  [picture]
  DISABLE_GRAVATAR        = false
  ENABLE_FEDERATED_AVATAR = false

  [session]
  PROVIDER = file

  [log]
  MODE      = file
  LEVEL     = Info
  ROOT_PATH = /home/git/gogs/log

  [security]
  INSTALL_LOCK = true
  SECRET_KEY   = new_key_here
  ```

## Copy Existing Data

[☰ Contents](#table-of-contents)

```bash
sudo mv ~/Downloads/gogs_data/gogs.db /home/git/gogs/data/gogs.db
sudo mv ~/Downloads/gogs_data/avatars /home/git/gogs/data/
sudo mv ~/Downloads/gogs_data/repo-avatars /home/git/gogs/data/
sudo mv ~/Downloads/gogs_data/gogs-repositories /home/git/
sudo chown -R git:git /home/git
```

## Commands

[☰ Contents](#table-of-contents)

- Daemon Reload

  ```bash
  systemctl daemon-reload
  ```

- Start Service

  ```bash
  sudo systemctl start gogs.service
  ```

- Service Status

  ```bash
  sudo systemctl status gogs.service
  ```

- Restart gogs

  ```bash
  service gogs restart
  ```
