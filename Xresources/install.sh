#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Xresources..."
_install Xresources

echo_info "Symlink kitty.conf..."
ln -sfT "${HOME}/dotfiles/.Xresources" "${HOME}/.Xresources"

echo_done "Xresources configuration!"
