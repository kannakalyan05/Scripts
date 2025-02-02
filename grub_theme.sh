#!/bin/bash

install_grub_theme() {
  read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the Grub theme? (y,n) ' INST
  if [[ $INST == "Y" || $INST == "y" ]]; then
    
    # Ask user for installation directory
    read -rep $'[\e[1;34mINPUT\e[0m] - Enter the installation directory for the Grub theme (Example: /boot/grub or /boot/grub/efi ): ' INSTALL_DIR
    
    # Ensure the directory exists
    sudo mkdir -p "$INSTALL_DIR"
    sudo rm -rf "$INSTALL_DIR/themes/CyberEXS"
    
    # Clone the theme into the specified directory
    sudo git clone https://github.com/kannakalyan05/GrubTheme.git "$INSTALL_DIR/themes/CyberEXS"
    
    # Update GRUB configuration
    echo "GRUB_THEME=\"$INSTALL_DIR/themes/CyberEXS/theme.txt\"" | sudo tee -a /etc/default/grub
    
    reboot_option='menuentry "Reboot" {
        reboot
    }'
    shutdown_option='menuentry "Shut Down" {
        halt
    }'
    
    echo "$reboot_option" | sudo tee -a /etc/grub.d/40_custom
    echo "$shutdown_option" | sudo tee -a /etc/grub.d/40_custom
    
    # Update grub config if it exists
    if [ -f "$INSTALL_DIR/grub.cfg" ]; then
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    else
        echo "grub.cfg not found. Please update it manually."
    fi
  fi
}

# Call the function to install Grub theme
install_grub_theme