#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Xresources.d..."
_install Xresources.d

mkdir -p ${HOME}/.Xresources.d

echo_info "Symlink color-palenight..."
ln -sfT "${HOME}/dotfiles/.Xresources.d/color-palenight" "${HOME}/.Xresources.d/color-palenight"

echo_done "Xresources.d configuration!"
