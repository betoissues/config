# beto's dotfiles

Configuration files in this repository are to be used with GNU Stow with the
repository placed in the user $HOME.

I tried to follow `XDG_CONFIG_HOME` standard and store configuration files
inside `$HOME/.config` where possible.

Currently there are configuration files for the following software:

- 2bwm (single `config.h`, not to be used with `stow`)
- aerc (excluding `accounts.conf`)
- alacritty
- dunst (includes a `launch.sh`) // todo: remove `feh` from this script
- kde-2bwm (replaces Plasma's `set_window_manager.sh`)
- khard (for vCard addressbook management)
- nvim
- polybar (may be splitted between desktop and laptop. mail checker requires
  authentication and specific devices/interfaces are to be set)
- rofi (with gruvbox theme, alacritty terminal and ssh enabled)
- tmux (there's `tpm` plugin support but it's not currently in use)
- vdirsyncer (CardDAV sync, yet to add CalDAV)
- wezterm
- X11 (`.xinitrc` for starting X from tty)
- zathura
- zsh (requires `antigen`, loads local theme, syntax highlighting not included
  in repo, `nvm`, `fzf` and `cargo` env source added)
