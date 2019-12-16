#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring vscode..."
_install code

echo_info "Installing vscode..."
sudo snap install --classic code

echo_done "Vscode configuration!"
