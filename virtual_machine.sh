#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Install required packages
pacman -Syy
pacman -S virt-manager virt-viewer qemu bridge-utils libguestfs

# Edit the libvirtd.conf file
config_file="/etc/libvirt/libvirtd.conf"
if [ -f "$config_file" ]; then
  # Uncomment the 'unix_sock_group' line and change 'unix_sock_ro_perms' value
  sed -i '/^#unix_sock_group/s/^#//' "$config_file"
  sed -i 's/#unix_sock_ro_perms = "0770"/unix_sock_ro_perms = "0770"/' "$config_file"

  echo "Configuration changes in $config_file applied."
else
  echo "$config_file does not exist."
  exit 1
fi

# Add the current user to the libvirt group
gpasswd -a $USER libvirt

# Enable and start the libvirtd service
systemctl enable libvirtd.service
systemctl start libvirtd.service

# Check the status of the libvirtd service
systemctl status libvirtd.service
sudo virsh net-start default
