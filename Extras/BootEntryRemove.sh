#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# List and remove all UEFI boot entries
echo "Removing all UEFI boot entries..."
for entry in $(efibootmgr | grep -oP "Boot\K[0-9A-F]{4}"); do
    echo "Removing Boot$entry..."
    efibootmgr -b "$entry" -B
done

# Verify the result
echo "Remaining UEFI boot entries:"
efibootmgr

