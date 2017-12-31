#!/bin/bash

#
#	This script stops all processes of steam and TF2
#

sudo kill `cat /tmp/cat-accgen-pid`
sudo kill `cat /tmp/cat-webpanel-pid`
sudo kill `cat /tmp/cat-server-pid`
sudo killall -9 hl2_linux
sudo killall -9 steam