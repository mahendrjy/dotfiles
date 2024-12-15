#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Fasd..."
echo_info "Installing fasd..."
yes | brew install fasd

echo_done "Fasd configuration!"
