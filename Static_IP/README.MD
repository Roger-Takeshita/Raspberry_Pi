# STATIC IP

## Table of Contents

<details>
  <summary id='table-of-contents'>
    <strong>Table of Contents</strong>
  </summary>

<!-- Begin Table of Contents GFM -->

- [Check Current IP Address](#check-current-ip-address)
- [Check Router's Gateway (Router IP)](#check-routers-gateway-router-ip)
- [dhcpcd.conf](#dhcpcdconf)
- [Update Config](#update-config)
- [Update wpa_supplicant.conf](#update-wpa_supplicantconf)

<!-- End Table of Contents -->

</details>

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
      static domain_name_servers=10.0.0.1           # router's IP
      # static domain_name_servers=8.8.8.8 8.8.4.4    # google's IP

      interface wlan0                               # Static wireless adapter
      static ip_address=10.0.0.100/24               # Static IP address, 24 is domestic IP
      static routers=10.0.0.1                       # router's IP
      static domain_name_servers=10.0.0.1           # router's IP
      # static domain_name_servers=8.8.8.8 8.8.4.4  # google's IP
    ```

    - After saving the file, reboot (`sudo reboot now`)

## Update Config

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
