[[ -f $XDG_CONFIG_HOME/X11/xresources ]] && xrdb -load $XDG_CONFIG_HOME/X11/xresources
[[ -f $XDG_CONFIG_HOME/X11/xmodmap/xmodmaprc ]] && xmodmap $XDG_CONFIG_HOME/X11/xmodmap/xmodmaprc
exec i3
