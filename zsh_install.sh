#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit
fi

echo "Installing Zsh and setting up Oh My Zsh..."

# 1. Install Zsh
echo "Installing Zsh..."
pacman -S --noconfirm zsh

# 2. Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 3. Set ZSH_THEME to "bira"
echo "Setting ZSH_THEME to 'bira'..."
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="bira"/' ~/.zshrc

# 4. Add custom aliases to the end of .zshrc
echo "Adding custom aliases to .zshrc..."
cat <<EOF >> ~/.zshrc

# Custom aliases
alias vi="nvim"
alias ff="fastfetch"
alias grubup="sudo grub-mkconfig -o /boot/efi/grub/grub.cfg"
alias pacorp="sudo pacman -Rns \$(pacman -Qdtq)"
EOF

# 5. Change default shell to Zsh
#echo "Changing the default shell to Zsh for the current user..."
#chsh -s $(which zsh)
source ~/.zshrc

echo "Zsh setup complete! Please restart your terminal or log out and log back in to start using Zsh."

