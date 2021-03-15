# dotfiles

My personal dotfiles used for Arch Linux. Use at your own risk ;)

## First, a story...

This is a rough outline of how these dotfiles evolved. Perhaps others can
relate:
1. Install Linux. Best day ever.
2. Notice these annoying files with dots in front of them. There aren't too
   many, so whatever.
3. Use Linux more, notice funny files with dots in front of them are
   exponentially multiplying.
4. Research funny files with dots in front of them. Find they are called
   "dotfiles" and apparently they annoy others as well.
5. Research more and find "dotfile management systems" that claim to be able to
   tame said "dotfiles."
6. Try many "dotfile management systems" only to be disappointed. Resort to
   using git.
7. Discover a terribly powerful tool called ansible. Get the brilliant idea
   to manage dotfiles with ansible.
8. Spend a week setting up neat roles for ansible. All seems right in the
   universe.
9. Change one tiny thing in my config. Ansible breaks. Abandon playbooks in fit
   of rage and revert to using git.
10. Forget I'm using git to manage my dotfiles.
11. SSD begins failing. Remember git exists and frantically commit "everything."
12. Install fresh SSD. Deploy dotfiles with git.
13. Realize half my config is missing and/or wrong.
14. Research again what dotfiles management systems might exist. Discover
    chezmoi. Put all dotfiles in chezmoi...
    
Which brings me here.

These dotfiles are managed with chezmoi, which seems like a nice balance between
the revision control aspects of git, the template-based configurability of
ansible, and light scripting for extra wiggle room. I just started using chezmoi
so only time will tell if it can fill my ultimate desire to have a clutter-free,
OCD-friendly home directory with minimal hassle.

## Design Overview

### Headless Configuration

#### Environment

All environmental variables are set in `.pam_environment` which has the
advantage of being loaded before everything else, including my shell. This
allows me to neatly organize everything according to XDG base specifications (eg
configurations files actually go in `~/.config`) which makes this repo
exponentially more pleasent to use.

#### Shell

See [zsh config](dot_config/zsh).

### X Server Configuration

#### Window Manager

Xmonad is minimalist window manager written and configured in Haskell, which
makes it automatically awesome as well as super stable.

See [my xmonad repo](https://github.com/ndwarshuis/xmonad-config) (which also 
includes xmobar).

#### Rofi

Rofi displays a pretty menu that allows the user to select something and
possibly perform an action with that selection. It is infinitely useful and
comes with many extensions.

My use cases:
- launching apps (Start Button (TM) replacement)
- forking background daemons
- managing the clipboard
- selecting workspaces and windows
- selecting monitor configurations
- controlling networking interfaces
- mounting block devices
- querying passwords from Bitwarden

Some of these are custom wrappers found
[here](https://github.com/ndwarshuis/rofi-extras).

#### Conky

Conky is a super-configurable system monitor that runs on the desktop (your
nerdiness on fully display). See [here](https://github.com/ndwarshuis/conky) for
my configuration.

#### Emacs

Emacs is an operating system masquerading as a text editor. See
[here](https://github.com/ndwarshuis/.emacs.d) for my emacs config.

#### Keyboard Shortcuts

I have gigantic hands, which means I need to contort my pinkies to press the
control keys (among other things). The obvious solution is to remap my keyboard
so these important keys are within reach.

I do this with an [xkb layout](https://github.com/ndwarshuis/xkb-hypermode)
which here is installed as a custom package because these files need to be
root-owned along with the rest of the xkb layouts (X server limitation?).

Since this layout will map some keys on top of one another (for example, the
RETURN key is right control) I use xcape to differentiate between keypress,
keyhold, and keyrelease (in the past example, keyrelease is mapped back to
RETURN). To make this even more complicated, VirtualBox doesn't filter out
xcape'd keybindings, which means some keys will be "pressed" twice from the
guest viewpoint. This is handled as gracefully as possible with a small utility
I wrote called [xman](https://github.com/ndwarshuis/xman) which will kill xcape
when a VirtualBox window is in focus.

If this isn't confusing enough, imagine the look on someone's face who dares
to use my laptop, only to find that the ALT key is actually the spacebar :)


## Usage

If you are new to Linux or dotfile management in general, I would discourage you
from blindly deploying these dotfiles. Instead, read each file and understand
how it works. If you find something interesting, copy the interesting bit to
your own config and experiment with that.

### Distro Requirements

Arch Linux only

### Dependencies

* chezmoi
* yay
* sudo

Note that any build tools (stack for Haskell binaries) will be installed during
deployment.

### Pre-Installation

These must be done before cloning and applying these dotfiles.

1. create the user for whom these dotfiles will be deployed (including home
   directory)
2. set up sudo privileges for the user who will be cloning these dotfiles
3. set up makepkg to according to preferences
4. set up yay according to preferences

### Installation

Deploy using chezmoi

``` sh
chezmoi init --apply --verbose https://ndwarshuis/dotfiles-chezmoi.git
```

This will:
1. clone the dotfiles and apply them
2. clone other git repos as applicable (emacs, xmonad, conky, etc)
3. install system packages as needed
4. install any custom PKGBUILDs (which many have some special compile flags or
   pull a different version that what is in the repos)
5. compile any Haskell binaries as needed (xmonad and associated tooling)
