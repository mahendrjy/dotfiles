#!/bin/bash

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

echo_info "Uninstalling ANKI terminal review script..."

if [ -L "$HOME/bin/anki-review" ]; then
  rm "$HOME/bin/anki-review"
  echo_done "Removed ~/bin/anki-review"
else
  echo_error "anki-review not found at ~/bin/anki-review"
fi

rm -f "$HOME/bin/anki-agent-bridge" "$HOME/bin/anki-ai-tutor"
