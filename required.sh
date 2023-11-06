#!/bin/bash

all_apps=(
  code
  telegram-desktop
  libreoffice-fresh
  neovim
  kate
  qbittorrent
  mpv
  eog
)

fonts_list=(
  noto-fonts-emoji
  ttf-ms-fonts
  sanskrit-fonts
  adobe-source-han-serif-otc-fonts
)

# Function to install software
install_software() {
  # First, check if the package is already installed
  if yay -Q $1 &>> /dev/null ; then
    echo -e "$1 is already installed."
  else
    # Package not found, so install it
    echo "Now installing $1 ."
    yay -S $1
  fi
}

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

clear

# Install all apps
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install all apps? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    for SOFTWR in "${all_apps[@]}"; do
        install_software "$SOFTWR"
    done
fi

# Install font packages
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the font packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    for SOFTWR in "${fonts_list[@]}"; do
        install_software "$SOFTWR"
    done
fi

# Refresh the font cache
fc-cache -f -v
cp gitt build /bin/
# Call the function to install Grub theme
install_grub_theme
