#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Auto cd directory by typing its name (../<dir-name>).
shopt -s autocd

# doas auto completion
complete -F _command doas

# It's good! Why not?
# stty -ixon

#
# History settings.
#
# The number of commands Bash'll remember in a session.
HISTSIZE=5000
# The number of commands Bash'll store in history file.
HISTFILESIZE=5000
# 'erasedups': causes all previous lines matching the current line to be
# removed from the history list before that line is saved.
HISTCONTROL='ignorespace:erasedups'
# Enable time stamp.
HISTTIMEFORMAT='%F %T '

# Prompt config.
FG_R="\[$(/usr/bin/tput setaf 1)\]"
FG_C="\[$(/usr/bin/tput setaf 6)\]"
FG_G="\[$(/usr/bin/tput setaf 2)\]"
CA_BOLD="\[$(/usr/bin/tput bold)\]"
CA_RESET="\[$(/usr/bin/tput sgr0)\]"
# One user/one machine, so make it simple.
PS1="${CA_RESET}${CA_BOLD}${FG_C}\W ${FG_R}\$ ${FG_G}\$([ \j -gt 0 ] && /usr/bin/echo \"[\j] \")${CA_RESET}"

#
# Sourcings
#
bash_dir="${HOME}/.config/bash"
alias_file="${bash_dir}/aliases.bash"
func_file="${bash_dir}/funcs.bash"
test -f "${alias_file}" && source "${alias_file}"
test -f "${func_file}"  && source "${func_file}"

unset FG_R FG_C FG_G CA_BOLD CA_RESET bash_dir alias_file func_file

# vim: ft=sh

