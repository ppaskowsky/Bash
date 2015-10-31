# This script created an automated seedbox on an openwrt router.
# It requires a flash drive with one large ext4 partion for storage.

#Install Packages

opkg update
opkg install transmission-web htop mtr nmap luci-app-vnstat e2fsprogs cfdisk kmod-fs-ext4 kmod-usb-storage block-mount

#Create FileSystem and Automount it on boot

mkfs.ext4 -F /dev/sda1
wget https://gist.githubusercontent.com/ppaskowsky/14edea5ac0f887bcad61/raw/510469b7d747f67337bbedf7dc2963dbd62dcd05/fstab -O /etc/config/fstab
/etc/init.d/fstab enable
mount /dev/sda1 /mnt

#Create folders for transmission

mkdir /mnt/downloads
mkdir /mnt/watch

#Automatically load transmission on boot

/etc/init.d/transmission enable
/etc/init.d/transmission start




