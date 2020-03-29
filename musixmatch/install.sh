#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring musixmatch..."
echo_info "Installing musixmatch..."
sudo snap install musixmatch

echo_done "Musixmatch configuration!"
