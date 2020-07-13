#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# In Bash, the <Esc> character can be obtained with the following syntaxes:
#   \e
#   \033
#   \x1B
# \e[1m: Bold and Bright.
CAYAN="\[\e[1;36m\]"
LIGHT_CAYAN="\[\e[1;96m\]"
RED="\[\e[1;31m\]"
LIGHT_RED="\[\e[1;91m\]"
RESET="\[\e[0m\]"
PS1="${CAYAN}\W/${RED}\$${RESET} "

# Disable XON/XOFF flow control. (C-s/C-q)
stty -ixon
shopt -s "autocd"

# History things.
HISTTIMEFORMAT="%b %d %H:%M " # using strftime format.
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=1000

# Source alias file.
[[ -f "$XDG_CONFIG_HOME/bash/aliases.bash" ]] && . "$XDG_CONFIG_HOME/bash/aliases.bash"

# Create a new directory and enter it.
function mkcd() { mkdir -pv "$@" && cd "$1"; }

# Search in vim docs.
function vdoc() { grep "$1" /usr/share/vim/vim82/doc/usr_*; }

# Play all .mkv file in current directory with subtitle prefix.
function ffps()
{
    if [ -z "$1" ] ; then
	# if no argument just play it.
	find . -maxdepth 1 -type f -name "*.mkv" -print0 | xargs -0 -n 1 -I {} ffplay -hide_banner -seek_interval 5 {}
    else 
	# play with external subtitle.
	find . -maxdepth 1 -type f -name "*.mkv" -print0 | xargs -0 -n 1 -I {} ffplay -hide_banner -seek_interval 5 -vf subtitles={}.$1.srt {}
    fi
}
