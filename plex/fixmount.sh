#!/bin/sh
FILE="/home/plex/amazondrive/test.txt"
if [ -f "$FILE" ];
then
else
  if pidof -o %PPID -x "root_update.sh"; then
    echo "down, but updating... @ $(date '+%Y/%m/%d_%H:%M:%S')"
  else
    echo "went down - remounting @ $(date '+%Y/%m/%d_%H:%M:%S')"
    acd_cli umount /home/plex/amazondrive
    acd_cli mount /home/plex/amazondrive
  fi
fi
