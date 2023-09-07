#!/bin/bash

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (using sudo)."
    exit 1
fi

# Define the dependencies for ext4 and ntfs
ext4_dependencies=("e2fsprogs")
ntfs_dependencies=("ntfs-3g")

# Function to install dependencies for a given file system
install_dependencies() {
    local fs="$1"
    local deps=()
    case "$fs" in
        "ext4")
            deps=("${ext4_dependencies[@]}")
            ;;
        "ntfs")
            deps=("${ntfs_dependencies[@]}")
            ;;
        *)
            echo "Error: Unsupported file system type: $fs"
            exit 1
            ;;
    esac

    if [ ${#deps[@]} -eq 0 ]; then
        echo "No dependencies found for $fs file system."
    else
        echo "Installing dependencies for $fs file system..."
        pacman -S --noconfirm "${deps[@]}"
    fi
}

# Update the system
echo "Updating system..."
pacman -Syy --noconfirm

# Prompt the user for the disk to format
read -p "Enter the disk to format (e.g., /dev/sdX): " disk

# Check if the disk exists
if [ ! -e "$disk" ]; then
    echo "Error: Disk '$disk' does not exist."
    exit 1
fi

# Prompt the user for the file system type
read -p "Choose the file system type (ext4 or ntfs): " filesystem

# Check if the user chose ext4 or ntfs
if [ "$filesystem" != "ext4" ] && [ "$filesystem" != "ntfs" ]; then
    echo "Error: Invalid file system type. Please choose 'ext4' or 'ntfs'."
    exit 1
fi

# Install dependencies for the chosen file system
install_dependencies "$filesystem"

# Format the disk to the chosen file system without confirmation
if [ "$filesystem" == "ext4" ]; then
    mkfs.ext4 -F "$disk"
    echo "Disk $disk has been formatted to Ext4."
elif [ "$filesystem" == "ntfs" ]; then
    mkfs.ntfs -f "$disk"
    echo "Disk $disk has been formatted to NTFS."
fi

echo "Formatting complete."

