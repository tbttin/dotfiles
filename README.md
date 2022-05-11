# About

This [durdn's tutorial] - a good dotfiles introduction, it brought me
here. Why Git bare? Because it's simple!

My configuration files (default on Arch Linux):

  - Vim: vimrc, file type plugins (makrdown, c, vim), .etc

  - Git.

  - Bash: bash_profile, bashrc, aliases, functions.

  - X: xinitrc, xmodmap file.

  - Suckless configs and PKGBUILDs: dwm, st, slstatus.

  - makepkg

  - Zathura.

  - ...

[durdn's tutorial]: https://www.atlassian.com/git/tutorials/dotfiles
"durdn's tutorial"

# Installation

- I do not recommend this, but there is a way:

  ```bash
  curl --silent --location https://git.io/fi.sh | /bin/bash
  ```

- What does this script do?

  + Clone this repo as a bare repo into `$HOME/.config/dotfiles`.

  + Backup conflicting files in `$HOME` to `$HOME/.config~`.

  + Checkout cloned dotfiles to `$HOME`.

  + Re-config checked out repo (to not show untracked files, difftool).

  + (Personal) Create common use directories: `documents`, `download`,
    `pictures`, etc.

  + If `xdg-user-dirs` is installed:

    * Remove xdg-user-dirs's default (uppercase) directories like
      `Documents`, `Download`, `Videos`, etc. (if it's empty).

+ *TODO*: install all necessary packages.
