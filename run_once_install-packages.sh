#! /bin/bash

## install all packages required for this configuration to function.
## Configuration is assumed to be handled elsewhere (for now) eg in etckeeper
## or with ansible

PKGBUILD_dir="$HOME/.local/share/packages"

call_makepkg() {
    cd "$PKGBUILD_dir/$1" || exit
    makepkg -s -r -i -f --noconfirm
}

## install packages (those that are either in official repos or AUR)

## TODO add template switches to control which of these get installed based
## on my config
dunst_pkgs=(dunst)
emacs_pkgs=(emacs mu)
flameshot_pkgs=(flameshot)
gtk_pkgs=(zuki-themes)
nvidia_pkgs=(optimus-manager)
r_pkgs=(r docker-rootless-extras-bin gcc-fortran texlive-bin tk)
redshift_pkgs=(redshift)
rofi_pkgs=(rofi-git bitwarden-cli libnotify rofi-greenclip
           networkmanager-dmenu-git veracrypt sshfs jmtpfs)
seafile_pkgs=(seafile)
urxvt_pkgs=(urxvt-tabbedex rxvt-unicode urxvt-perls)
xmonad_pkgs=(stack-static autorandr feh xorg-server xorg-xset libpulse playerctl
             wireless_tools acpid ttf-symbola-free ttf-symbola-free ttf-dejavu
             awesome-terminal-fonts numlockx picom i3lock-color xorg-xrandr
             xss-lock)
zsh_pkgs=(zsh zsh-completions zsh-syntax-highlighting)

## AUR pkgs needed for spotify
spotify_pkgs=(gconf)

sudo -v

yay --noconfirm --removemake -Syy --sudoloop "${dunst_pkgs[@]}" \
    "${emacs_pkgs[@]}" "${flameshot_pkgs[@]}" "${gtk_pkgs[@]}" \
    "${nvidia_pkgs[@]}" "${nvidia_pkgs[@]}" "${r_pkgs[@]}" \
    "${redshift_pkgs[@]}" "${rofi_pkgs[@]}" "${seafile_pkgs[@]}" \
    "${urxvt_pkgs[@]}" "${xmonad_pkgs[@]}" "${zsh_pkgs[@]}" "${spotify_pkgs[@]}"

## install custom packages (eg those for which I have my own PKGBUILDs)

call_makepkg "clevo-xsm-wmi-dkms"
call_makepkg "conky-lua"
call_makepkg "spotify"
call_makepkg "xkb-hypermode"
