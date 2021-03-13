#! /bin/bash

## install all packages required for this configuration to function.
## Configuration is assumed to be handled elsewhere (for now) eg in etckeeper
## or with ansible.

## this just calls another bootstrap script as root, which allows me to only
## require entering a sudo password once

sudo "$HOME/.bin/bootstrap_pkgs" "$HOME/.local/share/packages"
