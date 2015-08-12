# Project Zomboid - Docker

Docker build for project zomboid server.

## Usage

You need to run  the container in interactive mode the first time in order to enter the Steam Guard code (and the database admin password).

Exemple : 
`docker run -i -t -a stdin -a stdout -a stderr -e USERNAME="MySteamUserName" -e PASSWORD="MySteamPassword" -e SERVERNAME="NameOfInstance" --name zomboid -v /data/zomboid-data:/home/steam/Zomboid -v /data/zomboid-server:/home/steam/projectzomboid  TuRzAm/zomboid`
> To quit the console, use Ctrl+q,Ctrl+p,Ctrl+c [(source)](http://docs.docker.com/articles/basics/#running-an-interactive-shell)

## Variables
+ __USERNAME__
Steam Username (you cannot download the server in anonymous)
+ __PASSWORD__
Steam password
+ __SERVERNAME__
Name of the project zomboid server.

## Volumes
+ __/home/steam/Zomboid__
Data dir of the server. Contains db, config files...
+ __/home/steam/projectzomboid__
Application dir of the server. Contains the mods directory.

## Expose
+ Port : 16261 : server
+ Ports 16262-16272 : clients slots (10).

## Known issues
+ `docker stop` won't save the game.
You can use instead :
`docker attach zomboid
quit` 
