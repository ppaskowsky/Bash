#/bin/bash

#
# Author: Peter Paskowsky
#
# This script automatically downloads .torrent files for Linux distributions
# Paired with a torrent client this creates an automated Linux iso seed box.
#
# To add this as a cronjob, run crontab -e and add something like the line below
# 
# 0 3 * * * /root/auto-linux-downloader.sh
#

#torrent client's watch directory
#torrent_location=/home/petes/public_html/
#torrent_location=/home/peter/public_html/
torrent_location=/root/test/

#Delete old torrents betfore starting
rm $torrent_location/*


################# FTP ##################


#Arch Netinst Dual
arch=ftp://mirror.rackspace.com/archlinux/iso/
release=`curl -l $arch | sort -n -r | awk NR==1`
wget $arch/$release/*dual.iso.torrent -P $torrent_location/


#Ubuntu 
ubuntu=ftp://releases.ubuntu.com/releases/
release=`curl -l $ubuntu | sort -n -r | awk NR==1`
wget -r -nH --cut-dirs=3 --no-parent -A "*.torrent" $ubuntu/$release/ -P $torrent_location/


#Debian DVD amd64 
debian=ftp://cdimage.debian.org/cdimage/release/current/amd64/bt-dvd/
wget -r -nH --cut-dirs=5 --no-parent -A "*.torrent" -R  "*update*" $debian/ -P $torrent_location/


#Debian CD amd64 
debian=ftp://cdimage.debian.org/cdimage/release/current/amd64/bt-cd/
wget -r -nH --cut-dirs=5 --no-parent -A "*netinst*" -R  "*update*" $debian/ -P $torrent_location/


#Debian DVD i386
debian=ftp://cdimage.debian.org/cdimage/release/current/i386/bt-dvd/
wget -r -nH --cut-dirs=5 --no-parent -A "*.torrent" -R  "*update*" $debian/ -P $torrent_location/


#Debian CD i386
debian=ftp://cdimage.debian.org/cdimage/release/current/i386/bt-cd/
wget -r -nH --cut-dirs=5 --no-parent -A "*netinst*" -R  "*update*" $debian/ -P $torrent_location/


#OpenSUSE  
suse=ftp://www.gtlib.gatech.edu/pub/opensuse/distribution/openSUSE-stable/iso/
wget -r -nH --cut-dirs=5 --no-parent -A "*DVD*.torrent" $suse/ -P $torrent_location/


#Centos 
centos=ftp://mirror.rackspace.com/CentOS/
release=`curl -l $centos | sort -n -r | awk NR==1`
wget -r -nH --cut-dirs=5 --no-parent -A "*DVD*.torrent" $centos/$release/isos/x86_64/ -P $torrent_location/


################# HTTP ##################


#Raspian
wget http://downloads.raspberrypi.org/raspbian_latest.torrent -O $torrent_location/raspbian_latest.torrent


#Fedora 
wget -r -nH --cut-dirs=2 --no-parent -A "*Workstation*" -R  "*Alpha*" http://torrent.fedoraproject.org/torrents/ -P $torrent_location/
wget -r -nH --cut-dirs=2 --no-parent -A "*Server*"  -R  "*Alpha*" http://torrent.fedoraproject.org/torrents/ -P $torrent_location/


#Kali
wget -r -nH --cut-dirs=6 --no-parent -A "*.torrent" http://ftp.cc.uoc.gr/mirrors/linux/kali/kali-images/kali-latest/amd64/ -P $torrent_location/


#Slackware 
wget -r -nH --cut-dirs=2 --no-parent -A "*dvd*"  -R  "*source*" http://www.slackware.com/torrents/ -P $torrent_location/


#cleanup
rm $torrent_location/robots.txt

