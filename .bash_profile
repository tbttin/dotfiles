#!/bin/bash

# Some configurations {{{
#
# Default text editor.
export EDITOR='/usr/bin/vim'
# Which editor Bash gonna use when pressing ^X-^E (or v in vi
# normal-mode).
export VISUAL='/usr/bin/vim'

# less options.
export LESS='--RAW-CONTROL-CHARS --hilite-search --jump-target=5'
# End configs }}}

# Files tranfer, clean up $HOME {{{
#
# Mariadb history.
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mariadb_history

# Terminfo.
export TERMINFO="${HOME}/.local/share/terminfo"
export TERMINFO_DIRS="${HOME}/.local/share/terminfo:/usr/share/terminfo"

# Bash command history file to state directory.
export HISTFILE="${HOME}/.local/state/bash_history"

# X authority cookie file to $XDG_RUNTIME_DIR
# $XDG_RUNTIME_DIR is set to "/run/user/$UID" by default through
# pam_systemd.
export XAUTHORITY="${XDG_RUNTIME_DIR:?}/Xauthority"

# Vim please respect XDGBDS; vimrc to config directory.
export VIMINIT="let \$VIMHOME = '${HOME}/.config/vim' | \
                source \$VIMHOME/vimrc"

# Readline config file to config directory.
export INPUTRC="${HOME}/.config/readline/inputrc"

# X xinitrc to config directory.
# Note that these variables are respected by xinit, but not by startx.
# Instead, specify the filename as an argument:
#   startx "${HOME}/.config/X11/xinitrc" -- "${HOME}/.config/X11/xserverrc" vt1
export XINITRC="${HOME}/.config/X11/xinitrc"
#export XSERVERRC="${HOME}/.config/X11/xserverrc"
# End movings }}}

# Sourcing and other stuff. {{{
#
# Source .bashrc file.
test -f "${HOME}/.bashrc" && source "${HOME}/.bashrc"

# It's set by the pam_systemd PAM module, and is only set on machines
# which are using systemd, which means that you should not rely on it in
# your scripts, unless you want to make them depend on systemd.
# On systems which are using systemd, $XDG_VTNR will be set both in
# graphical (by lightdm, gdm, etc) and in text-mode sessions (by
# /bin/login).
# If you would like to remain logged in when the X session ends, remove
# exec.
if /usr/bin/systemctl -q is-active graphical.target &&
  [[ ! "${DISPLAY}" && "${XDG_VTNR}" -eq 1 ]]
then
  exec /usr/bin/startx "${XINITRC:?}"
fi

# vim: ft=sh fdm=marker

