#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Linux console colors, framebuffer.
# How to keep original colors?
#if [ "$TERM" = "linux" ]; then
#    echo -en "\e]P0232323" #black
#    echo -en "\e]P82B2B2B" #darkgrey
#    echo -en "\e]P1D75F5F" #darkred
#    echo -en "\e]P9E33636" #red
#    echo -en "\e]P287AF5F" #darkgreen
#    echo -en "\e]PA98E34D" #green
#    echo -en "\e]P3D7AF87" #brown
#    echo -en "\e]PBFFD75F" #yellow
#    echo -en "\e]P48787AF" #darkblue
#    echo -en "\e]PC7373C9" #blue
#    echo -en "\e]P5BD53A5" #darkmagenta
#    echo -en "\e]PDD633B2" #magenta
#    echo -en "\e]P65FAFAF" #darkcyan
#    echo -en "\e]PE44C9C9" #cyan
#    echo -en "\e]P7E5E5E5" #lightgrey
#    echo -en "\e]PFFFFFFF" #white
#    clear #for background artifacting
#fi

# Prompt colorizing.
FG_RED="\[$(tput setaf 1)\]"
FG_GREEN="\[$(tput setaf 2)\]"
FG_YELLOW="\[$(tput setaf 3)\]"
FG_BLUE="\[$(tput setaf 4)\]"
FG_MAGENTA="\[$(tput setaf 5)\]"
FG_CYAN="\[$(tput setaf 6)\]"
CA_BOLD="\[$(tput bold)\]"
CA_RESET="\[$(tput sgr0)\]"
PS1="${CA_BOLD}${FG_CYAN}\W/${FG_RED}\$ ${CA_RESET}"

# Disable XON/XOFF flow control. (C-s/C-q)
stty -ixon

# Auto cd directory by typing its name.
shopt -s "autocd"

# History things.
HISTCONTROL="ignorespace:erasedups"
HISTSIZE=2000

# Source alias file.
[[ -f "$XDG_CONFIG_HOME/bash/aliases.bash" ]] && . "$XDG_CONFIG_HOME/bash/aliases.bash"

## Source git auto completion file.
#GIT_COMPLETION_SCRIPT="/usr/share/git/completion/git-completion.bash"
#[[ -f $GIT_COMPLETION_SCRIPT ]] && . $GIT_COMPLETION_SCRIPT

# Create a new directory and enter it.
function mkcd() { mkdir -p "$@" && cd "$1"; }

# Play all .mkv files with its external subtitle in current directory.
# ^Z kill %%
function ffps()
{
    find . -maxdepth 1 -type f -name "*.mkv" -print0 | \
        sort -z | \
        while read -d $'\0' file;
        do
            echo "Playing ${file}"
            # Get current window id.
            win_id=$(xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2)
            if [ "$win_id" != "0x0" ]; then
                i3-msg [instance="terminal_scratchpad"] move scratchpad &>> /dev/null
            fi
            # Detect external subtitle.
            if [ -f "${file}.srt" ]; then
                ${BASH_ALIASES[ffplay]} "${file}" -vf subtitles="${file}.srt"
            elif [ -f "${file}.ass" ]; then
                ${BASH_ALIASES[ffplay]} "${file}" -vf subtitles="${file}.ass"
            else
                ${BASH_ALIASES[ffplay]} "${file}"
            fi
            echo "$(date '+%F %H-%M-%S') ${file}" >> ffps.log
        done
        win_id=$(xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2)
        if [ "$win_id" = "0x0" ]; then
            i3-msg [instance="terminal_scratchpad"] scratchpad show &>> /dev/null
        fi
}
