#!/bin/bash

#
#	12 is pretty insane amount amount and requires ~18GB ram, but for users who are too lazy to add a number at the end, let's just use the previous as default
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

for i in $(seq 1 $max)
do
	echo "Creating user catbot-$i"
	sudo useradd -m catbot-$i
	sudo usermod -g catbots catbot-$i
	sudo -H -u catbot-$i bash -c "mkdir -p /home/catbot-$i/.local/share/Steam"
	sudo -H -u catbot-$i bash -c "ln -s \"/opt/steamapps\" \"/home/catbot-$i/.local/share/Steam/steamapps\""
done
