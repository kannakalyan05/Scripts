#!/bin/bash

# List of packages to install
packages=(
    bspwm
    xorg
    lightdm
    lightdm-gtk-greeter
    lightdm-gtk-greeter-settings
    sxhkd
    polybar
    picom
    ttf-indic-otf
    ttf-jetbrains-mono-nerd
    htop
    dmenu
    pcmanfm
)

# Install the packages using pacman
sudo pacman -S "${packages[@]}"
su kalyan
# Create configuration directories
mkdir -p ~/.config/{bspwm,sxhkd}

# Copy bspwm and sxhkd config files
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/

# Append additional lines to bspwmrc
echo "nitrogen --restore &" >> ~/.config/bspwm/bspwmrc
echo "setxkbmap us &" >> ~/.config/bspwm/bspwmrc
echo "polybar &" >> ~/.config/bspwm/bspwmrc
echo "picom -f &" >> ~/.config/bspwm/bspwmrc

# Enable the LightDM service
sudo systemctl enable lightdm
