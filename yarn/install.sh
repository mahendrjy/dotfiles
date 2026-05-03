#!/bin/bash

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

echo_info "Installing yarn..."
brew install yarn

echo_done "Yarn configuration!"
