#!/bin/zsh

# 1. Add custom aliases to the end of .zshrc
echo "Adding custom aliases to .zshrc..."
cat <<EOF >> ~/.zshrc

# Custom aliases
alias vi="nvim"
alias ff="fastfetch"
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias pacorp="sudo pacman -Rns $(pacman -Qdtq)"
alias vz="nvim ~/.zshrc && source ~/.zshrc"
alias penv="python3 -m venv myenv"
alias act="source myenv/bin/activate"
alias dct="deactivate"
alias cod="cd ~/Desktop/Coding"
alias codp="cd ~/Desktop/Coding/python"
alias cc="cd .."
alias clr="clear"
# alias =""
EOF

# 2. Change default shell to Zsh
#echo "Changing the default shell to Zsh for the current user..."
#chsh -s $(which zsh)
source ~/.zshrc

echo "Zsh setup complete! Please restart your terminal or log out and log back in to start using Zsh."
