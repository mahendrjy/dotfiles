#!/bin/bash

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

echo_info "Installing gh (GitHub CLI)..."
brew install gh

echo_done "gh configuration!"
