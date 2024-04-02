#!/bin/bash
#
exec /usr/local/bin/launch.sh &

swww query || swww init & 
pypr --config /home/babak/.config/dotfiles/hypr/pyprland.toml &
exec ~/.config/dotfiles/hypr/scripts/suspend.sh &
dunst & 
~/.local/bin/nekoray
1password
# /usr/libexec/polkit-gnome-autentication-agent-1 &
