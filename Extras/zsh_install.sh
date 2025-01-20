#!/bin/zsh

# 1. Add custom aliases to the end of .zshrc
echo "Adding custom aliases to .zshrc..."
cat <<EOF >> ~/.zshrc

# Custom aliases
alias vi="nvim"
alias ff="fastfetch"
alias grubup="sudo grub-mkconfig -o /boot/efi/grub/grub.cfg"
alias pacorp="sudo pacman -Rns \$(pacman -Qdtq)"
EOF

# 2. Change default shell to Zsh
#echo "Changing the default shell to Zsh for the current user..."
#chsh -s $(which zsh)
source ~/.zshrc

echo "Zsh setup complete! Please restart your terminal or log out and log back in to start using Zsh."