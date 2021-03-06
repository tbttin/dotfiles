#
# ~/.bash_profile
#

#
# XDG Base Directory Specification.
#
# If nuset assign this value.
export XDG_DATA_HOME="${XDG_DATA_HOME:=${HOME}/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=${HOME}/.config}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:=/usr/local/share:/usr/share}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:=/etc/xdg}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:=${HOME}/.cache}"
# XDG_RUNTIME_DIR is set by default through pam_systemd.

# Default text editor.
export VISUAL='vim'
export EDITOR="$VISUAL"

# Causes raw ASCII color escape sequences are displayed, change search highlight behavior.
export LESS='-R -g'

#
# Clean up $HOME.
#
# Terminfo.
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

# Move less search history file to $XDG_DATA_HOME.
[[ ! -d "${XDG_DATA_HOME}/less" ]] && mkdir -p -m 0700 "${XDG_DATA_HOME}/less"
export LESSHISTFILE="${XDG_DATA_HOME}/less/history"

# Bash history.
[[ ! -d "${XDG_DATA_HOME}/bash" ]] && mkdir -p -m 0700 "${XDG_DATA_HOME}/bash"
export HISTFILE="${XDG_DATA_HOME}/bash/history"

# GNU indent profile.
export INDENT_PROFILE="${XDG_CONFIG_HOME}/indent/indent.pro"

# Make vim respect XDG specifications.
export VIMINIT="let \$VIMHOME = fnameescape(\$XDG_CONFIG_HOME) . '/vim' | source \$VIMHOME/vimrc"

# Readline config file.
export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"

# What if xorg start up for the first time?
export XAUTHORITY="${XDG_DATA_HOME}/xorg/Xauthority"

# Note that these variables are respected by xinit, but not by startx.
# Instead, specify the filename as an argument:
#startx "${XDG_CONFIG_HOME}/X11/xinitrc" -- "${XDG_CONFIG_HOME}/X11/xserverrc" vt1
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
#export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"

# Source .bashrc file.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# It's set by the pam_systemd PAM module, and is only set on machines which are using systemd, which means that you should not rely on it in your scripts,
# unless you want to make them depend on systemd.
# On systems which are using systemd, $XDG_VTNR will be set both in graphical (by lightdm, gdm, etc) and in text-mode sessions (by /bin/login).
# If you would like to remain logged in when the X session ends, remove exec.
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	startx # startx is an alias, xinitrc is included.
fi
