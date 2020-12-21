#!/bin/bash

# Download this script from github repo and execute it with bash.
# curl -Ls https://git.io/fresh-install | /bin/bash

function config {
    /usr/bin/git --git-dir="${HOME}/.config/dotfiles" --work-tree="${HOME}" "$@"
}

# Clone my dotfiles repo as a bare repo.
git clone --bare 'https://github.com/tbttin/dotfiles.git' "${HOME}/.config/dotfiles"
# Backup stock config files if they exist and install my dotfiles.
CONFIG_BACKUP_DIR=~/.config~
mkdir -pv ${CONFIG_BACKUP_DIR}
config checkout | sed 's/^/  /'
# Piped command exit status: ${PIPESTATUS[0]}, in zsh: ${pipestatus[1]}.
if [ ${PIPESTATUS[0]} = 0 ]; then
    echo 'Checked out config.'
else
    echo 'Backing up pre-existing dotfiles.'
    config checkout 2>&1 | egrep '\s+\.' | awk {'print $1'} | xargs -I{} mv {} $CONFIG_BACKUP_DIR
fi
config checkout
config config status.showUntrackedFiles no
echo 'Create and update regular directories.'
mkdir -pv ~/{documents,downloads,pictures/screenshots,videos}
if [ -x "$(command -v xdg-user-dirs-update)" ]; then
    rmdir -v --ignore-fail-on-non-empty ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
    xdg-user-dirs-update
fi
# Additional configs.
# Vimdiff as default difftool.
config config diff.tool vimdiff
config config difftool.prompt false
echo 'Done.'
