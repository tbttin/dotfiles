#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# In Bash, the <Esc> character can be obtained with the following syntaxes:
#  \e
#  \033
#  \x1B
PS1="\[\033[1;96m\]\W\[\033[1;91m\]$\[\033[0m\] "

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
