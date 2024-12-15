#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Installing yarn..."
yes | brew install yarn

echo_done "yarn configuration!"
