#!/usr/bin/env bash
[ -p /tmp/FIFO ] && rm /tmp/FIFO
mkfifo /tmp/FIFO

# Check if both directory are writable
if [ ! -w /home/steam/Zomboid ]; then 
	echo "[Error] Can't access your data directory. Check permissions on your mapped directory with /home/steam/Zomboid."
	exit 1
fi

if [ ! -w /home/steam/projectzomboid ]; then 
	echo "[Error] Can't access your server files directory. Check permissions on your mapped directory with /home/steam/projectzomboid."
	exit 1
fi



echo -e "Update project zomboid..."
/home/steam/steamcmd/steamcmd.sh +login anonymous \
		+force_install_dir /home/steam/projectzomboid \
		+app_update 380870 \
		+quit

# Only change password is it doesn't exist
INIFILE="/home/steam/Zomboid/Server/${SERVERNAME}.ini"
sed -i -e s/RCONPassword=[[:space:]/RCONPassword=${RCON_PASSWORD}/ $INIFILE



echo -e "Launching server..."
/home/steam/projectzomboid/start-server.sh -servername ${SERVERNAME} -steamport1 ${STEAMPORT1} -steamport2 ${STEAMPORT2} -adminpassword ${ADMINPASSWORD} &


# save & exit when docker stop or Ctrl+C
trap 'echo "Shutdown server..."; /home/steam/rcon -P${RCON_PASSWORD} -a127.0.0.1 -p27015 quit' INT
trap 'echo "Shutdown server..."; /home/steam/rcon -P${RCON_PASSWORD} -a127.0.0.1 -p27015 quit' TERM
read < /tmp/FIFO &
wait
