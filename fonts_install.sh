#!/bin/bash

fonts_list=(
  noto-fonts-emoji
  ttf-comic-sans
  sanskrit-fonts
  adobe-source-han-sans-otc-fonts
)

# function that will test for a package and if not found it will attempt to install it
install_software() {
  # First lets see if the package is there
  if yay -Q $1 &>> /dev/null ; then
    echo -e "$1 is already installed."
  else
    # no package found so installing
    echo "Now installing $1 ."
    yay -S $1
  fi
}

clear

### Install all of the above pacakges ####
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the font packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    for SOFTWR in ${fonts_list[@]}; do
        install_software $SOFTWR 
    done
fi

# Refresh the font cache
fc-cache -f -v
