#!/bin/bash

source "$(dirname "$0")/../helpers.sh"

echo_info "Configuring VS Code..."

if ! command -v code &>/dev/null; then
  echo_warning "VS Code 'code' command not found."
  echo_warning "Install VS Code, then run: Shell Command: Install 'code' command in PATH"
  exit 0
fi

EXTENSIONS_FILE="$(dirname "$0")/extensions.json"

echo_info "Installing VS Code extensions..."
python3 -c "
import json
with open('$EXTENSIONS_FILE') as f:
    for ext in json.load(f).get('recommendations', []):
        print(ext)
" | while read -r ext; do
  echo "  → $ext"
  code --install-extension "$ext" --force 2>/dev/null || echo_warning "Failed: $ext"
done

echo_done "VS Code configuration!"
