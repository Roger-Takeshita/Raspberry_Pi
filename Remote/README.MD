# Remote.it

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