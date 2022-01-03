#!/bin/bash

# Download this raw script from github and execute it with bash:
#   curl --silent --location https://git.io/fi.sh | /bin/bash
# Shorten URL with git.io and curl:
#   curl --inclulde https://git.io --form "url=YOUR_GITHUB_URL_HERE" --form "code=YOUR_CUSTOM_NAME"

CONFIG_BACKUP_DIR="${HOME}/.config~"

indent()
{
	sed 's/^/ > /'
}

config()
{
	git --git-dir="${HOME}/.config/dotfiles" --work-tree="${HOME}" "$@"
}

#
# Backup first
#
# Clone my dotfiles repo as a bare repo.
git clone --bare 'https://github.com/tbttin/dotfiles.git' "${HOME}/.config/dotfiles"
# Backup stock config files if they exist and install my dotfiles.
echo 'Attempt to install dotfiles to home directory.'
config checkout 2>&1 | indent
# Piped command exit status: ${PIPESTATUS[0]}, in zsh: ${pipestatus[1]}.
if test ${PIPESTATUS[0]} = 0
then
	echo 'Checked out configs.'
else
	echo "Backing up pre-existing dotfiles to '${CONFIG_BACKUP_DIR}'."
	mkdir --parrents --verbose "${CONFIG_BACKUP_DIR}" | indent
	config checkout 2>&1 | egrep '\s+\.' | awk {'print $1'} |
		xargs -I{} mv --verbose {} "${CONFIG_BACKUP_DIR}" | indent
	config checkout | indent
fi
# Some configs.
config config -- status.showUntrackedFiles no
# Use vimdiff as default difftool.
config config -- diff.tool vimdiff
config config -- difftool.prompt false
# Clone all submodules.
config submodule update --init --recursive

#
# Preparing $HOME
#
mkdir --parrents --verbose ~/{documents,downloads,pictures/ss,projects/{c,vim},videos} | indent
if type -t xdg-user-dirs-update >/dev/null
then
	rmdir --verbose --ignore-fail-on-non-empty ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos} | indent
	xdg-user-dirs-update
fi
echo 'Done.'

