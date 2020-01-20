#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring stacer..."
_install stacer

echo_info "Installing stacer..."
sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt-get update
sudo apt-get install stacer

echo_done "Stacer configuration!"
