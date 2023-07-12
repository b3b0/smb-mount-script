#!/bin/bash

smb_share="//server.local/share"
smb_username=""
smb_password=""
mount_point="/your/mount"

sudo mkdir -p "$mount_point"

if ! dpkg -s cifs-utils >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y cifs-utils
fi

# add to /etc/fstab
echo -e "$smb_share\t$mount_point\tcifs\tcredentials=/etc/smbcredentials.txt,iocharset=utf8,gid=1000,uid=1000,file_mode=0775,dir_mode=0775\t0\t0" | sudo tee -a /etc/fstab >/dev/null

# smbcredentials file
sudo bash -c "echo -e \"username=$smb_username\npassword=$smb_password\" > /etc/smbcredentials.txt"
sudo chmod 600 /etc/smbcredentials.txt
sudo chown root:root /etc/smbcredentials.txt
sudo mount -a
echo "SMB share mounted successfully."
