#! /bin/bash

clone_maybe () {
    if [ ! -d "$2" ];
        echo cloning git repo: "$1"
        git clone --recurse-submodules "$1" "$2"
    else
        echo git repo already exists: "$1"
    fi
}

clone_maybe https://github.com/ndwarshuis/.emacs.d.git "$HOME/.config/emacs"
clone_maybe https://github.com/ndwarshuis/rofi-extras.git "$HOME/.config/rofi-extras"
clone_maybe https://github.com/ndwarshuis/xmonad-config.git "$HOME/.config/xmonad"
clone_maybe https://github.com/ndwarshuis/xman.git "$HOME/.config/xman"

