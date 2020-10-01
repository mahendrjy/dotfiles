#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring no-internet..."

echo_info "Installing no-internet..."
sudo addgroup no-internet
sudo iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP
# Execute sudo -g no-internet YOURCOMMAND instead of YOURCOMMAND

echo_done "no-internet configuration!"
