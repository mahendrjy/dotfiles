#!/bin/bash

source "$(dirname "$0")/../helpers.sh"

RANGER_DIR="$(cd "$(dirname "$0")" && pwd)"

echo_info "Installing Ranger and Neovim..."
brew install ranger
brew install neovim

echo_info "Configuring Ranger..."
mkdir -p "${HOME}/.config/ranger"

echo_info "Symlinking config files..."
ln -sf "$RANGER_DIR/rc.conf"      "${HOME}/.config/ranger/rc.conf"
ln -sf "$RANGER_DIR/scope.sh"     "${HOME}/.config/ranger/scope.sh"
ln -sf "$RANGER_DIR/commands.py"  "${HOME}/.config/ranger/commands.py"
ln -sf "$RANGER_DIR/rifle.conf"   "${HOME}/.config/ranger/rifle.conf"
ln -sf "$RANGER_DIR/cheatsheet.md" "${HOME}/.config/ranger/cheatsheet.md"

# scope.sh must be executable
chmod +x "${HOME}/.config/ranger/scope.sh"

echo_info "Installing bat (for file previews)..."
brew install bat

echo_done "Ranger configured! Run 'ranger' and press '?h' to see the shortcut cheatsheet."
