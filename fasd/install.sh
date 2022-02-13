#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Fasd..."
echo_info "Installing fasd..."
yes | sudo add-apt-repository ppa:aacebedo/fasd
yes | sudo apt-get update
yes | sudo apt install fasd

echo_done "Fasd configuration!"
