# Faster navigation.
alias ..='cd ..'
alias ...='cd ../..'
# With most commands, you can pass -- as an argument,
# and all subsequent arguments are treated as operands and not options even if they begin with a dash.
alias -- --='cd ${OLDPWD}'
alias d="cd $(/usr/bin/xdg-user-dir DOCUMENTS)/"
alias l="cd $(/usr/bin/xdg-user-dir DOWNLOAD)/"
alias p="cd $(/usr/bin/xdg-user-dir PICTURES)/"
xdg_prj_dir="$(/usr/bin/xdg-user-dir PROJECTS)"
alias j="cd ${xdg_prj_dir}/"
alias jc="cd ${xdg_prj_dir}/c/"
alias jn="cd ${xdg_prj_dir}/notes/"
alias jv="cd ${xdg_prj_dir}/vim/"
alias v="cd $(/usr/bin/xdg-user-dir VIDEOS)/"

# Quick open some config files.
# Bashes.
alias vb='/usr/bin/vim ~/.bashrc'
alias vp='/usr/bin/vim ~/.bash_profile'
alias va='/usr/bin/vim ${HOME}/.config/bash/aliases.bash'
# Readline's inputrc.
alias vr='/usr/bin/vim ${INPUTRC}'
# Dynamic window manager.
alias vd='/usr/bin/vim ${HOME}/.config/dwm-git/config.h'
# Suckless terminal.
alias vs='/usr/bin/vim ${HOME}/.config/st-git/config.h'
# Vims.
alias vv='/usr/bin/vim ${HOME}/.config/vim/vimrc'
alias vc='/usr/bin/vim ${HOME}/.config/vim/ftplugin/c.vim'
# xinitrc.
alias vx='/usr/bin/vim ${XINITRC}'
# Zathura.
alias vz='/usr/bin/vim ${HOME}/.config/zathura/zathurarc'
# Makefie template.
alias vm='/usr/bin/vim ${HOME}/.config/vim/tmplts/Makefile'
# Makefile: quickly invoke run target with args.
alias r='/usr/bin/make run --'
# Take note.
alias vn="/usr/bin/vim ${xdg_prj_dir}/notes/index.md"


# Adding colors.
alias ls='/usr/bin/ls --color=auto'
alias la='ls --all'
alias ll='ls -l --all --human-readable'
alias grep='/usr/bin/grep --color=auto'
alias ip='/usr/bin/ip -color=auto'
alias diff='/usr/bin/diff --color=auto'

# [U]mount external drives/USBs.
# alias m16='/usr/bin/doas /usr/bin/mount /mnt/16g-usb && cd /mnt/16g-usb'
# alias um16='/usr/bin/doas /usr/bin/umount /mnt/16g-usb'

# System stuff.
alias dpm='/usr/bin/doas /usr/bin/pacman'
alias spo='/usr/bin/systemctl poweroff -i'

# Bare git dotfiles aliases.
alias config='/usr/bin/git --work-tree=${HOME} --git-dir=${HOME}/.config/dotfiles/'
alias cfa='config add'
alias cfap='config add --patch'
alias cfc='config c'
alias cfd='config diff'
alias cfdi='config diff --staged'
alias cfdt='config difftool'
alias cfl='config log'
alias cfp='config push'
alias cfr='config restore'
alias cfri='config restore --staged'
alias cfs='config status'

# For the sake of videos and movies.
# Do not print copyright, build options and versions; set seek_interval to 3, start in fullscreen mode.
alias ffplay='/usr/bin/ffplay -hide_banner -nostats -seek_interval 3 -autoexit -fs'
# Seeking for file infomation.
alias ffprobe='/usr/bin/ffprobe -hide_banner'

# Start X with "~/.config/xorg/xinitrc"
alias startx="/usr/bin/startx '${XINITRC}'"

# Display all locations containing an executable named includes aliases, builtins, and functions.
alias type='type -a'

# Shorthand for transmission-remote command.
alias tmr='transmission-remote'

# Unset local variables.
unset xdg_prj_dir

# Notes {{{1
# Aliases are created and listed with the alias command, and removed with the unalias command.
# Single quotes vs double quotes:
#    '' are evaluated dynamically.
#    "" are evaluated at time of creation and, thereafter, never changes.
#    alias QS="echo \$PWD" same as ''
# echo $foo is slower than echo "$foo"

