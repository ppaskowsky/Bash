
#/bin/bash

#
# This setup script installs rotorrent and automatically starts downloading linux torrents on a raspberry pi.
# Requires a large (64GB+) SD card.
#

aptitude update &&  aptitude -y install rtorrent screen htop mtr nmap iftop nload iotop vnstat vim &&  aptitude -y upgrade
mkdir /root/downloads
mkdir /root/watch
mkdir /root/session
wget https://gist.githubusercontent.com/ppaskowsky/8e5f472d5e511f30fa46/raw/40bfa3632d6d2667ca2241ad1ea3ff0ca6eae052/.rtorrent.rc -O /root/.rtorrent.rc
wget https://raw.githubusercontent.com/ppaskowsky/Bash/master/auto-linux-downloader-minimal.sh > /etc/cron.daily/download_script
chmod +x /etc/cron.daily/download_script
/etc/cron.daily/download_script
sed -i -e '$i \su -c "screen -d -m rtorrent"\n' /etc/rc.local
screen rtorrent
