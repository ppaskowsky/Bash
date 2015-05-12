#/bin/bash

#
# This setup script installs rotorrent and automatically starts downloading linux torrents on a raspberry pi.
# Requires a large (64GB+) SD card.
#

aptitude update &&  aptitude -y install rtorrent screen htop mtr nmap iftop nload iotop vnstat vim &&  aptitude -y upgrade
mkdir /root/downloads
mkdir /root/watch
mkdir /root/session
wget https://gist.githubusercontent.com/ppaskowsky/8e5f472d5e511f30fa46/raw/3046171930d060842833800487b9c0b219dbf7ce/.rtorrent.rc -O /root/.rtorrent.rc
wget https://gist.githubusercontent.com/ppaskowsky/500d63a46d265135ec82/raw/c5da657015aa23b7c28c503d495bac4255eab8e3/minimal-torrents.sh -O /etc/cron.daily/download_script
chmod +x /etc/cron.daily/download_script
/etc/cron.daily/download_script
sed -i -e '$i \su -c "screen -d -m rtorrent"\n' /etc/rc.local
screen rtorrent
