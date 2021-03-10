#! /bin/bash

## maybe break these apart in separate scripts...it isn't clear why all these
## things are needed

## TODO this is annoying since it runs a bunch of separate commands (if I want
## to stop all of them I need to spam ctrl-C a zillion times)

## TODO add conky (a custom package)

# dunst
sudo pacman -S dunst

# emacs
yay -S emacs mu

# flameshot
sudo pacman -S flameshot

# gtk
yay -S stack-static mu zuki-themes optimus-manager

# optimus manager
yay -S optimus-manager

# R
sudo pacman -S r docker gcc-fortran texlive-bin tk

# redshift
sudo pacman -S redshift

# rofi
yay -S rofi-git bitwarden-cli libnotify rofi-greenclip networkmanager-dmenu-git \
    veracrypt sshfs jmptfs

# seafile
yay -S seafile-client

# urxvt
yay -S urxvt-tabbedex rxvt-unicode urxvt-perls

# xmonad and friends (this isn't fun to look at)
yay -S stack-static autorandr feh xorg-server xorg-xset libpulse playerctl \
    wireless_tools acpid ttf-symbola-free ttf-symbola-free ttf-dejavu \
    awesome-terminal-fonts numlockx picom i3lock-color xorg-xrandr xss-lock

## TODO add xkb_hypermode (a custom package)

# zsh
sudo pacman -S zsh zsh-completions zsh-syntax-highlighting

## local packages
PKGBUILD_dir="$HOME/.local/share/packages"

cd "$PKGBUILD_dir/clevo-xsm-wmi-dkms"
makepkg -s -r -i --noconfirm

cd "$PKGBUILD_dir/conky-lua"
makepkg -s -r -i --noconfirm

cd "$PKGBUILD_dir/xkb-hypermode"
makepkg -s -r -i --noconfirm


