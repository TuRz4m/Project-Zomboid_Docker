# Project Zomboid - Docker

Docker build for project zomboid server.

## History

v1.0: First version for non steam server [now broken]  
v1.1: New version for Project Zomboid Steam dedicated server  
v1.2: Minor fixes (asking for frontend disabled, sed parse error removed)  

## Usage
`docker run -d -e SERVERNAME="MyServerName" -e ADMINPASSWORD="myadminpassword" -e RCON_PASSWORD="rconpassword"  -v /My/path/to/My/Config/and/data:/server-data -p 16261:16261 -p 16261:16261/udp -p 8766:8766 -p 8767:8767 -p 16262-16272:16262-16272 --name zomboid turzam/zomboid`

- You can map the directory containing server files with -v /my/path:/server-files.  
- You need to bind X ports for client connection. (Example : If you have 10 slots, you need to put -p 16262-16272:16262-16272, if you have 100 slots, you need to put -p 16262-16362:16262-16362).
- Port 16261 need to be bind in tcp AND udp.
- Once you have run the docker for the first time, you can edit your config file in your map directory /server-data. (In Server/$SERVERNAME.ini)
- SERVERNAME is not the display name of your server, you need to edit /server-data/Server/$SERVERNAME.ini.

## Variables
+ __SERVERNAME__
Name of your server (for db & ini file)
+ __ADMINPASSWORD__
Admin password on your server
+ __RCON_PASSWORD__
RCON Password (will be change in your ini file if there is no password set)
Used to save when you stop the docker.

## Volumes
+ __/server-data_
Data dir of the server. Contains db, config files...
+ __/server-files__
Application dir of the server. Contains the mods directory.

## Expose
+ Port : 16261 : server (udp/tcp)
+ Port : 8766/8767 : Steam port
+ Ports 16262-162XX : clients slots (depends on the number of player you want).

## Known issues

