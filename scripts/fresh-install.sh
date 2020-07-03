git clone --bare https://github.com/tbttin/dotfiles.git $HOME/.config/dotfiles
function config {
    /usr/bin/git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME $@
}
$CONF_BACKUP=~/.config-backup
mkdir -p ${CONF_BACKUP}
config checkout
if [ $? = 0 ]; then
    echo "Checked out config.";
else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $CONF_BACKUP/{}
fi;
config checkout
config config status.showUntrackedFiles no

echo "Creating regular directories."
mkdir ~/{documents,downloads,pictures,videos} && xdg-user-dirs-update

echo "Done."
#curl -Lks short-url-here | /bin/bash
