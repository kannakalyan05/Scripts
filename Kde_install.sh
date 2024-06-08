#!/bin/bash

# Define the specific KDE packages to install
kde_packages=("ark" "dolphin" "egl-wayland" "konsole" "plasma-meta" "plasma-workspace" "xdg-utils")

# Install the packages
sudo pacman -S --noconfirm "${kde_packages[@]}"

clear

echo "Installation complete."
