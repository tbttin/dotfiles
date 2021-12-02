#
# ~/.bash_profile
#

#
# XDG Base Directory Specification.
#
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
# XDG_RUNTIME_DIR is set to /run/user/$UID by default through pam_systemd.

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
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

# What if first time startx? Is this an error?
xd="${XDG_DATA_HOME}/xorg"
/usr/bin/mkdir --parents --mode=0700 "${xd}" && export XAUTHORITY="${xd}/Xauthority"

# Less command and search history file.
ld="${XDG_STATE_HOME}/less"
/usr/bin/mkdir --parents --mode=0700 "${ld}" && export LESSHISTFILE="${ld}/lesshst"

# Bash command history file.
bd="${XDG_STATE_HOME}/bash"
/usr/bin/mkdir --parents --mode=0700 "${bd}" && export HISTFILE="${bd}/bash_history"

# GNU indent profile.
export INDENT_PROFILE="${XDG_CONFIG_HOME}/indent/indent.pro"

# Make vim respect XDGBDS.
export VIMINIT="let \$VIMHOME = fnameescape(\$XDG_CONFIG_HOME) .. '/vim' | source \$VIMHOME/vimrc"

# Readline config file.
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"

# Note that these variables are respected by xinit, but not by startx.
# Instead, specify the filename as an argument:
  # startx "${XDG_CONFIG_HOME}/X11/xinitrc" -- "${XDG_CONFIG_HOME}/X11/xserverrc" vt1
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
#export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"

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

