#
# ~/.bash_profile
#

#
# Some configurations.
#
# Default text editor.
export EDITOR='/usr/bin/vim'
# Which editor bash gonna use when pressing ^X-^E (or v in vi-normal-mode).
export VISUAL='/usr/bin/vim'

# less options.
export LESS='--RAW-CONTROL-CHARS --hilite-search --jump-target=5'

#
# Movements. Clean up $HOME.
#
# Terminfo.
export TERMINFO="${HOME}/.local/share/terminfo"
export TERMINFO_DIRS="${HOME}/.local/share/terminfo:/usr/share/terminfo"

# Xauthority to data dir.
xd="${HOME}/.local/share/xorg"
/usr/bin/mkdir --parents --mode=0700 "${xd}" && export XAUTHORITY="${xd}/Xauthority"

# Less command and search history file to state dir.
ld="${HOME}/.local/state/less"
/usr/bin/mkdir --parents --mode=0700 "${ld}" && export LESSHISTFILE="${ld}/lesshst"

# Bash command history file to state dir.
bd="${HOME}/.local/state/bash"
/usr/bin/mkdir --parents --mode=0700 "${bd}" && export HISTFILE="${bd}/bash_history"

# GNU indent profile to config dir.
export INDENT_PROFILE="${HOME}/.config/indent/indent.pro"

# Vim please respect XDGBDS; vimrc to config dir.
export VIMINIT="let \$VIMHOME = '${HOME}/.config/vim' | source \$VIMHOME/vimrc"

# Readline config file to config dir.
export INPUTRC="${HOME}/.config/readline/inputrc"

# X xinitrc to config dir.
# Note that these variables are respected by xinit, but not by startx.
# Instead, specify the filename as an argument:
  # startx "${HOME}/.config/X11/xinitrc" -- "${HOME}/.config/X11/xserverrc" vt1
export XINITRC="${HOME}/.config/X11/xinitrc"
#export XSERVERRC="${HOME}/.config/X11/xserverrc"

#
# Sourcing and other stuff.
#
# Source .bashrc file.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# It's set by the pam_systemd PAM module, and is only set on machines which are using systemd,
# which means that you should not rely on it in your scripts, unless you want to make them depend on systemd.
# On systems which are using systemd, $XDG_VTNR will be set both in graphical (by lightdm, gdm, etc) and
# in text-mode sessions (by /bin/login).
# If you would like to remain logged in when the X session ends, remove exec.
if /usr/bin/systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  startx # startx is an alias, xinitrc is included.
fi

