#!/bin/bash

# curl -Lks https://git.io/fresh-install | /bin/bash

git clone --bare https://github.com/tbttin/dotfiles.git $HOME/.config/dotfiles
function config {
    /usr/bin/git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME $@
}
CONFIG_BACKUP_DIR=~/.config~
mkdir -p ${CONFIG_BACKUP_DIR}
config checkout
if [ $? = 0 ]; then
    echo "Checked out config."
else
    echo "Backing up pre-existing dotfiles."
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $CONFIG_BACKUP_DIR
fi
config checkout
config config status.showUntrackedFiles no
echo "Create and update regular directories."
mkdir -p ~/{documents,downloads,pictures{/screenshots,},videos}
if [ -x "$(command -v xdg-user-dirs-update)" ]; then
    rmdir --ignore-fail-on-non-empty ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
    xdg-user-dirs-update
fi
echo "Done."
