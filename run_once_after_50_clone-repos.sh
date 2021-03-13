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

run_stack_in_dir () {
    local cur="pwd$"
    cd "$1" || return 1
    stack install
    cd "$cur" || return 1
}

export STACK_ROOT="$XDG_DATA_HOME"/stack

clone_maybe https://github.com/ndwarshuis/conky.git "$HOME/.config/conky"
clone_maybe https://github.com/ndwarshuis/.emacs.d.git "$HOME/.config/emacs"

rofix_dir="$HOME/.config/rofi-extras"
clone_maybe https://github.com/ndwarshuis/rofi-extras.git "$rofix_dir"
run_stack_in_dir "$rofix_dir"

xman_dir="$HOME/.config/xman"
clone_maybe https://github.com/ndwarshuis/xman.git "$xman_dir"
run_stack_in_dir "$xman_dir"

xmonad_dir="$HOME/.config/xmonad"
clone_maybe https://github.com/ndwarshuis/xmonad-config.git "$xmonad_dir"
run_stack_in_dir "$xmonad_dir"
