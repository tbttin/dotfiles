#!/bin/bash

# Corlors.
[[ -f $XDG_CONFIG_HOME/X11/xresources ]] && xrdb -load $XDG_CONFIG_HOME/X11/xresources
# Urxvt settings.
[[ -f $XDG_CONFIG_HOME/X11/urxvtrc ]] && xrdb -merge $XDG_CONFIG_HOME/X11/urxvtrc

# xmodmap
[[ -f $XDG_CONFIG_HOME/X11/xmodmap/xmodmaprc ]] && xmodmap $XDG_CONFIG_HOME/X11/xmodmap/xmodmaprc

# Swap left and right mouse buttion.
xinput set-button-map $(xinput list --id-only "Logitech Wireless Mouse") 3 2 1

exec i3
