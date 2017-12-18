#!/bin/bash

#
#	Symlinks
#

max=12

if [ "$#" == 1 ]; then
	max=$1
fi

if ! [ -e "/opt/steamapps" ]; then
	echo "Can't find steamapps folder."
	echo "Please, run scripts in the right order."
	exit
fi

read -p "Press ENTER to continue"

STEAM_ROOT=/home/catbot-1/.steam/steam

cd $STEAM_ROOT ; while [ $(pwd) != "/" ]; do echo $(pwd); sudo chmod +x .; cd ..; done
sudo chmod g+rwx -R $STEAM_ROOT

for i in $(seq 2 $max)
do
	if ! [ -d "/home/catbot-$i" ]; then
		echo "No catbot $i";
		continue;
	fi
	echo "Linking for catbot-$i"
	sudo -H -u catbot-$i bash -c "mkdir -p \"/home/catbot-$i/.local/share/Steam\""	
	if ! [ -e "/home/catbot-$i/.steam/steam" ]; then
		sudo -H -u catbot-$i bash -c "mkdir -p \"/home/catbot-$i/.steam\""
		sudo -H -u catbot-$i bash -c "ln -s \"/home/catbot-$i/.local/share/Steam\" \"/home/catbot-$i/.steam/steam\""
	fi
	cd /home/catbot-$i/.local/share/Steam
	for s in package graphics ubuntu12_32 resource tenfoot bin friends servers bootstrap.tar.xz; do
		sudo rm -rf "/home/catbot-$i/.steam/steam/$s"
		sudo -H -u catbot-$i bash -c "ln -s \"$STEAM_ROOT/$s\" \"/home/catbot-$i/.local/share/Steam/$s\""	
	done
done
