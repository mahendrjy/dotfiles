#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring fonts..."
echo_info "Installing fonts..."

echo_info "Installing Operator Mono font..."
sudo cp -a Operator\ Mono /usr/share/fonts/opentype

sudo fc-cache -f -v

sudo apt-get install fonts-emojione

echo_done "fonts configuration!"
