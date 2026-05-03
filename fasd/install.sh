#!/bin/bash

source "$(dirname "$0")/../helpers.sh"

# fasd was removed from Homebrew. zoxide is the modern replacement and is
# already installed via Brewfile. This module is kept as a no-op placeholder.
echo_warning "fasd is no longer available in Homebrew — using zoxide instead (already installed)."
echo_info "Use 'z dirname' to jump to any frequent directory."
echo_done "fasd module skipped."
