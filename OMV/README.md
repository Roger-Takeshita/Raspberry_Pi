<h1 id='summary'>Summary</h1>

* [Links](#links)
* [Static IP - Fresh Install](#staticip)
* [OpenMediaVault - Raspbery 4](#omv)

<h1 id='links'>Links</h1>

[Go Back to Summary](#summary)

* [OpenMediaVault](https://www.openmediavault.org/download.html)
* [Rasbian](https://www.raspberrypi.org/downloads/raspbian/)
* [Raspberry Imager - Windows](https://downloads.raspberrypi.org/imager/imager.exe)
* [Raspberry Imager - Mac](https://downloads.raspberrypi.org/imager/imager.dmg)
* [Raspberry Imager - Ubuntu](https://downloads.raspberrypi.org/imager/imager_amd64.deb)
* [SD Card Formatter](https://www.sdcard.org/downloads/formatter/)
* [h2testw - Image Burner](https://h2testw.en.lo4d.com/windows)
* [Etcher - Image Burner](https://www.balena.io/etcher/)
* [OMV PDF Tutorial](https://github.com/OpenMediaVault-Plugin-Developers/docs/blob/master/Adden-B-Installing_OMV5_on_an%20R-PI.pdf)
* [OMV GitHub](https://github.com/OpenMediaVault-Plugin-Developers)
* [OMV GitHub - installScript](https://github.com/OpenMediaVault-Plugin-Developers/installScript/blob/master/README.md)


<h1 id='staticip'>Static IP - Fresh Install</h1>

[Go Back to Summary](#summary)


**1.) Check your local IP address**

  ```bash
    ifconfig
  ```

**2.) Check your gateway (Router IP)**

  ```bash
    netstat -nr        # geteway: 192.168.0.1
  ```

**3.) Edit local file**

  ```bash
    sudo nano /etc/dhcpcd.conf
  ```


* sudo nano /etc/network/interfaces
* [RPi Setting up a static IP in Derbian](https://elinux.org/RPi_Setting_up_a_static_IP_in_Debian)

  ```Bash
    # The loopback interface
    auto lo
    iface lo inet loopback
    auto eth0
    iface eth0 inet static
    #your static IP
    address 192.168.0.100  
    #your gateway IP
    gateway 192.168.0.1
    netmask 255.255.255.0
    #your network address "family"
    # network 192.168.1.0
    # broadcast 192.168.1.255
  ```

* sudo /etc/init.d/networking restart
* sudo /etc/init.d/networking reload

* Add the following information on the first line:

  ```bash
    profile static_eth0
    static ip_address=192.168.0.100/24
    static routers=192.168.0.1
    static domain_name_servers=8.8.8.8 8.8.8.4.4

    interface eth0
    fallback static_eth0
  ```

* sudo systemctl enable dhcpcd.service


* Comments line by line
  
  ```bash
    interface eth0                                  # eth0, wired connection
    static ip_address=192.168.0.100/24              # static IP address, 24 is a domestic
    static routers=192.168.0.1                      # router's IP
    static domain_name_servers= 8.8.8.8 8.8.8.4.4   # google's IP
    // add an enter to separete from the conf file
  ```

* **Ctrl + X** - To Exit
* **Y** - To save modifications
* **Enter**
* **sudo reboot** - To reboot the Pi 

<h1 id='newinstall'>New Install</h1>

[Go Back to Summary](#summary)

* Download Rasbian Lite
* Create a file `ssh` without extension on the root folder
* After install log in via ssh, on terminal 

  ```Bash
    ssh pi@192.168.0.21
  ```

* password `raspberry`
* change the password `passwd`
* sudo adduser pi ssh
* sudo apt-get update
* sudo apt-get upgrade
* sudo reboot

<h1 id='ssh'>SSH</h1>

[Go Back to Summary](#summary)
  
* Change /etc/hostname
  * `sudo nano /etc/hostname`
    * Change raspberrypi to your desired hostname
    * Hit CTRL+O and then ENTER to Save
    * Hit CTRL+X to Exit
* Change /etc/hosts
  * `sudo nano /etc/hosts`
    * Change raspberrypi to your desired hostname
    * Hit CTRL+O and then ENTER to Save
    * Hit CTRL+X to Exit


<h1 id='staticip'>Static Ip</h1>

[Go Back to Summary](#summary)

Open OMV Web GUI:

* OMV > System > Network > Interfaces
* Select eth0
* Click Edit
  * Under IPv4 Method choose Static
  * Set your IP address, Netmask and Gateway
  * Click Save
  * **DO NOT** click Apply or you will get an an error!

* Connect via SSH:
  * We have to remove the file eth0. It contains the entry: iface eth0 inet dhcp

  ```Bash
    rm etc/network/interface.d/eth0
    systemctl stop dhcpcd
    systemctl disable dhcpcd
  ```

* reboot
* Login to the OMV Web GUI with your new static IP address
Click Apply (the yellow toolbar at the top of the window)
* Now static IP should work

<h1 id='omv'>OpenMediaVault</h1>

[Go Back to Summary](#summary)

<h2 id='installation'>Installation</h2>

[Go Back to Summary](#summary)

* This tutorial is using the `OMV 5.x for Single Board Computers`

  ```Bash
    wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash
  ```

  ```Bash
    sudo reboot
  ```

<h2 id='login'>Log In</h2>

[Go Back to Summary](#summary)

* The default user is:
  * login: `admin`
  * password: `openmediavault`

<h2 id='changepassword'>Change Password</h2>

[Go Back to Summary](#summary)

* System/General Settings/Web Administrator Password
* System/General Settings/General Settings/Auto Logout
* System/Network/Hostname


sudo docker swarm init --advertise-addr 192.168.0.100

etc-pihole etc-dnsmasq.d

<h1 id='pihole'>Pihole</h1>

[Go Back to Summary](#summary)

```Bash
version: "3"

services:
  pihole:
    image: pihole/pihole:latest
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "67:67/udp"
      - "80:80/tcp"
      - "443:443/tcp"
    environment:
      TZ: 'Canada/Eastern'
      WEBPASSWORD: 'password' #Your Password Goes Here
      ServerIP: '192.168.0.100' #Your Server IP Goes Here
    volumes:
       - '/srv/dev-disk-by-label-DB/Config/Pihole/etc-pihole/:/etc/pihole/'
       - '/srv/dev-disk-by-label-DB/Config/Pihole/etc-dnsmasq.d/:/etc/dnsmasq.d/'
    dns:
      - 127.0.0.1
      - 1.1.1.1
    # Recommended but not required (DHCP needs NET_ADMIN)
    # https://github.com/pi-hole/docker-pi-hole#note-on-capabilities
    cap_add:
      - NET_ADMIN
    restart: unless-stopped
```

<h1 id='plex'>Plex</h1>

[Go Back to Summary](#summary)






sudo nano /usr/lib/plexmediaserver/lib/plexmediaserver.default

    #export PLEX_MEDIA_SERVER_USER=plex
    - change from `plex` to `pi`

sudo systemctl restart plexmediaserver

sudo nano /boot/cmdline.txt
    - change the ip to a static ip address


/dev/mmcblk0p1: LABEL_FATBOOT="boot" LABEL="boot" UUID="6341-C9E5" TYPE="vfat" PARTUUID="ea7d04d6-01"
/dev/mmcblk0p2: LABEL="rootfs" UUID="80571af6-21c9-48a0-9df5-cffb60cf79af" TYPE="ext4" PARTUUID="ea7d04d6-02"
/dev/mmcblk0: PTUUID="ea7d04d6" PTTYPE="dos"
/dev/sda1: PARTLABEL="Microsoft reserved partition" PARTUUID="5030def0-a593-427b-b882-8394ea8629af"

/dev/sdc1: LABEL="DB" UUID="eca90f4f-75e0-4817-99ac-8e2ea09bd70d" TYPE="ext4" PARTUUID="fe297894-9b7b-4032-a421-f969f2eaba12"
/dev/sdb1: LABEL="MEDIA" UUID="041810db-e417-426c-aaf7-da3d69d0228b" TYPE="ext4" PARTUUID="3d741674-9cc5-43dc-965d-b661ead83af9"
/dev/sda2: LABEL="Server" UUID="B4BC2BCDBC2B8946" TYPE="ntfs" PTTYPE="atari" PARTLABEL="Basic data partition" PARTUUID="32e102ed-e033-4790-807a-020907a6560a"


UUID=B4BC2BCDBC2B8946 /mnt/USB1 auto defaults,user,nofail 0 2
UUID=041810db-e417-426c-aaf7-da3d69d0228b /mnt/USB2 auto defaults,user,nofail 0 2
UUID=eca90f4f-75e0-4817-99ac-8e2ea09bd70d /mnt/USB3 auto defaults,user,nofail 0 2


[USB1 - Videos]
comment = Videos
public = yes
writeable = yes
browsable = yes
path = /mnt/USB1/Videos
create mask = 0777
directory mask = 0777
guest ok = yes
only guest = no

[USB2 - Media]
comment = Media
public = yes
writeable = yes
browsable = yes
path = /mnt/USB2/
create mask = 0777
directory mask = 0777
guest ok = yes
only guest = no

[USB3 - DB]
comment = DB
public = yes
writeable = yes
browsable = yes
path = /mnt/USB2/
create mask = 0777
directory mask = 0777
guest ok = yes
only guest = no

https://www.youtube.com/watch?v=zRj9mrwISZ8&list=PLTJsJmKUxIW2zwEaUsDiCs4N7YKah2ned&index=13&t=27s

https://www.youtube.com/watch?v=PpH6JeLk6uA

https://drive.google.com/file/d/1bg3jRe2jWSu1ciTOcJSligPID5gZ04DH/view

https://pimylifeup.com/raspberry-pi-plex-server/