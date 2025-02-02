#!/bin/bash

# List of packages to be installed
packages=(
    'pipewire'
    'pipewire-alsa'
    'pipewire-jack'
    'pipewire-pulse'
    'gst-plugin-pipewire'
    'libpulse'
    'wireplumber'
)

# Update package database
echo "Updating package database..."
sudo pacman -Sy

# Install the packages
echo "Installing packages..."
for package in "${packages[@]}"; do
    sudo pacman -S $package
done

echo "All packages have been installed successfully."