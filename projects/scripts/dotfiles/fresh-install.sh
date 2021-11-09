#!/bin/sh

# Download this raw script from github and execute it with sh (or where it point to):
#   curl -Ls https://git.io/fi.sh | /bin/sh
# Shorten URL: curl -i https://git.io -F "url=YOUR_GITHUB_URL_HERE" -F "code=YOUR_CUSTOM_NAME"

CONFIG_BACKUP_DIR="${HOME}/.config~"

function indent {
  sed 's/^/  -> /'
}

function config {
  /usr/bin/git --git-dir="${HOME}/.config/dotfiles" --work-tree="${HOME}" "$@"
}

#
# Backup first.
#
# Clone my dotfiles repo as a bare repo.
git clone --bare 'https://github.com/tbttin/dotfiles.git' "${HOME}/.config/dotfiles"
# Backup stock config files if they exist and install my dotfiles.
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
# Checkout and config.
#
config checkout | indent
config config -- status.showUntrackedFiles no
# Use vimdiff as default difftool.
config config -- diff.tool vimdiff
config config -- difftool.prompt false
#
# Bonus.
#
# TODO: How to get the directory list from XDG?
echo 'Creating regular dirs.'
mkdir -pv ~/{documents,downloads,pictures/ss,projects/{c,vim},videos} | indent
if [ -x "$(command -v xdg-user-dirs-update)" ]; then
  echo 'Deleting XDG default dirs.'
  rmdir -v --ignore-fail-on-non-empty ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos} | indent
  xdg-user-dirs-update
fi
echo 'Done.'

