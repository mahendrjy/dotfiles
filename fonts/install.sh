#!/bin/bash

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

echo_info "Configuring fonts..."
mkdir -p "${HOME}/Library/Fonts"

FONTS_DIR="$(dirname "$0")"

# Copy local font packs if they exist in the repo
for font_dir in "Operator Mono" "Operator Mono Lig" "Dank Mono"; do
  if [[ -d "$FONTS_DIR/$font_dir" ]]; then
    echo_info "Installing $font_dir..."
    cp -a "$FONTS_DIR/$font_dir/." "${HOME}/Library/Fonts"
  fi
done

# Install Nerd Fonts via Homebrew cask
echo_info "Installing Nerd Fonts (JetBrains Mono)..."
brew install --cask font-jetbrains-mono-nerd-font || echo_warning "font-jetbrains-mono-nerd-font install failed, skipping..."

echo_done "Fonts configuration!"
