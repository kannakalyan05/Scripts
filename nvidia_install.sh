#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit
fi

echo "Starting NVIDIA driver setup..."

# 1. Install NVIDIA packages
echo "Installing NVIDIA packages..."
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

# 2. Blacklist Nouveau driver
echo "Blacklisting Nouveau driver..."
cat <<EOF > /etc/modprobe.d/blacklist-nouveau.conf
blacklist nouveau
options nouveau modeset=0
EOF

# Regenerate initramfs after blacklisting Nouveau
echo "Regenerating initramfs..."
mkinitcpio -P

# 3. Configure Xorg to use NVIDIA driver
echo "Configuring Xorg for NVIDIA..."
mkdir -p /etc/X11/xorg.conf.d/
cat <<EOF > /etc/X11/xorg.conf.d/20-nvidia.conf
Section "Device"
    Identifier "NVIDIA Card"
    Driver "nvidia"
    Option "NoLogo" "true"
EndSection
EOF

# 4. Enable DRM Kernel Mode Setting in GRUB
echo "Enabling DRM Kernel Mode Setting..."
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 /' /etc/default/grub

# Update GRUB configuration
echo "Updating GRUB configuration..."
grub-mkconfig -o /boot/grub/grub.cfg

# Final message
echo "Setup complete! Please reboot your system."

exit 0

