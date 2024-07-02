#!/bin/bash

# Installation: download and execute this script with Bash.
#   curl -s -L 'https://git.io/fi.sh' | /usr/bin/bash
# Shorten URL with git.io and curl:
#   curl -i 'https://git.io' -F 'url=GITHUB_URL' -F 'code=CUSTOM_NAME'

REPO_URL='https://github.com/tbttin/dotfiles.git'
GIT_DIR= "${HOME}/.config/dotfiles.git"
BACKUP_DIR="${HOME}/.config~"

config() {
  /usr/bin/git --git-dir="${GIT_DIR}" --work-tree="${HOME}" "$@"
}

#
# Backup
#
# Clone as a bare repo.
/usr/bin/git clone --bare "${REPO_URL}" "${GIT_DIR}"
# Backup stock config files if they exist then install the dotfiles.
/usr/bin/echo 'Attempt to install dotfiles to home directory.'
if config checkout ; then
  /usr/bin/echo 'Checked out configs.'
else
  /usr/bin/echo "Backing up pre-existing dotfiles to '${BACKUP_DIR}'."
  /usr/bin/mkdir -v -p "${BACKUP_DIR}"
  config checkout 2>&1 | /usr/bin/egrep '\s+\.' | /usr/bin/awk {'print $1'} |
    xargs -I{} /usr/bin/mv -v {} "${BACKUP_DIR}"
  config checkout
fi

# The "bare" way's, show no untracked files.
config config --local -- status.showUntrackedFiles no
# Clone all submodules.
config submodule update --init --recursive

#
# Bring back $HOME
#
/usr/bin/mkdir -v -p ~/{documents,downloads,pictures/ss,projects/{c,vim},videos}
type -t /usr/bin/xdg-user-dirs-update >/dev/null &&
  /usr/bin/rmdir -v --ignore-fail-on-non-empty \
    ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos} &&
  /usr/bin/xdg-user-dirs-update
/usr/bin/echo 'Done.'

# vim: ft=sh

