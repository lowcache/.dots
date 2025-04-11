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
      c="${f/.config\/zshrc/.config\/zshrc\/custom}"
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
_source_zsh
# -----------------------------------------------------
# Load single customization file (if exists)
# -----------------------------------------------------

if [ -f ~/.zshrc_custom ]; then
    source ~/.zshrc_custom
fi




. "$HOME/.local/share/../bin/env"
