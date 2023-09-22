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
    alacritty

)

# Install the packages using pacman
sudo pacman -S "${packages[@]}"
