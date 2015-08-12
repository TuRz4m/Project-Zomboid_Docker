#!/usr/bin/env bash

echo -e "Update project zomboid..."
/home/steam/steamcmd/steamcmd.sh +login ${USERNAME} ${PASSWORD} ${STEAMGUARDCODE} \
		+force_install_dir /home/steam/projectzomboid \
		+app_update 108600 \
		+quit
# Ask for the steam guard code the first time : need to be in interactive mode.
# # Auth failure : 8
if [ $? -eq 8 ]; then
	echo  -e "For the first run, launch docker run with options :  -i -t -a "
else 
	echo -e "Launch server..."
	/home/steam/projectzomboid/projectzomboid-dedi-server.sh -servername ${SERVERNAME}
fi
