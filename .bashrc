#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Disable XON/XOFF flow control. (C-s/C-q)
stty -ixon
shopt -s autocd

# History things.
HISTTIMEFORMAT="%b %d %H:%M " # using strftime format.
HISTCONTROL=ignoreboth

# Add aliases after exports.
source "$XDG_CONFIG_HOME/bash/bash_aliases"

# Create a new directory and enter it.
function mcd() { mkdir -pv "$@" && cd "$@"; }
