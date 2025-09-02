# RASPBERRYPI

<details>
  <summary id='table-of-contents'>
    <strong>Table of Contents</strong>
  </summary>

<!-- Begin Table of Contents GFM -->

- [Docs](#docs)
- [Commands](#commands)
  - [Upgrade](#upgrade)
  - [Reboot/Shutdown](#rebootshutdown)
  - [Install/Remove](#installremove)
- [SD Backup](#sd-backup)
  - [Command Line](#command-line)

<!-- End Table of Contents -->

</details>

## Docs

- [Static IP](/Static_IP)
- [Remote.it](/Remote.it)
- [Squid Server](/Squid_Server)
- [Open Media Vault](/OMV)

## Commands

### Upgrade

```Bash
   sudo apt-get update
   sudo apt-get upgrade
```

### Reboot/Shutdown

```bash
   sudo reboot
   sudo shutdown -h now
```

### Install/Remove

```bash
   sudo get-apt install
   sudo get-apt remove
```

## SD Backup

![](./assets/images/2023-05-14-18-11-11.png)

```bash
  sudo dd if=/dev/disk4 of=/Users/roger-that/Desktop/RaspberryPi.dmg

  # 62521344+0 records in
  # 62521344+0 records out
  # 32010928128 bytes transferred in 1046.526854 secs (30587775 bytes/sec)
```

> Since we are running the command using `sudo` we need to specify the full path (user path) to output the image

### Command Line

```bash
diskutil list
# /dev/disk5 (internal, physical):
#    #:                       TYPE NAME                    SIZE       IDENTIFIER
#    0:     FDisk_partition_scheme                        *32.0 GB    disk5
#    1:             Windows_FAT_32 boot                    268.4 MB   disk5s1
#    2:                      Linux                         31.7 GB    disk5s2

diskutil unmountDisk /dev/disk5
# Unmount of all volumes on disk5 was successful

sudo dd if=/dev/rdisk5 of=/Users/roger-that/Desktop/pi_full_backup.img bs=4m status=progress
```
