#! /bin/bash


# This script installs all packages that my config needs. It also pulls all my
# git repos that I use in my config. It will only pull them if they don't
# exist. Rather than use the import approach suggested in the chezmoi howto,
# this doesn't require me to keep 'syncing' changes when I work in these repos
# directly. The tradeoff is that it will only pull the latest master, which is
# totally fine with me.

# Configuration is assumed to be handled elsewhere (for now) eg in etckeeper
# or with ansible.

clone_maybe () {
    if [ ! -d "$2" ]; then
        echo cloning git repo: "$1"
        git clone --recurse-submodules "$1" "$2"
    else
        echo git repo already exists: "$1"
    fi
}

run_stack_in_dir () {
    local cur
    cur="$(pwd)"
    cd "$1" || return 1
    stack install
    cd "$cur" || return 1
}

#
# CLONE EMACS CONFIG
#

# do this before installing packages because its config will spit out
# dependencies that it needs to run at full capacity

emacs_dir="$HOME/.config/emacs"
clone_maybe https://github.com/ndwarshuis/.emacs.d.git "$emacs_dir"

## INSTALL PACKAGES

# The script that installs packages must be run as root, which allows sudo to
# only be used once. Pass the emacs config directory so it can get a list of
# dependencies for emacs

sudo "$HOME/.bin/bootstrap_pkgs" "$HOME/.local/share/packages" "$emacs_dir"

# Install Haskell dependencies for emacs. This is only necessary because some
# Haskell programs are not packaged as "bin" or "stack" packages, in which case
# arch will pull in a bunch of crap because dynamic linking

IFS=' ' read -r -a emacs_stack_pkgs \
   < <(emacs -batch -l "$emacs_dir/init.el" --eval \
             "(print (s-join \" \" (nd/get-stack-dependencies)))" 2>/dev/null | \
           sed -n -e 's/"\(.*\)"/\1/p')
echo "Emacs requires the following Haskell packages: ${emacs_stack_pkgs[*]}"
for p in "${emacs_stack_pkgs[@]}";
do
    stack install "$p"
done

## CLONE/BUILD HASKELL-BASED REPOS

# TODO not dry (this is in .pam_environment)
# TODO could use tmp for this and it would probably be faster and get around
# the DRY problem, at the expense that build xmonad the first time live will
# be a PITA
export STACK_ROOT="$HOME/.local/share/stack"

rofix_dir="$HOME/.config/rofi-extras"
clone_maybe https://github.com/ndwarshuis/rofi-extras.git "$rofix_dir"
run_stack_in_dir "$rofix_dir"

xman_dir="$HOME/.config/xman"
clone_maybe https://github.com/ndwarshuis/xman.git "$xman_dir"
run_stack_in_dir "$xman_dir"

xmonad_dir="$HOME/.config/xmonad"
clone_maybe https://github.com/ndwarshuis/xmonad-config.git "$xmonad_dir"
run_stack_in_dir "$xmonad_dir"

## CLONE OTHER REPOS

clone_maybe https://github.com/ndwarshuis/conky.git "$HOME/.config/conky"
