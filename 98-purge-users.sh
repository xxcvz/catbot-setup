#!/bin/bash

#
#	Will delete all catbot- users and their home directories
#

read -p "Press ENTER to continue"

for i in {2..32}
do
	if ! [ -d "/home/catbot-$i" ]; then
		echo "No catbot $i";
		continue;
	fi
	echo "Deleting user catbot-$i"
	sudo userdel -r catbot-$i
	sudo groupdel catbot-$i
done