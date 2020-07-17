# Aliases are created and listed with the alias command, and removed with the unalias command. 

# Adding color.
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ll -a'
alias grep='grep --color=auto'

# Some improving for movements.
alias ..='cd ..'
alias ...='cd ../..'
# With most commands, you can pass -- as an argument,
# and all subsequent arguments are treated as operands and not options even if they begin with a dash.
alias -- --='cd -' 
alias d='cd $(xdg-user-dir DOCUMENTS)'
alias dl='cd $(xdg-user-dir DOWNLOAD)'
alias p='cd $(xdg-user-dir PICTURES)'
alias s='cd $(xdg-user-dir SCRIPTS)'
alias v='cd $(xdg-user-dir VIDEOS)'

# System stuffs.
alias spf='systemctl poweroff -i'
alias supa='sudo pacman'

# Quick edit some config files.
# Readline.
alias vin='vim $INPUTRC'
# Bash files.
alias vb='vim ~/.bashrc'
alias vp='vim ~/.bash_profile'
alias va='vim $XDG_CONFIG_HOME/bash/aliases.bash'
# I3WM.
alias v3='vim $XDG_CONFIG_HOME/i3/config'
# Vim.
alias vv='vim $XDG_CONFIG_HOME/vim/vimrc'
# Xresources.
alias vx='vim $XDG_CONFIG_HOME/X11/xresources'
# Urxvt.
alias vu='vim $XDG_CONFIG_HOME/X11/urxvtrc'
# Zathura.
alias vz='vim $XDG_CONFIG_HOME/zathura/zathurarc'

# For safety.
alias mv='mv -i'
alias cp='cp -i'

# Mount and umount.
alias m16='sudo mount /mnt/16g-usb && cd /mnt/16g-usb'
alias um16='sudo umount /mnt/16g-usb'

# Git bare alias for dotfiles, don't use $XDG_CONFIG_HOME here.
alias config='/usr/bin/git --work-tree=$HOME --git-dir=$HOME/.config/dotfiles/'
alias cfs='config status'
alias cfd='config diff'
alias cfa='config add'
alias cfc='config commit'
alias cfl='config log'
alias cfp='config push'

# Start wpa_supplicant client add cleanup history file.
alias wpacli='wpa_cli && rm -f ~/.wpa_cli_history'
# Reconnect to home wifi via wpa_supplicant.
alias recon='wpa_cli disable_network 0; sleep 5; wpa_cli enable_network 0'

# Decrease seek interval by 5, supress printing copyright, build options and versions.
alias ffplay='ffplay -seek_interval 5 -hide_banner'

# startx with xinitrc in $XDG_CONFIG_HOME.
alias startx='startx $XDG_CONFIG_HOME/X11/xinitrc'