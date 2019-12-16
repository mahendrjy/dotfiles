#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Kitty..."
_install kitty

mkdir -p ${HOME}/.config/kitty

echo_info "Symlink kitty.conf..."
ln -sfT "$HOME/dotfiles/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

echo_done "Kitty configuration!"
