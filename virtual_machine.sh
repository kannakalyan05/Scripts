#!/bin/bash

# Prompt user to start installation
read -p "Do you want to start KVM/QEMU/Virt Manager installation? (y/n): " start_install

if [[ $start_install != "y" ]]; then
    echo "Installation aborted."
    exit 1
fi

echo "Starting KVM/QEMU/Virt Manager installation..."

# Update system and install necessary packages
sudo pacman -Sy
sudo pacman -S qemu-desktop virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat iptables-nft libguestfs

# Enable and start libvirtd service
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

# Add user to necessary groups
sudo usermod -a -G kvm,libvirt,audio,video $(whoami)

# Edit libvirtd.conf
sudo sed -i '/^#unix_sock_group/s/^#//' /etc/libvirt/libvirtd.conf
sudo sed -i '/^#unix_sock_rw_perms/s/^#//' /etc/libvirt/libvirtd.conf
echo 'log_filters="3:qemu 1:libvirt"' | sudo tee -a /etc/libvirt/libvirtd.conf
echo 'log_outputs="2:file:/var/log/libvirt/libvirtd.log"' | sudo tee -a /etc/libvirt/libvirtd.conf

# Edit qemu.conf
sudo sed -i '/^#user/s/^#//' /etc/libvirt/qemu.conf
sudo sed -i '/^#group/s/^#//' /etc/libvirt/qemu.conf
sudo sed -i 's/user = "your username"/user = "$(whoami)"/' /etc/libvirt/qemu.conf
sudo sed -i 's/group = "your username"/group = "$(whoami)"/' /etc/libvirt/qemu.conf

# Restart libvirtd service
sudo systemctl restart libvirtd.service

# Autostart default network
sudo virsh net-start default

echo "KVM/QEMU/Virt Manager installation completed successfully."
echo "Please restart your system with 'sudo reboot' to apply changes."
