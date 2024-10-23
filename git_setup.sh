#!/bin/bash

# Prompt user for Git user name
read -p "Enter your Git user name: " git_username

# Prompt user for Git email
read -p "Enter your Git email: " git_email

# Set Git user name and email
git config --global user.name "$git_username"
git config --global user.email "$git_email"

# Generate an SSH key pair
ssh-keygen -t rsa -b 4096 -C "$git_email"

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add SSH private key to the SSH agent
ssh-add ~/.ssh/id_rsa

clear

# Display SSH public key
cat ~/.ssh/id_rsa.pub