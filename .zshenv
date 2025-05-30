# ███    ███████████  █████████  █████   █████ ██████████ ██████   █████ █████   █████    ███
#░███   ░█░░░░░░███  ███░░░░░███░░███   ░░███ ░░███░░░░░█░░██████ ░░███ ░░███   ░░███    ░███
#░███   ░     ███░  ░███    ░░░  ░███    ░███  ░███  █ ░  ░███░███ ░███  ░███    ░███    ░███
#░███        ███    ░░█████████  ░███████████  ░██████    ░███░░███░███  ░███    ░███    ░███
#░███       ███      ░░░░░░░░███ ░███░░░░░███  ░███░░█    ░███ ░░██████  ░░███   ███     ░███
#░███     ████     █ ███    ░███ ░███    ░███  ░███ ░   █ ░███  ░░█████   ░░░█████░      ░███
#░███    ███████████░░█████████  █████   █████ ██████████ █████  ░░█████    ░░███        ░███
#░░░    ░░░░░░░░░░░  ░░░░░░░░░  ░░░░░   ░░░░░ ░░░░░░░░░░ ░░░░░    ░░░░░      ░░░         ░░░ 
#
# Filename:      zshenv
# Purpose:       system-wide .zshenv file for zsh(1)
# Authors:       grml-team (grml.org)
# Massive edits, additions, deletions, and updates/upgrade were required to 
# get the code to function at all, if not correctly, these edits are an amalgam
# of original code, from additional open sources, and grml's own zsh-lovers. 
# The edits, cuts, slashes, slices, and repeated testing done by drpdead@github aka dropDEADRedd
# License:       This file is licensed under Beerware
################################################################################
# no xsource() here because it's only created in zshrc! (which is good)
[[ -r /etc/environment ]] && source /etc/environment
TSCHOSTNAME="quail-ghoul.ts.net"
HOSTNAME=${HOSTNAME:-${TSCHOSTNAME}}
# make sure /usr/bin/id is available
if [[ -x /usr/bin/id ]] ; then
    [[ -z "$USER" ]] && export USER=$(/usr/bin/id -un)
    [[ $LOGNAME == LOGIN ]] && LOGNAME=$(/usr/bin/id -un)
fi
    
# generic $PATH handling
if (( EUID != 0 )); then
  path=(
    /usr/local/bin
    /usr/local/sbin
    /usr/local/games
    /bin
    /sbin
    /usr/bin
    /usr/sbin
    /usr/games
    $HOME/bin
    $HOME/.bin
    $HOME/go/bin
    $HOME/.cargo/bin
    $HOME/.local/bin
    "${ADDONS}"
    "${path[@]}"
  )
else
  path=(
    $HOME/bin
    /usr/local/sbin
    /usr/local/bin
    /sbin
    /bin
    /usr/sbin
    /usr/bin
    /var/lib/flatpak/exports/bin/
    "${ADDONS}"
    "${path[@]}"
  )
fi

# remove empty components to avoid '::' ending up + resulting in './' being in $PATH
path=( "${path[@]:#}" ) 

typeset -U path

# less (:=pager) options:
#  export LESS=C
typeset -a lp; lp=( ${^path}/lesspipe(N) )
if (( $#lp > 0 )) && [[ -x $lp[1] ]] ; then
    export LESSOPEN="|lesspipe %s"
elif [[ -x /usr/bin/lesspipe.sh ]] ; then
    export LESSOPEN="|lesspipe.sh %s"
fi 
unset lp
# set environment variables (important for autologin on tty)
export READNULLCMD=${PAGER:-/usr/bin/pager}
# allow zeroconf for distcc
export DISTCC_HOSTS="+zeroconf"
# MAKEDEV should be usable on udev as well by default:
export WRITE_ON_UDEV=yes
ZDOTDIR=${ZDOTDIR:-${HOME}}
ZSHDDIR=${ZSHDDIR:-${ZDOTDIR}/dotfiles/.config/zshrc}
FIZSHDIR=${FIZSHDIR:-${ZSHDDIR}/.fizsh}
DOTDIR=${DOTDIR:-${HOME}/.dotfiles}
ML4W=${ML4W:-${DOTDIR}/.config/ml4w}
ML4W_SETTINGS=${ML4W_SETTINGS:-${ML4W}/settings}
WALLPAPERS=${WALLPAPERS:-${XDG_PICTURES_DIR}/wallbangers}
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:${XDG_DATA_HOME}/flatpak/exports/share"
export XDG_DOWNLOAD_DIR="${HOME}/Downloads"
export XDG_PICTURES_DIR="${HOME}/Pictures"
export EDITOR="/usr/bin/micro"
export BROWSER="/usr/bin/microsoft-edge-stable"
export VISUAL="micro"
export MPLCONFIGDIR="${HOME}/.cache/matplotlib"
# -------------------
# /TMP $HOME/TMP
# -------------------
export TEMP="$HOME/tmp"
export TMP="/tmp"
export TMPDIR="$TEMP"
export TMPPREFIX="${TEMP}/zsh"
if [ ! -d "${TEMP}" ]; then mkdir "${TEMP}"; fi
# Use hostname in TMUX_TMPDIR as $HOME may be on nfs.
export TMUX_TMPDIR="${TMPDIR}/tmux-${HOST}-${UID}"
if [ ! -d "${TMUX_TMPDIR}" ]; then mkdir -p "${TMUX_TMPDIR}"; fi
# -------------------
# history
# -------------------
HISTFILE=${HISTFILE:-${ZDOTDIR}/.zsh_history}
HISTSIZE=100000
SAVEHIST=10000 # useful for setopt append_history
# dirstack handling
DIRSTACKSIZE=${DIRSTACKSIZE:-40}
DIRSTACKFILE=${DIRSTACKFILE:-${ZDOTDIR}/.zdirs}
# --------------------
# MONERO
# --------------------
# ADD Monero PATHs/ADDYs/KEYS etc etc
# Reserved Monero Line1 
# Reserved Monero Line2

# Begin added by argcomplete
fpath=( /usr/lib/python3.13/site-packages/argcomplete/bash_completion.d "${fpath[@]}" )
# End added by argcomplete

## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4
