#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Prompt colorizing.
FG_RED="\[$(tput setaf 1)\]"
FG_CYAN="\[$(tput setaf 6)\]"
CA_BOLD="\[$(tput bold)\]"
CA_RESET="\[$(tput sgr0)\]"
PS1="${CA_BOLD}${FG_CYAN}\W/${FG_RED}\$${CA_RESET} "

# Disable XON/XOFF flow control (C-s/C-q).
stty -ixon

# Auto cd directory by typing its name.
shopt -s autocd

# History things.
HISTCONTROL="ignorespace:erasedups"
HISTSIZE=2000

# Source alias file.
[[ -f "${XDG_CONFIG_HOME}/bash/aliases.bash" ]] && . "${XDG_CONFIG_HOME}/bash/aliases.bash"

# Create new directory and enter it.
function mkcd() { mkdir -p "$@" && cd "$1"; }

# Play all .mkv files with its external subtitle in current directory.
# ^Z kill %%
function ffps()
{
    find . -maxdepth 1 -type f -name "*.mkv" -print0 | \
        sort -z | \
        while read -d $'\0' file;
        do
            # Detect external subtitle.
            if [ -f "${file}.ass" ]; then
                ${BASH_ALIASES[ffplay]} "$@" -vf subtitles="${file}.ass" "${file}"
            elif [ -f "${file}.srt" ]; then
                ${BASH_ALIASES[ffplay]} "$@" -vf subtitles="${file}.srt" "${file}"
            else
                ${BASH_ALIASES[ffplay]} "$@" "${file}"
            fi
        done
}
