#
# ~/.bash_profile
#

# XDG BASE DIRECTORIES
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"

# Enable color in less, source: archlinux.
export LESS=-R-+i
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
#export LESSHISTFILE=- # can be used to disable this feature.

# Vim config file.
export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc

# Readline config file.
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Bash history.
export HISTFILE="$XDG_DATA_HOME"/bash/history

# Try moving some stuffs.
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
#export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
#export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
# Note that these variables are respected by xinit, but not by startx. Instead, specify the filename as an argument:
#startx "$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1

[[ -f ~/.bashrc ]] && . ~/.bashrc

# It's set by the pam_systemd PAM module, and is only set on machines which are using systemd, which means that you should not rely on it in your scripts,
# unless you want to make them depend on systemd.
# On systems which are using systemd, $XDG_VTNR will be set both in graphical (by lightdm, gdm, etc) and in text-mode sessions (by /bin/login).
# If you would like to remain logged in when the X session ends, remove exec.
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	startx
fi
