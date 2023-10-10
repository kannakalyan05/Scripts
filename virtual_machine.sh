#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Install required packages
pacman -Sy
pacman -S virt-manager virt-viewer qemu bridge-utils libguestfs dnsmasq

# Add the current user to the libvirt group
gpasswd -a $USER libvirt

# Enable and start the libvirtd service
systemctl enable dnsmasq
systemctl start dnsmasq

systemctl enable libvirtd.service
systemctl start libvirtd.service

# Check the status of the libvirtd service
systemctl status libvirtd.service
sudo virsh net-start default
