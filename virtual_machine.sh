#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

pacman -Sy
pacman -S virt-manager qemu dnsmasq

systemctl enable dnsmasq
systemctl start dnsmasq

systemctl enable libvirtd.service
systemctl start libvirtd.service

sudo virsh net-autostart default
sudo virsh net-start default
