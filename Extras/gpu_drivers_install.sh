#!/bin/bash

# Define the packages for each option
all_open_source=("intel-media-driver" "libva-intel-driver" "libva-mesa-driver" "mesa" "vulkan-intel" "vulkan-radeon" "xf86-video-amdgpu" "xf86-video-ati" "xf86-video-nouveau" "xf86-video-vmware" "xorg-server" "xorg-xinit")
amd_open_source=("libva-mesa-driver" "mesa" "vulkan-radeon" "xf86-video-amdgpu" "xf86-video-ati" "xorg-server" "xorg-xinit")
intel_open_source=("intel-media-driver" "libva-intel-driver" "mesa" "vulkan-intel" "xorg-server" "xorg-xinit")
nvidia_open_kernel=("nvidia-open" "dkms" "nvidia-open-dkms" "xorg-server" "xorg-xinit")
nvidia_open_source=("libva-mesa-driver" "mesa" "xf86-video-nouveau" "xorg-server" "xorg-xinit")
nvidia_proprietary=("nvidia" "nvidia-utils" "nvidia-settings" "xorg-server" "xorg-xinit")
vmware_open_source=("mesa" "xf86-video-vmware" "xorg-server" "xorg-xinit")

# Function to install packages
install_packages() {
  packages=("$@")
  sudo pacman -S --noconfirm "${packages[@]}"
}

# Display the options to the user
echo "Select the type of packages to install:"
echo "1. All open-source driver"
echo "2. AMD open-source"
echo "3. Intel open-source"
echo "4. Nvidia open kernel for latest GPUs"
echo "5. Nvidia open-source"
echo "6. Nvidia Proprietary"
echo "7. Vmware open-source"

# Read the user input
read -p "Enter your choice (1-7): " choice

# Install the selected packages
case $choice in
  1) install_packages "${all_open_source[@]}" ;;
  2) install_packages "${amd_open_source[@]}" ;;
  3) install_packages "${intel_open_source[@]}" ;;
  4) install_packages "${nvidia_open_kernel[@]}" ;;
  5) install_packages "${nvidia_open_source[@]}" ;;
  6) install_packages "${nvidia_proprietary[@]}" ;;
  7) install_packages "${vmware_open_source[@]}" ;;
  *) echo "Invalid choice"; exit 1 ;;
esac

echo "Installation complete."