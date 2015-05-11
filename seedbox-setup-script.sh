#/bin/bash

#
# This setup script installs rotorrent and automatically starts downloading linux torrents on a debian server.
# It also ensures rtorrent starts at boot, and runs a script daily to download the latest linux torrents.
# 

aptitude update &&  aptitude -y install rtorrent screen htop mtr nmap iftop nload iotop vnstat vim &&  aptitude -y upgrade
mkdir /root/downloads
mkdir /root/watch
mkdir /root/session
wget https://gist.githubusercontent.com/ppaskowsky/8e5f472d5e511f30fa46/raw/3046171930d060842833800487b9c0b219dbf7ce/.rtorrent.rc -O /root/.rtorrent.rc
wget https://gist.githubusercontent.com/ppaskowsky/26769cb72ad0f47f176e/raw/72d92bbd3145cef140fea39060dcb00b0d53591b/torrent_download_script.sh -O /etc/cron.daily/download_script
chmod +x /etc/cron.daily/download_script
/etc/cron.daily/download_script
sed -i -e '$i \su -c "screen -d -m rtorrent"\n' /etc/rc.local
screen rtorrent
