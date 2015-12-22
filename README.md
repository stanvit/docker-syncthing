# Minimal Syncthing Docker image

[![](https://badge.imagelayers.io/stanvit/syncthing:latest.svg)](https://imagelayers.io/?images=stanvit/syncthing:latest 'Get your own badge on imagelayers.io')


[This](https://hub.docker.com/r/stanvit/syncthing/) Docker image is based on the minimal [Alpine Linux](http://alpinelinux.org/) [image](https://hub.docker.com/_/alpine/).

## Features

  * Minimal size: 23Mb uncompressed, 9Mb compressed
  * Ability to set arbitrary UID for the data and config files, so it could be ran on a desktop system or share data with other instances

## Creating an instance

    docker run -d --name=syncthing \
    -p 8384:8384 -p 22000:22000 -p 21027:21027/udp \
    -v syncthing-data:/Data -v syncthing-config:/Config \
    -e SYNCTHING_USERID=1003 \
    stanvit/syncthing

The `SYNCTHING_USERID` environment variable defines the UID of configuration and data files stored at the corresponding volumes.


`/Data` volume keeps the "default" Syncthing folder

`/Config` volume is used to store Syncthing configuration file, keys certificates and databases.
