# curl -Lks https://git.io/fresh-install | /bin/bash

git clone --bare https://github.com/tbttin/dotfiles.git $HOME/.config/dotfiles
function config {
    /usr/bin/git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME $@
}
CONF_BACKUP=~/.config-backup
mkdir -p ${CONF_BACKUP}
config checkout
if [ $? = 0 ]; then
    echo "Checked out config."
else
    echo "Backing up pre-existing dotfiles."
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $CONF_BACKUP
fi
config checkout
config config status.showUntrackedFiles no
echo -n "Create and update regular directories..."
mkdir -p ~/{documents,downloads,pictures,videos}
if [ -x "$(command -v xdg-user-dirs-update)" ]; then
    rmdir --ignore-fail-on-non-empty ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
    xdg-user-dirs-update
fi
echo "Done."
