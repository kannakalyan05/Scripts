#!/bin/bash

# List of packages to install
packages=(
  "hyprland"
  "kitty"
  "waybar"
  "swww"
  "swaylock-effects"
  "wofi"
  "wlogout"
  "mako"
  "xdg-desktop-portal-hyprland"
  "swappy"
  "grim"
  "slurp"
  "thunar"
  "polkit-gnome"
  "python-requests"
  "pamixer"
  "pavucontrol"
  "brightnessctl"
  "bluez"
  "bluez-utils"
  "blueman"
  "network-manager-applet"
  "gvfs"
  "thunar-archive-plugin"
  "file-roller"
  "btop"
  "pacman-contrib"
  "starship"
  "ttf-jetbrains-mono-nerd"
  "noto-fonts-emoji"
  "lxappearance"
  "xfce4-settings"
  "sddm-git"
  "qt5-svg"
  "qt5-quickcontrols2"
  "qt5-graphicaleffects"
)

# Install packages using yay
for package in "${packages[@]}"; do
  yay -S --noconfirm "$package"
done

echo "All packages have been installed."

