# Faster navigation.
alias ..='cd ..'
alias ...='cd ../..'
# With most commands, you can pass -- as an argument,
# and all subsequent arguments are treated as operands and not options even if they begin with a dash.
alias -- --='cd ${OLDPWD}'
alias d="cd $(/usr/bin/xdg-user-dir DOCUMENTS)/"
alias l="cd $(/usr/bin/xdg-user-dir DOWNLOAD)/"
alias p="cd $(/usr/bin/xdg-user-dir PICTURES)/"
xdg_prj_dir=$(/usr/bin/xdg-user-dir PROJECTS)
alias j="cd ${xdg_prj_dir}/"
alias s="cd $(/usr/bin/xdg-user-dir SCRIPTS)/"
alias v="cd $(/usr/bin/xdg-user-dir VIDEOS)/"
alias jc="cd ${xdg_prj_dir}/c/"
alias jv="cd ${xdg_prj_dir}/vim/"

# Quick open some config files.
# Bashes.
alias vb='/usr/bin/vim ~/.bashrc'
alias vp='/usr/bin/vim ~/.bash_profile'
alias va='/usr/bin/vim ${XDG_CONFIG_HOME}/bash/aliases.bash'
# Readline.
alias vn='/usr/bin/vim ${INPUTRC}'
# Dynamic window manager.
alias vd='/usr/bin/vim ${XDG_CONFIG_HOME}/dwm-git/config.h'
# Suckless terminal.
alias vs='/usr/bin/vim ${XDG_CONFIG_HOME}/st-git/config.h'
# Vims.
alias vv='/usr/bin/vim ${XDG_CONFIG_HOME}/vim/vimrc'
alias vc='/usr/bin/vim ${XDG_CONFIG_HOME}/vim/ftplugin/c.vim'
# xinitrc.
alias vx='/usr/bin/vim ${XINITRC}'
# Zathura.
alias vz='/usr/bin/vim ${XDG_CONFIG_HOME}/zathura/zathurarc'
# Makefie template.
alias vm='/usr/bin/vim ${XDG_CONFIG_HOME}/vim/tmplts/Makefile'

# Adding colors.
alias ls='/usr/bin/ls --color=auto'
alias ll='ls -lh'
alias la='ll -a'
alias grep='/usr/bin/grep --color=auto'
alias ip='/usr/bin/ip -color=auto'
alias diff='/usr/bin/diff -color=auto'

# [U]mount external drives/USBs.
alias m16='/usr/bin/doas /usr/bin/mount /mnt/16g-usb && cd /mnt/16g-usb'
alias um16='/usr/bin/doas /usr/bin/umount /mnt/16g-usb'

# System stuffs.
alias dapm='/usr/bin/doas /usr/bin/pacman'
alias spo='/usr/bin/systemctl poweroff -i'

# Bare git dotfiles aliases.
alias config="/usr/bin/git --work-tree=${HOME} --git-dir=${HOME}/.config/dotfiles/"
alias cfs='config status'
alias cfd='config diff'
alias cfdt='config difftool'
alias cfa='config add'
alias cfc='config commit -v'
alias cfl='config log'
alias cfp='config push'

# For the sake of videos and movies.
# Decrease seek_interval by 5, suppress printing copyright, build options and versions.
alias ffplay='/usr/bin/ffplay -hide_banner -nostats -seek_interval 5 -autoexit'
# Seeking for file infomation.
alias ffprobe='/usr/bin/ffprobe -hide_banner'

# Start X with xinitrc in $XDG_CONFIG_HOME.
alias startx='/usr/bin/startx ${XINITRC}'

# Display all locations containing an executable named includes aliases, builtins, and functions.
alias type='type -a'

# Notes {{{1
# Aliases are created and listed with the alias command, and removed with the unalias command.
# Do not overuse alias, we'll lose autocompletion ability.
# Single quotes vs double quotes:
#   '' are evaluated dynamically.
#   "" are evaluated at time of creation and, thereafter, never changes.
#   alias QS="echo \$PWD"

