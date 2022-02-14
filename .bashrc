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
# 'erasedups': causes all previous lines matching the current line to be removed from the history list before that line is saved.
HISTCONTROL='ignorespace:erasedups'

# Prompt colorizing.
FG_RED="\[$(/usr/bin/tput setaf 1)\]"
FG_CYAN="\[$(/usr/bin/tput setaf 6)\]"
CA_BOLD="\[$(/usr/bin/tput bold)\]"
CA_RESET="\[$(/usr/bin/tput sgr0)\]"
# Single machine user, so make it simple.
PS1="${CA_RESET}${CA_BOLD}${FG_CYAN}\W/${FG_RED}\$${CA_RESET} "

# Source alias file.
af="${HOME}/.config/bash/aliases.bash"
[[ -f "${af}" ]] && . "${af}"

# Create new directory and enter the first created one.
mkcd()
{
	/usr/bin/mkdir --parents "$@" && cd "$1"
}

# Add some colors and hard-set pager width.
man()
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
	if test "$TERM" != 'linux'
	then
		# Manpage's pager resizing (with tiling WM) is a headache. Here is a simple stupid solution.
		# Use cyan color instead of underline (italic -> underline is included).
		MANWIDTH=70 \
			LESS_TERMCAP_us="$(/usr/bin/tput setaf 6)" \
			LESS_TERMCAP_ue="$(/usr/bin/tput sgr0)" \
			/usr/bin/man "$@"
	else
		/usr/bin/man "$@"
	fi
}

# Play all .mkv files with its external subtitle (if exist) in current directory.
# ^z + kill %% to kill this function.
ffps()
{
	/usr/bin/find . -maxdepth 1 -type f -name '*.mkv' -print0 |
		/usr/bin/sort --zero-terminated |
		while read -r -d $'\0' mkv_file
		do
			[[ -f "${mkv_file}.ass" ]] && sf="${mkv_file}.ass"
			[[ -f "${mkv_file}.srt" ]] && sf="${mkv_file}.srt"
			ffplay "$@" ${sf:+-vf subtitles=\'"${sf}"\'} -- "${mkv_file}"
		done
}

# ffplay can not play internal subtitle.
# Use ffpmeg to extract subtitle in all mkv-files.
ffms()
{
	/usr/bin/find . -maxdepth 1 -type f -name '*.mkv' -print0 |
		/usr/bin/sort --zero-terminated |
		while read -r -d $'\0' mkv_file
		do
			/usr/bin/ffmpeg -i "${mkv_file}" "${mkv_file}.srt"
		done
}

