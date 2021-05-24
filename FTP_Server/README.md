<h1 id='table-of-contents'>TABLE OF CONTENTS</h1>

- [FTP Server](#ftp-server)
  - [Installation](#installation)
  - [Check Service](#check-service)
  - [Reload Service](#reload-service)
  - [Restart Service](#restart-service)
  - [Config](#config)

# FTP Server

## Installation

[Go Back to Contents](#table-of-contents)

Install `proftpd`

```Bash
  sudo apt-get install proftpd
```

- Select the `standalone` version

## Check Service

[Go Back to Contents](#table-of-contents)

Double check if the service is running after the installation

```Bash
  sudo service proftpd status

  # ● proftpd.service - LSB: Starts ProFTPD daemon
  #  Loaded: loaded (/etc/init.d/proftpd; generated)
  #  Active: active (running) since Mon 2021-05-24 09:52:10 EDT; 32min ago
  #    Docs: man:systemd-sysv-generator(8)
  # Process: 469 ExecStart=/etc/init.d/proftpd start (code=exited, status=0/SUCCESS)
  #   Tasks: 1 (limit: 4915)
  #  CGroup: /system.slice/proftpd.service
  #          └─611 proftpd: (accepting connections)

  # May 24 09:52:06 Roger-That-Pi systemd[1]: Starting LSB: Starts ProFTPD daemon...
  # May 24 09:52:08 Roger-That-Pi proftpd[469]: Starting ftp server: proftpd2021-05-24 09:52:08,240 Roger-That-Pi proftpd[530]: processing configuration directory '/etc/proftpd/conf.d/'
  # May 24 09:52:10 Roger-That-Pi proftpd[469]: .
  # May 24 09:52:10 Roger-That-Pi systemd[1]: Started LSB: Starts ProFTPD daemon.
```

Check status

```Bash
  ps -aux | grep proftpd

  # proftpd    611  0.0  0.0  18880  3492 ?        Ss   09:52   0:00 proftpd: (accepting connections)
  # pi       10665  0.0  0.0   7344   528 pts/1    S+   10:26   0:00 grep --color=auto proftpd
```

- As we can see our **proftpd** is `(accepting connections)` and running on the background

## Reload Service

[Go Back to Contents](#table-of-contents)

```Bash
  sudo service proftpd reload
```

## Restart Service

[Go Back to Contents](#table-of-contents)

```Bash
  sudo service proftpd restart
```

## Config

[Go Back to Contents](#table-of-contents)

In `/etc/proftpd/proftpd.conf`

```Bash
  sudo vim /etc/proftpd/proftpd.conf
```
