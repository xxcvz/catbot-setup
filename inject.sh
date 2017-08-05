#!/usr/bin/env bash

proc=${1:-$(ps $(pidof gameoverlayui) | tail -n1 | cut -d\- -f2 | cut -d\  -f2)}
if ! [[ $proc =~ ^[0-9]+$ ]]; then
   echo "Couldn't find process! Are you sure a game is running?" >&2; exit 1
fi

sudo rm -rf /tmp/dumps # Remove if it exists
sudo mkdir /tmp/dumps # Make it as root
sudo chmod 000 /tmp/dumps # No permissions

FILENAME="/tmp/.gl$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)"

cp "cathook/libcathook.so" "$FILENAME"

echo loading "$FILENAME" to "$proc"

sudo killall -19 steam
sudo killall -19 steamwebhelper

gdb -n -q -batch \
  -ex "attach $proc" \
  -ex "set \$dlopen = (void*(*)(char*, int)) dlopen" \
  -ex "call \$dlopen(\"$FILENAME\", 1)" \
  -ex "call dlerror()" \
  -ex 'print (char *) $2' \
  -ex "detach" \
  -ex "quit"
  
rm $FILENAME

sudo killall -18 steamwebhelper
sudo killall -18 steam
