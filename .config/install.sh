#!/bin/bash

# Installation: download and execute this script with Bash.
#   curl -s -L 'https://tbttin.s.gy/dotfilesinstall' | /usr/bin/bash

#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO='https://github.com/tbttin/dotfiles.git'
DOTFILES_DIR="${HOME}/.local/state/dotfiles.git"
BACKUP_DIR="${HOME}/.local/state/dotfiles-backup"

config() {
	git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

# 1. Clone bare repo
if [ ! -d "$DOTFILES_DIR" ]; then
	git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

config config --local status.showUntrackedFiles no

# 2. Checkout and backup conflicts (~/.config/user-dirs.dirs)
if ! config checkout 2>/dev/null; then
	mkdir -p "$BACKUP_DIR"
	config checkout 2>&1 \
		| grep -E "^\s+" \
		| awk '{print $1}' \
		| while IFS= read -r file; do
			mkdir -p "$BACKUP_DIR/$(dirname "$file")"
			mv "$HOME/$file" "$BACKUP_DIR/$file"
		  done
	config checkout
fi

# 3. Hook XDG Bash into /etc
if ! grep -q "\.config/bash/bash_profile" /etc/profile; then
	doas tee -a /etc/profile >/dev/null <<'EOF'

# Source user XDG profile
if [ -f "$HOME/.config/bash/bash_profile" ]; then
	. "$HOME/.config/bash/bash_profile"
fi

EOF
fi

if ! grep -q "\.config/bash/bashrc" /etc/bash.bashrc; then
	doas tee -a /etc/bash.bashrc >/dev/null <<'EOF'

# Source user XDG bashrc
if [ -f "$HOME/.config/bash/bashrc" ]; then
	. "$HOME/.config/bash/bashrc"
fi

EOF
fi

# 4. Clean $HOME
mkdir -p "${HOME}/{projects/{c,vim},pictures/screenshots}"
rm -f "${HOME}/{.bashrc,.bash_profile,.profile,.bash_logout}"

