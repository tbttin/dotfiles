# Aliases are created and listed with the alias command, and removed with the unalias command.
# Single quotes are evaluated dynamically.
# Double quotes are evaluated at time of creation and, thereafter, never changes.
    #alias QS="echo \$PWD"

# Some improving for movements.
alias ..='cd ..'
alias ...='cd ../..'
# With most commands, you can pass -- as an argument,
# and all subsequent arguments are treated as operands and not options even if they begin with a dash.
alias -- --='cd ${OLDPWD}'
alias d="cd $(xdg-user-dir DOCUMENTS)"
alias l="cd $(xdg-user-dir DOWNLOAD)"
alias p="cd $(xdg-user-dir PICTURES)"
alias s="cd $(xdg-user-dir SCRIPTS)"
alias v="cd $(xdg-user-dir VIDEOS)"

# Quick edit some config files.
# Bash.
alias vb='vim ~/.bashrc'
alias vp='vim ~/.bash_profile'
alias va='vim ${XDG_CONFIG_HOME}/bash/aliases.bash'
# Readline.
alias vn='vim ${INPUTRC}'
# Dynamic window manager.
alias vd='vim ${XDG_CONFIG_HOME}/dwm-git/config.h'
# Suckless terminal.
alias vs='vim ${XDG_CONFIG_HOME}/st-git/config.h'
# Vim.
alias vv='vim ${XDG_CONFIG_HOME}/vim/vimrc'
# xinitrc.
alias vx='vim ${XINITRC}'
# Zathura.
alias vz='vim ${XDG_CONFIG_HOME}/zathura/zathurarc'

# Adding colors.
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ll -a'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias diff='diff -color=auto'

# For safety.
# BECAREFUL WHEN YOU USE ANOTHER SYSTEM.
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# [U]mount external drives/USBs.
alias m16='sudo mount /mnt/16g-usb && cd /mnt/16g-usb'
alias um16='sudo umount /mnt/16g-usb'

# System stuffs.
alias supa='sudo pacman'
alias spo='systemctl poweroff -i'
alias srb='systemctl reboot'

# Dotfiles git bare aliases.
alias config='/usr/bin/git --work-tree=${HOME} --git-dir=${HOME}/.config/dotfiles/'
alias cfs='config status'
alias cfd='config diff'
alias cfdt='config difftool'
alias cfa='config add'
alias cfc='config commit'
alias cfl='config log'
alias cfp='config push'

# Decrease seek_interval by 5, suppress printing copyright, build options and versions.
alias ffplay='ffplay -hide_banner -nostats -seek_interval 5 -autoexit'
alias ffmpeg='ffmpeg -hide_banner'

# startx with xinitrc in $XDG_CONFIG_HOME.
alias startx='startx ${XINITRC}'

alias type='type -a'
