# Create configuration directories
mkdir -p ~/.config/{bspwm,sxhkd}

# Copy bspwm and sxhkd config files
install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/

# Append additional lines to bspwmrc
echo "nitrogen --restore &" >> ~/.config/bspwm/bspwmrc
echo "setxkbmap us &" >> ~/.config/bspwm/bspwmrc
echo "polybar &" >> ~/.config/bspwm/bspwmrc
echo "picom -f &" >> ~/.config/bspwm/bspwmrc

# Enable the LightDM service
sudo systemctl enable lightdm
