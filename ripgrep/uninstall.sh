#!/bin/bash

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

echo_info "Uninstalling Ripgrep configurations..."

if [ -L "$HOME/.rgignore" ]; then
  rm "$HOME/.rgignore"
  echo_done "Removed ~/.rgignore"
else
  echo_error "~/.rgignore symlink not found"
fi
