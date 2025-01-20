#!/bin/bash

# Function to install Grub theme
install_grub_theme() {
  # Ask the user if they want to install the Grub theme
  read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the Grub theme? (y,n) ' INST
  if [[ $INST == "Y" || $INST == "y" ]]; then
    sudo rm -rf /boot/grub/themes/starfield
    sudo mkdir /boot/grub/themes/CyberEXS
    sudo git clone https://github.com/HenriqueLopes42/themeGrub.CyberEXS.git /boot/grub/themes/CyberEXS
    echo 'GRUB_THEME="/boot/grub/themes/CyberEXS/theme.txt"' | sudo tee -a /etc/default/grub
    reboot_option='menuentry "Reboot" {
        reboot
    }'
    shutdown_option='menuentry "Shut Down" {
        halt
    }'
    echo "$reboot_option" | sudo tee -a /etc/grub.d/40_custom
    echo "$shutdown_option" | sudo tee -a /etc/grub.d/40_custom
    if [ -f /boot/grub/grub.cfg ]; then
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    else
        echo "grub.cfg not found. Please update it manually."
    fi
  fi
}


# Call the function to install Grub theme
install_grub_theme
