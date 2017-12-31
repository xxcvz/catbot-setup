#!/bin/bash

#
#	This script performs installation of webpanel
#

if [ $EUID == 0 ]; then
	echo "This script must not be run as root"
	exit
fi

git clone -b v1.1 https://github.com/nullifiedcat/cathook-ipc-web-panel --recursive

pushd cathook-ipc-web-panel
./install.sh
popd