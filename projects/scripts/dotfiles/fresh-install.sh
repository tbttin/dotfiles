#!/bin/sh

# Download this script from github repo and execute it shell script.
# curl -Ls https://git.io/fresh-install | /bin/sh

function indent {
   sed 's/^/  -> /'
}

function config {
    /usr/bin/git --git-dir="${HOME}/.config/dotfiles" --work-tree="${HOME}" "$@"
}

#
# Backup and install.
#
# Clone my dotfiles repo as a bare repo.
git clone --bare 'https://github.com/tbttin/dotfiles.git' "${HOME}/.config/dotfiles"
# Backup stock config files if they exist and install my dotfiles.
CONFIG_BACKUP_DIR="${HOME}/.config~"
echo 'Attempt to install dotfiles to home folder.'
config checkout 2>&1 | indent
# Piped command exit status: ${PIPESTATUS[0]}, in zsh: ${pipestatus[1]}.
if [ ${PIPESTATUS[0]} = 0 ]; then
    echo 'Checked out config.'
else
    echo "Backing up pre-existing dotfiles to '${CONFIG_BACKUP_DIR}'."
    mkdir -pv "${CONFIG_BACKUP_DIR}" | indent
    config checkout 2>&1 | egrep '\s+\.' | awk {'print $1'} | xargs -I{} mv -v {} "${CONFIG_BACKUP_DIR}" | indent
fi
#
# Checkout and update some configs.
#
config checkout | indent
config config -- status.showUntrackedFiles no
# Use vimdiff as default difftool.
config config -- diff.tool vimdiff
config config -- difftool.prompt false
echo 'Creating regular dirs.'
mkdir -pv ~/{documents,downloads,pictures/screenshots,videos} | indent
if [ -x "$(command -v xdg-user-dirs-update)" ]; then
    echo 'Deleting XDG default dirs.'
    rmdir -v --ignore-fail-on-non-empty ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos} | indent
    xdg-user-dirs-update
fi
echo 'Done.'
