#!/bin/bash

acd_cli mount /home/plex/amazondrive 
ENCFS6_CONFIG='/home/plex/encfs.xml' encfs /home/plex/amazondrive/encrypted /home/plex/plex
