#!/bin/bash

#
#	This script performs installation of nullifiedcat account generator
#

if [ $EUID == 0 ]; then
	echo "This script must not be run as root"
	exit
fi

git clone -b v1.1 https://github.com/nullifiedcat/account-generator --recursive

pushd account-generator
./install.sh
popd