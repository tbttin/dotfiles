# About

This [durdn's tutorial](https://www.atlassian.com/git/tutorials/dotfiles) - a
dotfiles introduction, it brought me here. Why Git bare? Because it's simple!

My configuration files (default on Arch Linux):

  - Vim.

  - Git.

  - Bash: profile, rc, aliases.

  - X config files.

  - Suckless configs: dwm, st, slstatus, ...

  - Pacman, makepkg and some suckless's PKGBUILDs.

  - Zathura.

  - ...

# Installation

- I do not recommend this, but there is a way:

  ```bash
  curl --silent --location https://git.io/fi.sh | /bin/bash
  ```

- What does this scrip do?

  + Backup conflicting files in `$HOME` to `$HOME/.config~`.

  + Re-config this dotfies bare repo (not show untracked files, diff tool).

  + If `xdg-user-dirs` is installed:

    * Remove xdg-user-dirs's uppercase default directories like Documents,
      Download, Videos, etc. (if it's empty).

    * Create `documents`, `download`, `projects`, etc. directories.

  + *TODO*: install all necessary packages.
