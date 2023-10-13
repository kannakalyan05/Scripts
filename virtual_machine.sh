#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

pacman -Sy
pacman -S virt-manager virt-viewer qemu bridge-utils libguestfs dnsmasq
gpasswd -a $USER libvirt
systemctl enable dnsmasq
systemctl start dnsmasq
systemctl enable libvirtd.service
systemctl start libvirtd.service
systemctl status libvirtd.service
sudo virsh net-start default
