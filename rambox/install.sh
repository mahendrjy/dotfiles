#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring rambox..."
_install rambox

echo_info "Installing rambox..."
sudo snap install rambox

echo_done "Rambox configuration!"
