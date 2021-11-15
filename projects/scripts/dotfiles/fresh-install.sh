#!/bin/sh

# Download this raw script from github and execute it with bash:
#   curl -Ls https://git.io/fi.sh | /bin/bash
# Shorten URL with git.io and curl:
#   curl -i https://git.io -F "url=YOUR_GITHUB_URL_HERE" -F "code=YOUR_CUSTOM_NAME"

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
# Backup first.
#
# Clone my dotfiles repo as a bare repo.
/usr/bin/git clone --bare 'https://github.com/tbttin/dotfiles.git' "${HOME}/.config/dotfiles"
# Backup stock config files if they exist and install my dotfiles.
/usr/bin/echo 'Attempt to install dotfiles to home folder.'
config checkout 2>&1 | indent
# Piped command exit status: ${PIPESTATUS[0]}, in zsh: ${pipestatus[1]}.
if [ ${PIPESTATUS[0]} = 0 ]; then
  /usr/bin/echo 'Checked out config.'
else
  /usr/bin/echo "Backing up pre-existing dotfiles to '${CONFIG_BACKUP_DIR}'."
  /usr/bin/mkdir -pv "${CONFIG_BACKUP_DIR}" | indent
  config checkout 2>&1 | /usr/bin/egrep '\s+\.' | /usr/bin/awk {'print $1'} | \
    /usr/bin/xargs -I{} mv -v {} "${CONFIG_BACKUP_DIR}" | indent
fi
#
# Checkout and config.
#
config checkout | indent
config config -- status.showUntrackedFiles no
# Use vimdiff as default difftool.
config config -- diff.tool vimdiff
config config -- difftool.prompt false
# Clone all submodules.
config submodule update --init --recursive
#
# Bonus.
#
# TODO: How to get the directory list from XDG?
/usr/bin/echo 'Creating regular dirs.'
/usr/bin/mkdir -pv ~/{documents,downloads,pictures/ss,projects/{c,vim},videos} | indent
if [ -x "$(command -v xdg-user-dirs-update)" ]; then
  /usr/bin/echo 'Deleting XDG default dirs.'
  /usr/bin/rmdir -v --ignore-fail-on-non-empty ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos} | indent
  /usr/bin/xdg-user-dirs-update
fi
/usr/bin/echo 'Done.'

