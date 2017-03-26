#!/bin/bash
echo "BEGIN COPY @ $(date '+%Y/%m/%d_%H:%M:%S')"
if mount | grep encfs > /dev/null; then

while : ; do
   start=$SECONDS
   su -c "/home/plex/vpc/seed/copy.sh" -s /bin/sh plex 
   finish=$SECONDS
   duration=$((finish - start))
   echo "Duration of Copy was $duration seconds"
   [[ 3 < $duration ]] || break
done
rm -Rf /home/plex/completed/*
echo "COPY COMPLETED"
else
echo "ENCFS NOT MOUNTED"
fi
