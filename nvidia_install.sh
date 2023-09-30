#!/bin/bash

# Check if an Nvidia GPU is present
if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
    ISNVIDIA=true
else
    ISNVIDIA=false
fi

# Define an array of Nvidia-related packages
nvidia_stage=(
    linux-headers
    nvidia-dkms
    nvidia-settings
    libva
    libva-nvidia-driver-git
)

# Function to install software
install_software() {
    if yay -Q $1 &>> /dev/null; then
        echo -e "$COK - $1 is already installed."
    else
        echo -en "$CNT - Now installing $1 ."
        yay -S --noconfirm $1 &>> $INSTLOG &
        show_progress $!
        if yay -Q $1 &>> /dev/null; then
            echo -e "\e[1A\e[K$COK - $1 was installed."
        else
            echo -e "\e[1A\e[K$CER - $1 install had failed, please check the install.log"
            exit
        fi
    fi
}

# Install Nvidia packages if Nvidia GPU is present
if [[ "$ISNVIDIA" == true ]]; then
    echo -e "$CNT - Nvidia GPU support setup stage, this may take a while..."
    for SOFTWR in "${nvidia_stage[@]}"; do
        install_software $SOFTWR
    done

    # Update config
    sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
    sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
    echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf &>> $INSTLOG
fi

