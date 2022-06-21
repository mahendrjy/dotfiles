#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Regolith..."
mkdir -p ${HOME}/.config/regolith2/i3/config.d

echo_info "Symlink config..."
ln -sfT "$HOME/dotfiles/regolith2/i3/config.d/15_base_launchers" "$HOME/.config/regolith2/i3/config.d/15_base_launchers"

echo_info "Deleting default config version"
sudo apt remove regolith-i3-base-launchers # removes the default version

echo_done "Regolith configuration!"


