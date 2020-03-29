#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring postgresql..."
echo_info "Installing postgresql..."
sudo apt-get install postgresql postgresql-contrib

echo_done "postgresql configuration!"
