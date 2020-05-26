#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring exa..."

echo_info "Installing cargo..."
sudo apt install cargo

echo_info "Installing exa..."
cargo install exa

echo_done "exa configuration!"
