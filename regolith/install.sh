#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Regolith..."
mkdir -p ${HOME}/.config/regolith/i3

echo_info "Symlink config..."
ln -sfT "$HOME/dotfiles/regolith/i3/config" "$HOME/.config/regolith/i3/config"

echo_done "Regolith configuration!"
