if mount | grep encfs > /dev/null; then
export LD_LIBRARY_PATH=/usr/lib/plexmediaserver
/usr/lib/plexmediaserver/Plex\ Media\ Scanner --scan --section 1
/usr/lib/plexmediaserver/Plex\ Media\ Scanner --scan --section 2
/usr/lib/plexmediaserver/Plex\ Media\ Scanner --refresh --section 1
/usr/lib/plexmediaserver/Plex\ Media\ Scanner --refresh --section 2
fi
