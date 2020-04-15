#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Disable XON/XOFF flow control. (C-s/C-q)
stty -ixon

# History things
HISTTIMEFORMAT="%b %d %H:%M " #using strftime format
HISTCONTROL=ignoreboth
#HISTCONTROL=ignoredups:erasedups
#shopt -s histappend
#PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
#HISTIGNORE="history:ls:exit:clear"

# aliases after exports
source "$XDG_CONFIG_HOME/bash_aliases"

# Create a new directory and enter it
function mcd() { mkdir -pv "$@" && cd "$@"; }
