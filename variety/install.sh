#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring variety..."
echo_info "Installing variety..."
sudo apt install variety

echo_info "Installing wallpapers..."
git clone https://github.com/iampika/wallpapers ${HOME}/.wallpapers

echo_info "copy variety..."
sudo cp -a variety  ${HOME}/.config

echo_done "Variety configuration!"
