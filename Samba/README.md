<h1 id='table-of-contents'>TABLE OF CONTENTS</h1>

- [Automatically Mount Hard Drive](#automatically-mount-hard-drive)
  - [Links](#links)
  - [Find Driver UUID](#find-driver-uuid)
  - [Automatically Mount Drive](#automatically-mount-drive)
- [Samba Drive](#samba-drive)
  - [Samba List](#samba-list)
    - [No Password](#no-password)
    - [With Password](#with-password)
  - [Reboot Samba](#reboot-samba)

# Automatically Mount Hard Drive

## Links

[Go Back to Contents](#table-of-contents)

- [How to create a Samba share using a Raspberry Pi and an External Hard Drive](https://gennaromigliaccio.com/creating-a-samba-share-using-a-raspberry-pi-and-an-external-hard-drive)
- [How to add or delete a samba user under Linux](https://www.thegeekdiary.com/how-to-add-or-delete-a-samba-user-under-linux/)

## Find Driver UUID

[Go Back to Contents](#table-of-contents)

```Bash
  sudo blkid
  # /dev/mmcblk0p1: LABEL_FATBOOT="boot" LABEL="boot" UUID="6341-C9E5" TYPE="vfat" PARTUUID="ea7d04d6-01"
  # /dev/mmcblk0p2: LABEL="rootfs" UUID="80571af6-21c9-48a0-9df5-cffb60cf79af" TYPE="ext4" PARTUUID="ea7d04d6-02"
  # /dev/sda2: LABEL="Server" UUID="B4BC2BCDBC2B8946" TYPE="ntfs" PTTYPE="atari" PARTLABEL="Basic data partition" PARTUUID="32e102ed-e033-4790-807a-020907a6560a"
  # /dev/sdb1: LABEL="DB" UUID="eca90f4f-75e0-4817-99ac-8e2ea09bd70d" TYPE="ext4" PARTUUID="fe297894-9b7b-4032-a421-f969f2eaba12"
  # /dev/sdc1: LABEL_FATBOOT="EFI" LABEL="EFI" UUID="67E3-17ED" TYPE="vfat" PARTLABEL="EFI System Partition" PARTUUID="f4d157ca-43c6-4b3d-bdaa-86584cf2f1b5"
  # /dev/sdc2: LABEL_FATBOOT="120GB" LABEL="120GB" UUID="FAAB-16FE" TYPE="vfat" PARTUUID="3de7aa76-0954-4c1d-8937-24ed6ccc9763"
  # /dev/mmcblk0: PTUUID="ea7d04d6" PTTYPE="dos"
  # /dev/sda1: PARTLABEL="Microsoft reserved partition" PARTUUID="5030def0-a593-427b-b882-8394ea8629af"
```

> `UUID="B4BC2BCDBC2B8946"`

## Automatically Mount Drive

[Go Back to Contents](#table-of-contents)

```Bash
  sudo vim /etc/fstab
```

Add the UUID to the list

```Bash
  UUID=B4BC2BCDBC2B8946 /mnt/USB1 auto defaults,user,nofail 0 2
```

# Samba Drive

## Samba List

[Go Back to Contents](#table-of-contents)

```Bash
  sudo apt-get install samba samba-common-bin
  sudo vim /etc/samba/smb.conf
```

### No Password

[Go Back to Contents](#table-of-contents)

```Bash
  [USB1 - Data]
  comment = Data
  path = /mnt/USB1/Data
  public = yes
  only guest = yes
  browseable = yes
  read only = no
  writeable = yes
  create mask = 0777
  directory mask = 0777
  force create mask = 0777
  force directory mask = 0777
  force user = roger-that
  force group = root
```

### With Password

[Go Back to Contents](#table-of-contents)

```Bash
  [Server]
  comment = Server
  path = /mnt/USB1
  public = no
  writeable = yes
  create mask = 0777
  directory mask = 0777
  valid users = roger-that
```

Define a Samba password

```Bash
  sudo smbpasswd -a roger-that
```

Delete a Samba user

```Bash
  sudo smbpasswd -x roger-that
```

## Reboot Samba

[Go Back to Contents](#table-of-contents)

```Bash
  sudo systemctl restart smbd
```
