# PLEX

## Installation

```bash
  sudo apt-get install apt-transport-https
  curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
  echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
  sudo apt-get update
  sudo apt install plexmediaserver
```
