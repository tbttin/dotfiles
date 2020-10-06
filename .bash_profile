#
# ~/.bash_profile
#

# XDG base directories.
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"
# XDG_RUNTIME_DIR is set by default through pam_systemd

# Add ~/scripts to $PATH.
export PATH="$PATH:$HOME/scripts"

# Set default editor.
export VISUAL="vim"
export EDITOR="$VISUAL"

# Enable color in less, source: Arch Wiki.
export LESS="-R"
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Move less history seach file to $XDG_DATA_HOME.
[[ ! -d "$XDG_DATA_HOME/less/" ]] && mkdir -p -m 0700 "$XDG_DATA_HOME/less/"
export LESSHISTFILE="$XDG_DATA_HOME/less/history"
#export LESSHISTFILE=- # can be used to disable this feature.

# GNU indent profile.
export INDENT_PROFILE="$XDG_CONFIG_HOME/indent/indent.pro"

# Make vim respect XDG specifications.
export VIMINIT='let $VIMDOTDIR = $XDG_CONFIG_HOME . "/vim" | let $MYVIMRC = $VIMDOTDIR . "/vimrc" | source $MYVIMRC'

# Readline config file.
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

# Bash history.
[[ ! -d "$XDG_DATA_HOME/bash/" ]] && mkdir -p -m 0700 "$XDG_DATA_HOME/bash/"
export HISTFILE="$XDG_DATA_HOME/bash/history"

# What if xorg start up for the first time? Can i touch it?
export XAUTHORITY="$XDG_DATA_HOME/xorg/Xauthority"

# Note that these variables are respected by xinit, but not by startx.
# Instead, specify the filename as an argument:
#startx "$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
#export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc

# Source .bashrc file.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# It's set by the pam_systemd PAM module, and is only set on machines which are using systemd, which means that you should not rely on it in your scripts,
# unless you want to make them depend on systemd.
# On systems which are using systemd, $XDG_VTNR will be set both in graphical (by lightdm, gdm, etc) and in text-mode sessions (by /bin/login).
# If you would like to remain logged in when the X session ends, remove exec.
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	startx # startx is an alias, xinitrc is included.
fi
