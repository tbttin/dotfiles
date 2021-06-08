#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Disable XON/XOFF flow control (C-s/C-q).
#stty -ixon

# Auto cd directory by typing its name (../{dir}).
shopt -s autocd

# History settings.
# The number of commands to remember in the command history.
HISTSIZE=2000
# 'ignorespace': lines which begin with a space character are not saved in the history list.
# 'erasedups'  : causes all previous lines matching the current line to be removed from the history list before that line is saved.
HISTCONTROL='ignorespace:erasedups'

# Make bash completin ignore all linked or compiled c files (.o, .out), prefer source file (.c) for some text editors.
complete -f -X '*.@([ao]|so|so.!(conf|*/*)|[rs]pm|gif|jp?(e)g|mp3|mp?(e)g|avi|asf|ogg|class|mkv|o|out)' vi vim gvim rvim view rview rgvim rgview gview emacs xemacs sxemacs kate kwrite
# Global solution for every single command (rm, mv).
#FIGNORE='.out:.o'

# Prompt colorizing.
FG_RED="\[$(tput setaf 1)\]"
FG_CYAN="\[$(tput setaf 6)\]"
CA_BOLD="\[$(tput bold)\]"
CA_RESET="\[$(tput sgr0)\]"
# Single machine user, so make it simple.
PS1="${CA_RESET}${CA_BOLD}${FG_CYAN}\W/${FG_RED}\$${CA_RESET} "

# Source alias file.
[[ -f "${XDG_CONFIG_HOME}/bash/aliases.bash" ]] && . "${XDG_CONFIG_HOME}/bash/aliases.bash"

# Create new directorie[s] and enter the first one.
function mkcd() { mkdir -p "$@" && cd "$1"; }

# Trick less command to use color instead of underline escape sequence.
function man ()
{
    # Everything is in terminfo(5).
    # Color       #define       Value       RGB
    # black     COLOR_BLACK       0     0, 0, 0
    # red       COLOR_RED         1     max,0,0
    # green     COLOR_GREEN       2     0,max,0
    # yellow    COLOR_YELLOW      3     max,max,0
    # blue      COLOR_BLUE        4     0,0,max
    # magenta   COLOR_MAGENTA     5     max,0,max
    # cyan      COLOR_CYAN        6     0,max,max
    # white     COLOR_WHITE       7     max,max,max
    # FG - BG: red - blue, yellow - cyan.

    # Bold for headings, command synopses, and code font.
    # Underline for proper names, variable names, and type names in some manpages.
    # Inverse (or reverse) for the prompt at the bottom.

    # The p subsection is for POSIX specifications; the x subsection is for X Window System documentation.

    # Use cyan color instead of underline (italic -> underline is included).
    LESS_TERMCAP_us="$(tput setaf 6)" \
        LESS_TERMCAP_ue="$(tput sgr0)" \
        command man "$@"
}

# Play all .mkv files with its external subtitle (if exist) in current directory.
# ^z + kill %% to kill this function.
function ffps()
{
    find . -maxdepth 1 -type f -name '*.mkv' -print0 | \
        sort -z | \
        while read -rd $'\0' file
        do
            if [ -f "${file}.ass" ]; then
                ${BASH_ALIASES[ffplay]} "$@" -vf "subtitles='${file}.ass'" "${file}"
            elif [ -f "${file}.srt" ]; then
                ${BASH_ALIASES[ffplay]} "$@" -vf "subtitles='${file}.srt'" "${file}"
            else
                ${BASH_ALIASES[ffplay]} "$@" "${file}"
            fi
        done
}
