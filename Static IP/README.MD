# Static IP

* [YT - Squid Server](https://www.youtube.com/watch?v=D1eD60_jhKI&t)

### Static IP - Fresh Install

**1.) Check your local IP address**

```
   ifconfig
```

**2.) Check your gateway (Router IP)**

```
   netstat -nr                                     // geteway: 192.168.15.1
```

**3.) Edit local file**

```
   sudo nano /etc/dhcpcd.conf
```

* Add the following information on the first line:

```
      interface eth0                                  // eth0, wired connection
      static ip_address=192.168.15.30/24              // static IP address, 24 is a domestic
      static routers=192.168.15.1                     // router's IP
      static domain_name_servers= 8.8.8.8 8.8.8.4.4   // google's IP
      // add an enter to separete from the conf file
```

**4.) Ctrl + X (Exit)**

**5.) Y**

**6.) Enter    (To save)**

**7.) Reboot** 

```
   sudo reboot
```

### Update Config

**1.) Edit local file**

```
   sudo nano /etc/dhcpcd.conf
```

* Add the following information on the first line:

```
      // interface eth0                                  // eth0, wired connection
      static ip_address=192.168.15.30/24                 // static IP address, 24 is a domestic
      static routers=192.168.15.1                        // router's IP
      // static domain_name_servers= 8.8.8.8 8.8.8.4.4   // google's IP
      // add an enter to separete from the conf file
```

**2.) Ctrl + X (Exit)**

**3.) Y**

**4.) Enter (To save)**

**5.) Reboot** 

```
   sudo reboot
```