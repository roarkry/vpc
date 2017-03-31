#!/bin/sh
FILE="/home/plex/amazondrive/test.txt"  
if [ -f "$FILE" ];
then echo "still up"
else  
  acd_cli umount /home/plex/amazondrive
  acd_cli mount /home/plex/amazondrive
fi
