#!/bin/bash

all_apps=(
  gimp
  gwenview
  firefox
  neovim
  unzip
  mpv
  tor-browser-bin
  visual-studio-code-bin
)

fonts_list=(
  ttf-firacode-nerd
  noto-fonts-cjk
  ttf-ms-fonts
  noto-fonts-emoji
)

# Function to install software
install_software() {
  # First, check if the package is already installed
  if yay -Q $1 &>> /dev/null ; then
    echo -e "$1 is already installed."
  else
    # Package not found, so install it
    echo "Now installing $1 ."
    yay -S $1 --needed
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