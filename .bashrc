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
PS1="${CAYAN}\W/${RED}\$ ${RESET}"

# Disable XON/XOFF flow control. (C-s/C-q)
stty -ixon

# Auto cd directory by typing its name.
shopt -s "autocd"

# History things.
HISTTIMEFORMAT="%b %d %H:%M " # using strftime format.
HISTCONTROL="ignoreboth:erasedups"
HISTSIZE=1000

# Source alias file.
[[ -f "$XDG_CONFIG_HOME/bash/aliases.bash" ]] && . "$XDG_CONFIG_HOME/bash/aliases.bash"

# Source git auto completion file.
GIT_COMPLETION_SCRIPT="/usr/share/git/completion/git-completion.bash"
[[ -f $GIT_COMPLETION_SCRIPT ]] && . $GIT_COMPLETION_SCRIPT

# Create a new directory and enter it.
function mkcd() { mkdir -p "$@" && cd "$1"; }

# Play all .mkv files with its subtitle in current directory.
# ^Z kill %%
function ffps()
{
    hidden=false
    find . -maxdepth 1 -type f -name "*.mkv" -print0 | \
        sort -z | \
        while read -d $'\0' file;
        do
            # Hide i3 scratchpad window once.
            if [ "$hidden" = false ]; then
                i3-msg [instance="terminal_scratchpad"] move scratchpad &>> /dev/null
                hidden=true
            fi
            # Detect external subtitle.
            if [ -f "${file}.srt" ]; then
                ${BASH_ALIASES[ffplay]} "${file}" -vf subtitles="${file}.srt"
            elif [ -f "${file}.ass" ]; then
                ${BASH_ALIASES[ffplay]} "${file}" -vf subtitles="${file}.ass"
            else
                ${BASH_ALIASES[ffplay]} "${file}"
            fi
        done
}
