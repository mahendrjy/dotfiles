#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring fonts..."
_install code

echo_info "Installing fonts..."
sudo apt-get install fonts-emojione

echo_done "fonts configuration!"
