#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Auto cd directory by typing its name (../{dir}).
shopt -s autocd

# History settings.
# The number of commands Bash'll remember in a session.
HISTSIZE=5000
# The number of commands Bash'll store in history file.
HISTFILESIZE=5000
# 'erasedups': causes all previous lines matching the current line to be removed from the history list before that line is saved.
HISTCONTROL='ignorespace:erasedups'

# Prompt colorizing.
FG_RED="\[$(tput setaf 1)\]"
FG_CYAN="\[$(tput setaf 6)\]"
CA_BOLD="\[$(tput bold)\]"
CA_RESET="\[$(tput sgr0)\]"
# Single machine user, so make it simple.
PS1="${CA_RESET}${CA_BOLD}${FG_CYAN}\W/${FG_RED}\$${CA_RESET} "

# Source alias file.
[[ -f "${XDG_CONFIG_HOME}/bash/aliases.bash" ]] && . "${XDG_CONFIG_HOME}/bash/aliases.bash"

# Create new directory and enter the first created one.
function mkcd() { mkdir -p "$@" && cd "$1"; }

# Add some colors and hard-set pager width.
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

  # Use cyan color instead of underline (italic -> underline is included).
  # Manpage's pager resizing (with tiling WM) is a headache. Here is a simple stupid solution.
  LESS_TERMCAP_us="$(tput setaf 6)" \
    LESS_TERMCAP_ue="$(tput sgr0)" \
    MANWIDTH=70 \
    /usr/bin/man "$@"
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
