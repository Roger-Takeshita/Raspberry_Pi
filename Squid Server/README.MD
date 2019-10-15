# 1) Static IP

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
    
# 2) Squid

### On Terminal

**1.) Check if Raspberry is updated**

```
   sudo apt-get update
   sudo apt-get upgrade
```

**2.) Install Squid**

```
   pt-get install -y squid3
```

**3.) Install Apache**

```
   apt-get install -y apache2-utils
```

**4.) Change the read/write rights of `squid.conf`**

* Change access to super user

```
      sudo su
      chmod 777 /etc/squid/squid.conf
```

### On Rasbian

**5.) Edit `squid.conf`**

```
   etc/squid/squid.conf
```

* Delete everything
* Paste the code from [link](https://github.com/serverok/squid-proxy-installer/blob/master/squid.conf)
* Change the port to **`3230`** and save the file

### On Terminal

**6.) Still using super user, create a login and password**

```
   /user/bin/htpasswd -b -c /etc/squid/passwd <username> <password>  (enter)
   sudo service squid restart                                        (to load the new configuration)
   service squid status                                              (just to check if everything is online)
```

# 3) Router

* Vivo Router

```
      http://192.168.15.1
      user:     admin
      password: xxxx
```

```
      Configurações>Rede Local>Redirecionar Porta
      
         Nome da Regra: Roger-That-PiN
         Protocolo: UDP/TCP
         Porta Externa: 3230
         Porta Interna: 3230
         IP Externo: ""
         IP Interno: 192.168.15.30
```

# 4) Remote.it

* [YT - Remote.it](https://www.youtube.com/watch?v=sHaY4EBQowQ&t)

**1.) Enable VNC on Raspberry Pi Terminal**

```
   sudo raspi-config
   
      Select - 5) Interfacing Options
      Select - 3) P3 VNC
      Select - Enable VNC
```

**2.) Checkout VNC Port `5900`**

```
   sudo netstat -lpn | grep tcp
```

**3.) Run Remote.it**

```
   sudo connectd_installer

      Select - 1) Sign in to your existing remote3.it account
         Enter your username <email>
         Password
      On the Main Menu
         Select - 1) Attach/reinstall remot3.it to an application
         Select - 3) VNC on port 5900        (Check if remote.it is using the right port 5900)
         Name your device
            Roger-That-Pi1                   (This will be the name of the service on Remote.it)
         Exit
```

# 5) TFC Flow

**1.) Install**

```
   sudo apt-get install -y tcpflow
```

**2.) Run tcpflow**

```
   sudo tcpflow -p -c port 3230
```