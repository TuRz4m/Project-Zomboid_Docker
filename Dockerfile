FROM ubuntu:14.04

MAINTAINER TuRzAm

ENV USERNAME anonymous
ENV PASSWORD ""
ENV STEAMGUARDCODE ""
ENV SERVERNAME "servertest"


# Install dependencies 
RUN apt-get update &&\ 
    apt-get install -y curl lib32gcc1 default-jre 


# Run commands as the steam user
RUN adduser \ 
	--disabled-login \ 
	--shell /bin/bash \ 
	--gecos "" \ 
	steam

# Copy & rights to folders
COPY update.sh /home/steam/update.sh

RUN chmod 777 /home/steam/update.sh
RUN mkdir -p /home/steam/Zomboid && chown -R steam /home/steam/Zomboid
RUN mkdir -p /home/steam/projectzomboid && chown -R steam /home/steam/projectzomboid


USER steam 

# download steamcmd
RUN mkdir /home/steam/steamcmd &&\ 
	cd /home/steam/steamcmd &&\ 
	curl http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz 


# First run is on anonymous to download the app
RUN /home/steam/steamcmd/steamcmd.sh +login anonymous +quit

# Make server port available to host : (10 slots)
EXPOSE 16261-16272

# /home/steam/Zomboid : Server Data
# /home/steam/projectzomboid : Server files & exe
VOLUME [ "/home/steam/Zomboid" , "/home/steam/projectzomboid" ]

# Update game (with credential) && lauch the game.
ENTRYPOINT ["/home/steam/update.sh"]
