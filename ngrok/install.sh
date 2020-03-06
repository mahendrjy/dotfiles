#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring ngrok..."
_install ngrok

echo_info "Installing ngrok..."
sudo snap install ngrok

echo_done "ngrok configuration!"
