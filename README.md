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
*/5 * * * * /home/plex/vpc/plex/root_fixmount.sh >> /home/plex/acdlogs.txt

# Upon Reboot

There are a few manual steps upon reboot.  RUTORRENT requires a few tweaks and unencrypting requires a password being entered (which is not programmed into any scripts)

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

 - Setting up a Seedbox using OpenVPN and PIA in Ubuntu 14.04.
 - Had issue around DNS, which was resolved using the first link - had to hard code nameservers in /etc/resolv.conf (removed everything else). Third link has alternative openvpn.zip files. Had to also disable Auto-configure Networking in Linode Setup access to SSH (via second link).
 - Setup ip table and routes, etc...
 - Setup rtorrent (last links). Running rtorrent as a non-root user. Use auto tools to move files upon completion. Subscribe to RSS feed and auto download all files matching /.*/ filter.
 - Completed folder has a reverse encfs directory on top of it. Every 20 minutes a crontab job kicks off. It makes sure everything is copied via rclone copy and then deletes the completed files.

Primary Folders:
 - /home/plex/downloads (in progress downloads)
 - /home/plex/completed (completed files are moved here to be copied to ACD)
 - /home/plex/encrypted (encrypted mount of completed directory: readonly)

References:
 - http://www.htpcguides.com/autoconnect-private-internet-access-vpn-boot-linux/
 - https://forum.linode.com/viewtopic.php?t=8737
 - https://helpdesk.privateinternetaccess.com/hc/en-us/articles/219438247-InstallingOpenVPN-PIA-on-Linux
 - http://linoxide.com/ubuntu-how-to/setup-rtorrent-rutorrent/
 - https://www.techandme.se/install-rutorrent-plex-on-a-headless-ubuntu-server-16-04-part-1/

### SEED SETUP DETAILS
#### Setup User
adduser plex
usermod -aG sudo plex

#### Get Scripts
git clone https://github.com/roarkry/vpc.git
<Move .vimrc to home folder>
<chmod 755 *.sh on seed folder and vpc folder>
Update /vpc/seed/root_route_setup.sh to use correct IP address

#### Setup OPENVPN
sudo apt-get install openvpn
<COPY VPN FILES to /etc/openvpn, SET LOGIN FILE, AND MAKE .SH FILES CHMOD 755>
update /etc/default/openvpn to autostart USE
<APPLY IP FILTER STUFF & SET TO RUN AT REBOOT VIA CRON JOB>

#### Test OpenVPN
sudo reboot -0
if successful, IP address should be different (helper-getIp.sh) and ssh should still work

#### Setup rutorrent (follow this: https://www.techandme.se/install-rutorrent-plex-on-a-headless-ubuntu-server-16-04-part-1/)
 - sudo apt-get install rtorrent -y
 - sudo apt-get install php php7.0-cli php7.0-json php7.0-curl php7.0-cgi php7.0-mbstring libapache2-mod-php libapache2-mod-scgi apache2 -y
 - sudo apt-get install unrar unzip ffmpeg mediainfo -y
 - cd /var/www/html
 - sudo apt-get install git -y && sudo git clone https://github.com/Novik/ruTorrent.git && sudo apt-get purge git -y
 - sudo chown -R plex:www-data ruTorrent/ && sudo chmod -R 770 ruTorrent/
 - sudo apt-get install screen -y
 - setup .rtorrent.rc as plex user in home directory
 - don't setup .rtorrent.session directory and configure in .rc files
 - set download directory to ext3 volume and directory that is created by plex user
 - Setup rclone with acd
 - create symlink (ln -s) to external drive into home directory (for some reason only thing that seems to work for rTorrent being able to access the directory and write to it)


## PLEX Overview

Amazon Cloud Drive is mounted on a Linode server running Ubuntu with Plex running on it. The mounted drive has an encrypted folder that is decrypted by a ENCFS mount, which provides a view into the unencrypted files (effectively unencrypting the files in realtime as they are read - so nothing unecrypted is actually stored on any server).

ACD_CLI sync is applied every hour via a cron job (crontab -u plex -e --> updateAmazon.sh). This should allow new files to automatically be picked up

PlexPy is also installed to provide metrics on Plex

Primary Folders:
 - /home/plex/amazondrive (amazon cloud drive reference)
 - /home/plex/plex (unecrypted contents from ACD plex directory)
 
### Renaming files should occur from plex machine
 - Example script: rename -n 's/Season (..) Episode (..)/- S$1E$2/g' *

#### Setup plex (follow this: https://medium.com/@privatewahts/building-an-infinite-plex-media-server-usingamazon-cloud-drive-for-average-computer-users-d16caab62d14#.nsu75r1ie)
 - install plex, encfs, acd_cli
 - create plex user
 - configure acd_cli as plex user
 - configure encfs to decrypt as plex user
 - configure plex with ssh tunnel (enter user account, create libraries)
 - install plexpy

## Comments
The encfs configuration is stored in LASTPASS, DONT LOSE THIS (otherwise data cannot be
recovered)
