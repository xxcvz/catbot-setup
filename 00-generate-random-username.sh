#!/bin/bash

#
# Script generates random 16-char length string that will be used for usernames
#

name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
echo $name > kisak
