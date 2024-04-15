#!/bin/bash

sudo pacman -Sy
sudo pacman -S archlinux-keyring
sudo pacman -S qemu-desktop virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
yay -S ebtables iptables
sudo pacman -S libguestfs
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo usermod -a -G libvirt,audio,video $(whoami)
sudo systemctl restart libvirtd.service

echo "All steps completed successfully."

