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
sudo pacman -S "${packages[@]}" && mkdir -p ~/.config/{bspwm,sxhkd} && install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/ && install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/ && echo "nitrogen --restore &" >> ~/.config/bspwm/bspwmrc && echo "setxkbmap us &" >> ~/.config/bspwm/bspwmrc && echo "polybar &" >> ~/.config/bspwm/bspwmrc && echo "picom -f &" >> ~/.config/bspwm/bspwmrc && sudo systemctl enable lightdm
