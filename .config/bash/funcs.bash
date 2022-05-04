#!/hint/bash

# Create new directory and enter the first created one.
mkcd()
{
	/usr/bin/mkdir --parents "$@" && cd "$1"
}

# Add some colors and hard-set pager width.
man()
{
	# Everything is in terminfo(5).
	#   Color       #define       Value       RGB
	#   black     COLOR_BLACK       0     0, 0, 0
	#   red       COLOR_RED         1     max,0,0
	#   green     COLOR_GREEN       2     0,max,0
	#   yellow    COLOR_YELLOW      3     max,max,0
	#   blue      COLOR_BLUE        4     0,0,max
	#   magenta   COLOR_MAGENTA     5     max,0,max
	#   cyan      COLOR_CYAN        6     0,max,max
	#   white     COLOR_WHITE       7     max,max,max
	#   FG - BG: red - blue, yellow - cyan.
	# In manpages:
	#   Bold for: headings, command synopses, and code font.
	#   Underline for: proper names, variable names, and type names in
	#   some manpages.
	#   Inverse (or reverse) for the prompt at the bottom.
	if test "$TERM" != 'linux'
	then
		# Manpage's pager resizing (with tiling WM) is a headache. Here
		# is a simple stupid solution.
		# Use cyan color instead of underline (italic -> underline is
		# included), same as manpage in Arch Linux console theme.
		MANWIDTH=70 \
			LESS_TERMCAP_us="$(/usr/bin/tput setaf 6)" \
			LESS_TERMCAP_ue="$(/usr/bin/tput sgr0)" \
			/usr/bin/man "$@"
	else
		/usr/bin/man "$@"
	fi
}

# Play all .mkv files with its external subtitle (if exist) in current
# directory.
# ^z + kill %% to kill this function.
ffps()
{
	/usr/bin/find . -maxdepth 1 -type f -name '*.mkv' -print0 |
		/usr/bin/sort --zero-terminated |
		while read -r -d $'\0' mkv_file
		do
			test -f "${mkv_file}.ass" && local sub_file="${mkv_file}.ass"
			test -f "${mkv_file}.srt" && local sub_file="${mkv_file}.srt"
			# Shell parameter expansion, ${parameter:+word} if parameter
			# is null or unset, nothing is substituted, otherwise the
			# expansion of "word" is substituted.
			ffplay ${sub_file:+-vf subtitles=\'"${sub_file}"\'}\
					"$@" -- "${mkv_file}"
		done
}

# ffplay can not display some internal subtitles. Why?
# Use ffpmeg to extract subtitle in all mkv-files.
ffms()
{
	/usr/bin/find . -maxdepth 1 -type f -name '*.mkv' -print0 |
		/usr/bin/sort --zero-terminated |
		while read -r -d $'\0' mkv_file
		do
			/usr/bin/ffmpeg -i "${mkv_file}" "${mkv_file}.ass"
		done
}

