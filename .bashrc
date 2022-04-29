#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Auto cd directory by typing its name (../<dir-name>).
shopt -s autocd

# History settings.
# The number of commands Bash'll remember in a session.
HISTSIZE=5000
# The number of commands Bash'll store in history file.
HISTFILESIZE=5000
# 'erasedups': causes all previous lines matching the current line to be
# removed from the history list before that line is saved.
HISTCONTROL='ignorespace:erasedups'

# Prompt colorizing.
FG_RED="\[$(/usr/bin/tput setaf 1)\]"
FG_CYAN="\[$(/usr/bin/tput setaf 6)\]"
CA_BOLD="\[$(/usr/bin/tput bold)\]"
CA_RESET="\[$(/usr/bin/tput sgr0)\]"
# Single machine user, so make it simple.
PS1="${CA_RESET}${CA_BOLD}${FG_CYAN}\W/${FG_RED}\$${CA_RESET} "

# Source aliases file.
af="${HOME}/.config/bash/aliases.bash"
[[ -f "${af}" ]] && . "${af}"

# Source functions file.
ff="${HOME}/.config/bash/funcs.bash"
[[ -f "${ff}" ]] && . "${ff}"

