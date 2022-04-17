#!/bin/bash

# Installation: download this raw script from github and execute it with Bash.
#   curl --silent --location https://git.io/fi.sh | /bin/bash
# Shorten URL with git.io and curl:
#   curl --inclulde https://git.io --form "url=YOUR_GITHUB_URL_HERE" --form "code=YOUR_CUSTOM_NAME"

CONFIG_BACKUP_DIR="${HOME}/.config~"

indent()
{
	/usr/bin/sed 's/^/ > /'
}

config()
{
	/usr/bin/git --git-dir="${HOME}/.config/dotfiles" --work-tree="${HOME}" "$@"
}

#
# Backup first
#
# Clone my dotfiles repo as a bare repo.
/usr/bin/git clone --bare 'https://github.com/tbttin/dotfiles.git' "${HOME}/.config/dotfiles"
# Backup stock config files if they exist and install my dotfiles.
/usr/bin/echo 'Attempt to install dotfiles to home directory.'
config checkout 2>&1 | indent
# Piped command exit status: ${PIPESTATUS[0]}, in zsh: ${pipestatus[1]}.
if test ${PIPESTATUS[0]} = 0
then
	/usr/bin/echo 'Checked out configs.'
else
	/usr/bin/echo "Backing up pre-existing dotfiles to '${CONFIG_BACKUP_DIR}'."
	/usr/bin/mkdir --parrents --verbose "${CONFIG_BACKUP_DIR}" | indent
	config checkout 2>&1 | /usr/bin/egrep '\s+\.' | /usr/bin/awk {'print $1'} |
		xargs -I{} /usr/bin/mv --verbose {} "${CONFIG_BACKUP_DIR}" | indent
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
/usr/bin/mkdir --parrents --verbose ~/{documents,downloads,pictures/ss,projects/{c,vim},videos} | indent
if type -t /usr/bin/xdg-user-dirs-update >/dev/null
then
	/usr/bin/rmdir --verbose --ignore-fail-on-non-empty ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos} | indent
	/usr/bin/xdg-user-dirs-update
fi
/usr/bin/echo 'Done.'

