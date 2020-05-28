#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring fonts..."
echo_info "Installing fonts..."
mkdir -p ${HOME}/.local/share/fonts

echo_info "Installing Operator Mono font..."
sudo cp -a Operator\ Mono/. ${HOME}/.local/share/fonts
sudo cp -a Operator\ Mono\ Lig/. ${HOME}/.local/share/fonts
sudo cp -a Dank\ Mono/. ${HOME}/.local/share/fonts

sudo fc-cache -f -v

sudo apt-get install fonts-emojione

echo_done "fonts configuration!"
