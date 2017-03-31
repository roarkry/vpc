#!/bin/sh
pkill deluged
pkill deluge-web
echo "DOWN @ $(date '+%Y/%m/%d_%H:%M:%S')" >> /etc/openvpn/status.log
