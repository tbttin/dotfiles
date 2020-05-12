#!/bin/bash

# Corlors.
[[ -f $XDG_CONFIG_HOME/X11/xresources ]] && xrdb -load $XDG_CONFIG_HOME/X11/xresources
# Urxvt settings.
[[ -f $XDG_CONFIG_HOME/X11/urxvtrc ]] && xrdb -merge $XDG_CONFIG_HOME/X11/urxvtrc

# xmodmap
[[ -f $XDG_CONFIG_HOME/X11/xmodmap/xmodmaprc ]] && xmodmap $XDG_CONFIG_HOME/X11/xmodmap/xmodmaprc

exec i3
