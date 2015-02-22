#!/bin/bash

#
# Author: Peter Paskowsky
#
# This script automatically downloads .torrent files for Linux distributions
# Paired with a torrent client this creates an automated Linux iso seed box.
#
# To add this as a cronjob, run crontab -e and add something like the line below
# 0 3 * * * /root/auto-linux-downloader.sh
#

#torrent client's watch directory
torrent_location=/mnt/torrents

#Ubuntu Desktop amd64
file=`curl -l ftp://releases.ubuntu.com/releases/ | sort -n -r | awk NR==1`
file2=`curl -l ftp://releases.ubuntu.com/releases/$file/ |  grep desktop-amd64.iso.torrent`
wget ftp://releases.ubuntu.com/releases/$file/$file2 -O $torrent_location/ubuntu.torrent

#Debian Netinst amd64
file=`curl -l ftp://cdimage.debian.org/cdimage/release/current/amd64/bt-cd/ | grep netinst`
file=ftp://cdimage.debian.org/cdimage/release/current/amd64/bt-cd/$file
wget $file -O $torrent_location/debian.torrent

#Arch Netinst Dual
file=`curl -l ftp://mirror.rackspace.com/archlinux/iso/latest/ | grep torrent` 
file=ftp://mirror.rackspace.com/archlinux/iso/latest/$file
wget $file -O $torrent_location/archlinux.torrent

