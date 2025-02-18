#!/bin/bash

# Prompt user to start installation
read -p "Do you want to start KVM/QEMU/Virt Manager installation? (y/n): " start_install

if [[ $start_install != "y" ]]; then
    echo "Installation aborted."
    exit 1
fi

echo "Starting KVM/QEMU/Virt Manager installation..."

# Update system and install necessary packages
if ! sudo pacman -Sy; then
    echo "System update failed. Exiting."
    exit 1
fi

if ! sudo pacman -S --needed --noconfirm qemu-desktop virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat iptables-nft libguestfs; then
    echo "Package installation failed. Exiting."
    sudo pacman -Sy iptables-nft
    exit 1
fi

# Enable and start libvirtd service
if ! sudo systemctl enable --now libvirtd.service; then
    echo "Failed to enable/start libvirtd service. Exiting."
    exit 1
fi

# Add user to necessary groups
sudo usermod -a -G kvm,libvirt,audio,video "$(whoami)"
echo "User $(whoami) has been added to the necessary groups. You may need to log out and back in for changes to take effect."

# Ensure log directory exists
sudo mkdir -p /var/log/libvirt

# Edit libvirtd.conf
sudo sed -i '/^#unix_sock_group/s/^#//' /etc/libvirt/libvirtd.conf
sudo sed -i '/^#unix_sock_rw_perms/s/^#//' /etc/libvirt/libvirtd.conf
echo 'log_filters="3:qemu 1:libvirt"' | sudo tee -a /etc/libvirt/libvirtd.conf
echo 'log_outputs="2:file:/var/log/libvirt/libvirtd.log"' | sudo tee -a /etc/libvirt/libvirtd.conf

# Edit qemu.conf
sudo sed -i '/^#user/s/^#//' /etc/libvirt/qemu.conf
sudo sed -i '/^#group/s/^#//' /etc/libvirt/qemu.conf
sudo sed -i "s/user = \"your username\"/user = \"$(whoami)\"/" /etc/libvirt/qemu.conf
sudo sed -i "s/group = \"your username\"/group = \"$(whoami)\"/" /etc/libvirt/qemu.conf

# Restart libvirtd service
if ! sudo systemctl restart libvirtd.service; then
    echo "Failed to restart libvirtd service. Exiting."
    exit 1
fi

# Ensure the default network exists and is not autostarted
if ! sudo virsh net-info default &>/dev/null; then
    sudo virsh net-define /usr/share/libvirt/networks/default.xml
fi
sudo virsh net-autostart --disable default
sudo systemctl disable libvirtd

clear
echo -e "\e[31mKVM/QEMU/Virt Manager installation completed successfully.\e[0m"
echo -e "\e[31mPlease restart your system with 'sudo reboot' to apply changes and activate group memberships.\e[0m"
