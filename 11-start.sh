#!/bin/bash

#
#	This script starts IPC server, account generator, etc..
#

if [ $EUID == 0 ]; then
	echo "This script must not be run as root"
	exit
fi

xhost +

/opt/cathook/ipc/bin/server -s >/dev/null &
pushd account-generator
node app >/tmp/cathook-accgen.log &
echo $! >/tmp/cat-appgen-pid
popd
pushd cathook-ipc-web-panel
./run.sh &
echo $! >/tmp/cat-webpanel-pid
popd

sleep 5;

echo "Account generator password: `cat /tmp/cat-accgen2-password`"
echo "IPC Web Panel password: `cat /tmp/cat-webpanel-password`"