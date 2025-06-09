#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|
# -----------------------------------------------------
# ML4W zshrc loader- dropdead version
# -----------------------------------------------------

# DON'T CHANGE THIS FILE (anymore)

_source_zsh() {
  # Source files in ~/.config/zshrc/, with custom overrides
  for f in ~/.config/zshrc/*; do
    if [ ! -d "$f" ]; then
      c="${f/.config\/zshrc/.config\/zshrc\/functions}"
      [[ -f "$c" ]] && source "$c" || source "$f"
    fi
  done

  # Source files from specified zpaths
  typeset -ag zpath
  zpath+=( /usr/share/zsh/plugins/* )
  zpath+=( "${HOME}/.dotfiles/.config/zshrc/" )
  zpath+=( /etc/zsh )

  local z="${zpath[*]}"

  for zshd in $(print -rl -- "$z"/*.(z)sh(N)); do
    source "$zshd"
  done
}

# -----------------------------------------------------
# Load single customization file (if exists)
# -----------------------------------------------------

if [ -f ~/.zshrc_custom ]; then
    source ~/.zshrc_custom
fi


. "$HOME/.local/share/../bin/env"
export ZPFX="$HOME/.dotfiles/.config/zshrc/zinit/polaris/"
declare -A ZINIT
ZINIT[BIN_DIR]="$ZSHDDIR/zinit/zinit.git"
ZINIT[HOME_DIR]="$ZSHDDIR/zinit/"
ZINIT_HOME="${ZSHDDIR:-${HOME}/.dotfiles/.config/zshrc}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

_source_zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dropdead/google-cloud-sdk/path.zsh.inc' ]; then . '/home/dropdead/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dropdead/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/dropdead/google-cloud-sdk/completion.zsh.inc'; fi
