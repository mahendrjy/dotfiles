#!/bin/bash

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"

echo_info "Setting up ANKI terminal review script..."

mkdir -p "$HOME/bin"

if [ -L "$HOME/bin/anki-review" ] && [ "$(readlink "$HOME/bin/anki-review")" = "$DOTFILES/anki/anki-review" ]; then
  echo_done "anki-review already installed"
else
  ln -sf "$DOTFILES/anki/anki-review" "$HOME/bin/anki-review"
  chmod +x "$HOME/bin/anki-review"
  echo_done "anki-review installed! Run: anki-review"
fi

# Clean up old standalone symlinks
rm -f "$HOME/bin/anki-agent-bridge" "$HOME/bin/anki-ai-tutor"
