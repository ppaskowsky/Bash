# This script creates an automated seedbox on an openwrt router.
# It requires a flash drive with one large ext4 partion (/dev/sda1) for storage.
# You can use fdisk/cfdisk to create the partition table on the flash drive.

#Install Packages

opkg update
opkg install transmission-web e2fsprogs cfdisk kmod-fs-ext4 kmod-usb-storage block-mount 

#Nice to have, uncomment if you have space

#opkg install nmap luci-app-vnstat htop mtr wget

#Create FileSystem and Automount it on boot

mkfs.ext4 -F /dev/sda1
mount /dev/sda1 /mnt

cat <<EOT >> /etc/config/fstab
config 'mount'
        option 'device' '/dev/sda1'
        option 'options' 'rw,sync'
        option 'enabled_fsck' '0'
        option 'enabled' '1'
        option 'target' '/mnt'
EOT

/etc/init.d/fstab enable

#Create folders for transmission

mkdir /mnt/downloads
mkdir /mnt/watch

#Load Transmisson Config File

rm -rf /etc/config/transmission

cat <<EOT >> /etc/config/transmission
config transmission
        option enabled 1
        option config_dir '/mnt/transmission'
        #option user 'nobody'
        option alt_speed_down 0
        option alt_speed_enabled false
        option alt_speed_time_begin  540
        option alt_speed_time_day 127
        option alt_speed_time_enabled false
        option alt_speed_time_end 1020
        option alt_speed_up 0
        option bind_address_ipv4 '0.0.0.0'
        option bind_address_ipv6 '::'
        option blocklist_enabled false
        option blocklist_url ''
        option cache_size_mb 2
        option dht_enabled true
        option download_dir '/mnt/downloads/'
        option download_queue_enabled true
        option download_queue_size 2
        option encryption 1
        option idle_seeding_limit 0
        option idle_seeding_limit_enabled false
        option incomplete_dir '/mnt/incomplete'
        option incomplete_dir_enabled false
        option lazy_bitfield_enabled true
        option lpd_enabled false
        option message_level 1
        option peer_congestion_algorithm ''
        option peer_limit_global 240
        option peer_limit_per_torrent 60
        option peer_port 33333
        option peer_port_random_high 65535
        option peer_port_random_low 50000
        option peer_port_random_on_start false
        option peer_socket_tos 'default'
        option pex_enabled true
        option port_forwarding_enabled true
        option preallocation 1
        option prefetch_enabled true
        option queue_stalled_enabled true
        option queue_stalled_minutes 30
        option ratio_limit 2.0000
        option ratio_limit_enabled false
        option rename_partial_files true
        option rpc_authentication_required false
        option rpc_bind_address '0.0.0.0'
        option rpc_enabled true
        option rpc_password ''
        option rpc_port 9091
        option rpc_url '/transmission/'
        option rpc_username ''
        option rpc_whitelist '127.0.0.1,192.168.1.*'
        option rpc_whitelist_enabled true
        option scrape_paused_torrents_enabled true
        option script_torrent_done_enabled false
        option script_torrent_done_filename ''
        option seed_queue_enabled false
        option seed_queue_size 10
        option speed_limit_down 0
        option speed_limit_down_enabled false
        option speed_limit_up 500
        option speed_limit_up_enabled false
        option start_added_torrents true
        option trash_original_torrent_files false
        option umask 18
        option upload_slots_per_torrent 20
        option utp_enabled true
        option scrape_paused_torrents true
        option watch_dir_enabled true
        option watch_dir '/mnt/watch'
EOT

#Automatically load transmission on boot

/etc/init.d/transmission enable
/etc/init.d/transmission start

