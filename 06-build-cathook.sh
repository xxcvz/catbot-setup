#!/bin/bash

#
#	This script builds textmode build of cathook (in user's cathook folder)
#

numcpu=$(grep -c ^processor /proc/cpuinfo)
cathook=$(cat cathook-location)

if [ $EUID == 0 ]; then
	echo "This script must not be run as root"
	exit
fi

if ! [ -e "$cathook/" ] || ! [ -e "$cathook/.git" ] || ! [ -e "$cathook/src/hack.cpp" ]; then
	echo "Specified path doesn't point to cathook directory"
	exit
fi

echo "WARNING: Your current build of cathook will be deleted"
echo "You will have to re-compile cathook after this"
read -p "Press enter to continue or Ctrl+C (close) to stop."

sudo mkdir -p "/opt/cathook/bin"
sudo rm "/opt/cathook/bin/libcathook-textmode.so"

pushd "$cathook"

make clean
make -j$numcpu NO_WARNINGS=1 TEXTMODE_VAC=1 NO_VISUALS=1

if ! [ -e "bin/libcathook.so" ]; then
	echo "FATAL: Build failed"
	exit
fi

popd

sudo cp "$cathook/bin/libcathook.so" "/opt/cathook/bin/libcathook-textmode.so"