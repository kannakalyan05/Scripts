#!/bin/bash

# List of packages to install
packages=(
    cosmic-app-library
    cosmic-applets
    cosmic-bg
    cosmic-comp
    cosmic-files
    cosmic-greeter
    cosmic-idle
    cosmic-launcher
    cosmic-notifications
    cosmic-osd
    cosmic-panel
    cosmic-randr
    cosmic-screenshot
    cosmic-session
    cosmic-settings
    cosmic-settings-daemon
    cosmic-store
    cosmic-terminal
    cosmic-text-editor
    cosmic-wallpapers
    cosmic-workspaces
    xdg-desktop-portal-cosmic
)

# Update system and install packages
sudo pacman -Syu --needed "${packages[@]}"

