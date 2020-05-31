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
RED="\[\e[1;31m\]"
RESET="\[\e[0m\]"
PS1="$CAYAN\W$RED\$$RESET "

# Disable XON/XOFF flow control. (C-s/C-q)
stty -ixon
shopt -s "autocd"

# History things.
HISTTIMEFORMAT="%b %d %H:%M " # using strftime format.
HISTCONTROL="ignoreboth"

# Source aliases from external file.
[[ -f "$XDG_CONFIG_HOME/bash/bash-aliases" ]] && . "$XDG_CONFIG_HOME/bash/bash-aliases"

# Create a new directory and enter it.
function mcd() { mkdir -pv "$@" && cd "$@"; }
