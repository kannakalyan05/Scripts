#!/bin/bash

# Set your Git user name and email
git config --global user.name "Kanna kalyan"
git config --global user.email "kannakalyan05@gmail.com"

# Generate an SSH key pair
ssh-keygen -t rsa -b 4096 -C "kannakalyan05@gmail.com"

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add your SSH private key to the SSH agent
ssh-add ~/.ssh/id_rsa

# Display your SSH public key
cat ~/.ssh/id_rsa.pub

