#! /bin/bash

## This script pulls all my git repos that I use in my config. It will only pull
## them if they don't exist. Rather than use the import approach suggested in
## the chezmoi howto, this doesn't require me to keep 'syncing' changes when I
## work in these repos directly. The tradeoff is that it will only pull the
## latest master, which is totally fine with me.

clone_maybe () {
    if [ ! -d "$2" ]; then
        echo cloning git repo: "$1"
        git clone --recurse-submodules "$1" "$2"
    else
        echo git repo already exists: "$1"
    fi
}

clone_maybe https://github.com/ndwarshuis/conky.git "$HOME/.config/conky"
clone_maybe https://github.com/ndwarshuis/.emacs.d.git "$HOME/.config/emacs"
clone_maybe https://github.com/ndwarshuis/rofi-extras.git "$HOME/.config/rofi-extras"
clone_maybe https://github.com/ndwarshuis/xman.git "$HOME/.config/xman"
clone_maybe https://github.com/ndwarshuis/xmonad-config.git "$HOME/.config/xmonad"

