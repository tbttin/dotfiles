xrdb -load ~/.config/X11/xresources
[[ -f $XDG_CONFIG_HOME/xmodmap/xmodmaprc ]] && xmodmap $XDG_CONFIG_HOME/xmodmap/xmodmaprc
exec i3
