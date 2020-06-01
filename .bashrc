#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# In Bash, the <Esc> character can be obtained with the following syntaxes:
#  \e
#  \033
#  \x1B
# Bold and birght: \e[1m
CAYAN="\[\e[1;36m\]"
LIGHT_CAYAN="\[\e[1;96m\]"
RED="\[\e[1;31m\]"
LIGHT_RED="\[\e[1;91m\]"
RESET="\[\e[0m\]"
PS1="${CAYAN}\W/${RED}\$${RESET} "

# Disable XON/XOFF flow control. (C-s/C-q)
stty -ixon
shopt -s "autocd"
shopt -u "checkwinsize"

# History things.
HISTTIMEFORMAT="%b %d %H:%M " # using strftime format.
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=1000

# Source aliases from external file.
[[ -f "$XDG_CONFIG_HOME/bash/bash-aliases" ]] && . "$XDG_CONFIG_HOME/bash/bash-aliases"

# Create a new directory and enter it.
function mcd() { mkdir -pv "$@" && cd "$@"; }

# Search in vim docs.
function vdoc() { grep "$@" /usr/share/vim/vim82/doc/usr_*; }
