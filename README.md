# Files in GitHub

This repo should be cloned to each server's /home/plex folder.  The file naming convention [server]-[user to run as]-[script description].sh

It also assumes each box (SEED and PLEX) has a **plex** user in addition to root (hence the /home/plex references)

# Cron Jobs

## SEED

@reboot /home/plex/vpc/seed/root_rtorrent_start.sh

@reboot /home/plex/vpc/seed/root_route_setup.sh

*/20 * * * * /home/plex/vpc/seed/root_copy.sh >> /home/plex/copylogs.txt

## PLEX

20 * * * * /home/plex/vpc/plex/root_update.sh >> /home/plex/updatelogs.txt

# Upon Reboot

## SEED
 - mount encfs reverse encryption folder as plex user (seed-plex-mountReverse.sh)
 - Set the download folder for /home/plex/downloads
 - Get automove working (see below)

## PLEX
 - mount encfs and acd_cli as plex user (plex-plex-mount.sh)

# Reference

## RTORRENT/RUTORRENT Automove

Set the download folder, switch the automove configuration from copy to move again, and then reset apache2 (sudo services apache2 restart)

## SEED Overview

Setting up a Seedbox using OpenVPN and PIA in Ubuntu 14.04.
Had issue around DNS, which was resolved using the first link - had to hard code nameservers in /etc/resolv.conf (removed everything else). Third link has alternative openvpn.zip files. Had to also disable Auto-configure Networking in Linode Setup access to SSH (via second link).
Setup ip table and routes, etc...
Setup rtorrent (last links). Running rtorrent as a non-root user. Use auto tools to move files upon completion. Subscribe to RSS feed and auto download all files matching /.*/ filter.
Completed folder has a reverse encfs directory on top of it. Every 20 minutes a crontab job kicks off. It makes sure everything is copied via rclone copy and then deletes the completed files.

Primary Folders:
 - /home/plex/downloads (in progress downloads)
 - /home/plex/completed (completed files are moved here to be copied to ACD)
 - /home/plex/encrypted (encrypted mount of completed directory: readonly)

References:
 - http://www.htpcguides.com/autoconnect-private-internet-access-vpn-boot-linux/
 - https://forum.linode.com/viewtopic.php?t=8737
 - https://helpdesk.privateinternetaccess.com/hc/en-us/articles/219438247-InstallingOpenVPN-PIA-on-Linux
 - http://linoxide.com/ubuntu-how-to/setup-rtorrent-rutorrent/
 - https://www.techandme.se/install-rutorrent-plex-on-a-headless-ubuntu-server-16-04-
part-1/

## PLEX Overview

Amazon Cloud Drive is mounted on a Linode server running Ubuntu with Plex running on it. The mounted drive has an encrypted folder that is decrypted by a ENCFS mount, which provides a view into the unencrypted files (effectively unencrypting the files in realtime as they are read - so nothing unecrypted is actually stored on any server).
ACD_CLI sync is applied every hour via a cron job (crontab -u plex -e --> updateAmazon.sh). This should allow new files to automatically be picked up

Primary Folders:
 - /home/plex/amazondrive (amazon cloud drive reference)
 - /home/plex/plex (unecrypted contents from ACD plex directory)

References:
 - https://medium.com/@privatewahts/building-an-infinite-plex-media-server-usingamazon-cloud-drive-for-average-computer-users-d16caab62d14#.nsu75r1ie

## Comments
The encfs configuration is stored in LASTPASS, DONT LOSE THIS (otherwise data cannot be
recovered)
