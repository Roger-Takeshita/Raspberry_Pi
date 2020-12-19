<h1 id='contents'>Table of Contents</h1>

- [LINKS](#links)
- [STATIC IP](#static-ip)
  - [Check Current IP Address](#check-current-ip-address)
  - [Check Router's Gateway (Router IP)](#check-routers-gateway-router-ip)
  - [dhcpcd.conf](#dhcpcdconf)
  - [Update Interfaces](#update-interfaces)
  - [Update wpa_supplicant.conf](#update-wpa_supplicantconf)
- [SQUID](#squid)
  - [Check for Updates](#check-for-updates)
  - [Install](#install)
    - [Squid](#squid-1)
      - [Change squid.conf CHMOD](#change-squidconf-chmod)
      - [Update squid.conf](#update-squidconf)
      - [Config Squid](#config-squid)
    - [Apache](#apache)
    - [TFC Flow](#tfc-flow)
      - [Start tcpflow](#start-tcpflow)
  - [Router](#router)
  - [Remote.it](#remoteit)
    - [Enable VNC](#enable-vnc)
    - [Check Port](#check-port)
    - [Start Remote.it](#start-remoteit)

# LINKS

- [YT - Squid Server](https://www.youtube.com/watch?v=D1eD60_jhKI&t)
- [YT - Remote.it](https://www.youtube.com/watch?v=sHaY4EBQowQ&t)

---

# STATIC IP

## Check Current IP Address

[Go Back to Contents](#contents)

```bash
  ifconfig
  # eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
  #         inet 10.0.0.13  netmask 255.255.255.0  broadcast 10.0.0.255
  #         inet6 fe80::dea6:32ff:fe8f:7aa8  prefixlen 64  scopeid 0x20<link>
  #         inet6 2607:fea8:4fdf:3b00::2e72  prefixlen 128  scopeid 0x0<global>
  #         inet6 2607:fea8:4fdf:3b00:dea6:32ff:fe8f:7aa8  prefixlen 64  scopeid 0x0<global>
  #         ether dc:a6:32:8f:7a:a8  txqueuelen 1000  (Ethernet)
  #         RX packets 15333  bytes 2015500 (1.9 MiB)
  #         RX errors 0  dropped 0  overruns 0  frame 0
  #         TX packets 13534  bytes 3192548 (3.0 MiB)
  #         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

  # lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
  #         inet 127.0.0.1  netmask 255.0.0.0
  #         inet6 ::1  prefixlen 128  scopeid 0x10<host>
  #         loop  txqueuelen 1000  (Local Loopback)
  #         RX packets 2289  bytes 513634 (501.5 KiB)
  #         RX errors 0  dropped 0  overruns 0  frame 0
  #         TX packets 2289  bytes 513634 (501.5 KiB)
  #         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

  # wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
  #         inet 10.0.0.99  netmask 255.255.255.0  broadcast 10.0.0.255
  #         inet6 2607:fea8:4fdf:3b00::4691  prefixlen 128  scopeid 0x0<global>
  #         inet6 fe80::1a3e:153c:5f48:6214  prefixlen 64  scopeid 0x20<link>
  #         inet6 2607:fea8:4fdf:3b00:8d8a:2712:58d8:33bd  prefixlen 64  scopeid 0x0<global>
  #         ether dc:a6:32:8f:7a:aa  txqueuelen 1000  (Ethernet)
  #         RX packets 3585  bytes 469384 (458.3 KiB)
  #         RX errors 0  dropped 0  overruns 0  frame 0
  #         TX packets 1700  bytes 240369 (234.7 KiB)
  #         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

## Check Router's Gateway (Router IP)

[Go Back to Contents](#contents)

```bash
  netstat -nr

  # Kernel IP routing table
  # Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
  # 0.0.0.0         10.0.0.1        0.0.0.0         UG        0 0          0 eth0
  # 0.0.0.0         10.0.0.1        0.0.0.0         UG        0 0          0 wlan0
  # 10.0.0.0        0.0.0.0         255.255.255.0   U         0 0          0 eth0
  # 10.0.0.0        0.0.0.0         255.255.255.0   U         0 0          0 wlan0
```

- In this case the router's ip is `10.0.0.1`

## dhcpcd.conf

[Go Back to Contents](#contents)

- In `/etc/dhcpcd.conf`

  - Add the following information on the first line:

    ```Bash
      interface eth0                                # Static ethernet adapter
      static ip_address=10.0.0.100/24               # Static IP address, 24 is domestic IP
      static routers=10.0.0.1                       # router's IP
      static domain_name_servers=8.8.8.8 8.8.8.4.4  # google's IP

      interface wlan0                               # Static wireless adapter
      static ip_address=10.0.0.99/24                # Static IP address, 24 is domestic IP
      static routers=10.0.0.1                       # router's IP
      static domain_name_servers=8.8.8.8 8.8.8.4.4  # google's IP
    ```

    - After saving the file, reboot (`sudo reboot now`)

## Update Interfaces

[Go Back to Contents](#contents)

- In `/etc/network/interfaces`

  ```Bash
    # interfaces(5) file used by ifup(8) and ifdown(8)

    # Please note that this file is written to be used with dhcpcd
    # For static IP, consult /etc/dhcpcd.conf and 'man dhcpcd.conf'

    # Include files from /etc/network/interfaces.d:
    source-directory /etc/network/interfaces.d

    auto lo
    iface lo inet loopback
    auto eth0
    auto wlan0
  ```

## Update wpa_supplicant.conf

- In `/etc/wpa_supplicant.conf`

  - add `update_config=1` to enable WiFi to connect using the system interface

    ```Bash
      update_config=1
    ```

# SQUID

## Check for Updates

[Go Back to Contents](#contents)

- On `Terminal`

  ```Bash
    sudo apt-get update
    sudo apt-get upgrade
  ```

## Install

### Squid

[Go Back to Contents](#contents)

- On `Terminal`

  ```Bash
    apt-get install -y squid3
  ```

#### Change squid.conf CHMOD

[Go Back to Contents](#contents)

- Change the read/write rights of `squid.conf`

  ```Bash
    sudo su
    chmod 777 /etc/squid/squid.conf
  ```

#### Update squid.conf

[Go Back to Contents](#contents)

- In `etc/squid/squid.conf`

  - Delete everything
  - Paste the code from [squid.conf](https://github.com/serverok/squid-proxy-installer/blob/master/squid.conf)
  - Change the port to **`3230`** and save the file

    ```Bash
      http_port 3230
      cache deny all
      hierarchy_stoplist cgi-bin ?

      access_log none
      cache_store_log none
      cache_log /dev/null

      refresh_pattern ^ftp: 1440 20% 10080
      refresh_pattern ^gopher: 1440 0% 1440
      refresh_pattern -i (/cgi-bin/|\?) 0 0% 0
      refresh_pattern . 0 20% 4320

      acl localhost src 127.0.0.1/32 ::1
      acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1

      acl SSL_ports port 1-65535
      acl Safe_ports port 1-65535
      acl CONNECT method CONNECT
      acl siteblacklist dstdomain "/etc/squid/blacklist.acl"
      http_access allow manager localhost
      http_access deny manager

      http_access deny !Safe_ports

      http_access deny CONNECT !SSL_ports
      http_access deny siteblacklist
      auth_param basic program /usr/lib/squid3/basic_ncsa_auth /etc/squid/passwd

      auth_param basic children 5
      auth_param basic realm Squid proxy-caching web server
      auth_param basic credentialsttl 2 hours
      acl password proxy_auth REQUIRED
      http_access allow localhost
      http_access allow password
      http_access deny all

      forwarded_for off
      request_header_access Allow allow all
      request_header_access Authorization allow all
      request_header_access WWW-Authenticate allow all
      request_header_access Proxy-Authorization allow all
      request_header_access Proxy-Authenticate allow all
      request_header_access Cache-Control allow all
      request_header_access Content-Encoding allow all
      request_header_access Content-Length allow all
      request_header_access Content-Type allow all
      request_header_access Date allow all
      request_header_access Expires allow all
      request_header_access Host allow all
      request_header_access If-Modified-Since allow all
      request_header_access Last-Modified allow all
      request_header_access Location allow all
      request_header_access Pragma allow all
      request_header_access Accept allow all
      request_header_access Accept-Charset allow all
      request_header_access Accept-Encoding allow all
      request_header_access Accept-Language allow all
      request_header_access Content-Language allow all
      request_header_access Mime-Version allow all
      request_header_access Retry-After allow all
      request_header_access Title allow all
      request_header_access Connection allow all
      request_header_access Proxy-Connection allow all
      request_header_access User-Agent allow all
      request_header_access Cookie allow all
      request_header_access All deny all
    ```

#### Config Squid

[Go Back to Contents](#contents)

- We need to cerate a login and password to access squid outside of the network

  ```Bash
    sudo su
    /user/bin/htpasswd -b -c /etc/squid/passwd <username> <password>  # press enter
    sudo service squid restart                                        # to load the new configuration
    service squid status                                              # just to check if everything is online
  ```

### Apache

[Go Back to Contents](#contents)

- On `Terminal`

  ```Bash
    apt-get install -y apache2-utils
  ```

### TFC Flow

[Go Back to Contents](#contents)

  ```Bash
    sudo apt-get install -y tcpflow
  ```

#### Start tcpflow

[Go Back to Contents](#contents)

- On `Terminal`

  ```Bash
    sudo tcpflow -p -c port 3230
  ```

## Router

[Go Back to Contents](#contents)

- Vivo Router

  ```bash
    http://192.168.15.1
    user:     admin
    password: xxxx
  ```

```Bash
  Configurações>Rede Local>Redirecionar Porta

  Nome da Regra: Roger-That-PiN
  Protocolo: UDP/TCP
  Porta Externa: 3230
  Porta Interna: 3230
  IP Externo: ""
  IP Interno: 192.168.15.30
```

## Remote.it

### Enable VNC

[Go Back to Contents](#contents)

- On `Terminal`

  ```Bash
    sudo raspi-config
        Select - 5) Interfacing Options
        Select - 3) P3 VNC
        Select - Enable VNC
  ```

### Check Port

[Go Back to Contents](#contents)

- Checkout VNC Port `5900`

  ```Bash
    sudo netstat -lpn | grep tcp
  ```

### Start Remote.it

- On `Terminal`

  ```Bash
    sudo connectd_installer

      Select - 1) Sign in to your existing remote3.it account
          # Enter your username <email>
          # Password
      # On the Main Menu
        Select - 1) Attach/reinstall remot3.it to an application
        Select - 3) VNC on port 5900        (Check if remote.it is using the right port 5900)
            # Name your device
                Roger-That-Pi1            (This will be the name of the service on Remote.it)
      Exit
  ```
