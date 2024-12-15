#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring gh..."

echo_info "Installing gh..."
brew install gh

echo_done "gh configuration!"
