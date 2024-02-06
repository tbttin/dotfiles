#!/bin/bash

man()
{
  # Add some colors and hard-set pager's width.
  # See terminfo(5).
  #    Color      #define       Value       RGB
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
    # Manpage's pager resizing (with tiling WM) is a headache. Here is a
    # simple stupid solution.
    # Use cyan color instead of underline (italic converted to underline is
    # included).
    # See grotty(1)
    MANWIDTH=71 \
      GROFF_NO_SGR=1 \
      LESS_TERMCAP_us="$(/usr/bin/tput setaf 6)" \
      LESS_TERMCAP_ue="$(/usr/bin/tput sgr0)" \
      /usr/bin/man "$@"
  else
    /usr/bin/man "$@"
  fi
}

ffps()
{
  # Play all mkv-files [with its external subtitle] in alphabetical order.
  # [^z] + kill %% 2>/dev/null to kill this function.
  # See bash(1)/^JOB CONTROL. See also bash(1)/^   Special Parameters.
  /usr/bin/find -maxdepth 1 -type f -name '*.mkv' -print0 |
    /usr/bin/sort -z |
    while read -r -d $'\0' mkv_file
    do
      local sub_file=""
      if test -f "${mkv_file}.srt"; then
        local sub_file="${mkv_file}.srt"
      elif test -f "${mkv_file}.ass"; then
        local sub_file="${mkv_file}.ass"
      fi
      # bash(1)/^Parameter Expansion, if $sub_file is null or unset,
      # nothing is substituted, otherwise the expansion of "word"
      # (between '+' and '}') is substituted.
      /usr/bin/ffplay -v error -seek_interval 5 -autoexit -fs -sn "$@" \
        ${sub_file:+-vf subtitles=\'"${sub_file}"\'} -- "${mkv_file}"
    done
}

ffms()
{
  # ffplay can not display some internal subtitles. Why?
  # Use ffpmeg to extract subtitle in all mkv-files.
  /usr/bin/find -maxdepth 1 -type f -name '*.mkv' -print0 |
    while read -r -d $'\0' mkv_file
    do
      # -y to overwrite existed subtitles.
      /usr/bin/ffmpeg -nostdin -v error "$@" -i "${mkv_file}" -- "${mkv_file}.ass"
    done
}

# vim: ft=sh
