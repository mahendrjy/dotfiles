#!/bin/bash

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"

echo_info "Setting up Ripgrep configurations..."

if [ -L "$HOME/.rgignore" ] && [ "$(readlink "$HOME/.rgignore")" = "$DOTFILES/ripgrep/.rgignore" ]; then
  echo_done ".rgignore already symlinked"
else
  rm -f "$HOME/.rgignore"
  ln -sf "$DOTFILES/ripgrep/.rgignore" "$HOME/.rgignore"
  echo_done "Symlinked ~/.rgignore"
fi
