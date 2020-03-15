# Aliases are created and listed with the alias command, and removed with the unalias command. 

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -alh'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias -- --='cd -' # With most commands, you can pass -- as an argument, and all subsequent arguments are treated as operands and not options  even if they begin with a dash.

alias vb='vim ~/.bashrc'
alias vp='vim ~/.bash_profile'
alias va='vim ~/.bash_aliases'
alias v3='vim $XDG_CONFIG_HOME/i3/config'
alias vv='vim $XDG_CONFIG_HOME/vim/vimrc'
alias vx='vim ~/.Xdefaults'
alias vin="vim $INPUTRC"

#alias pf='systemctl poweroff -i'
alias p='sudo pacman'
alias scrot='scrot ~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png'
alias m16='sudo mount /mnt/16g-usb && cd /mnt/16g-usb'
alias um16='sudo umount /mnt/16g-usb'

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
