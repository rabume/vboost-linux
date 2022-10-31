#!/bin/bash
# Script do delete lock file

while :
do

FILE=/tmp/source_engine_2849099857.lock

if [ ! -f "$FILE" ]; then
sleep 1
fi

if [ -f "$FILE" ]; then
rm "$FILE"
echo "Lockfile deleted!"
fi

done
