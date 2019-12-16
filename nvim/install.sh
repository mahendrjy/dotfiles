#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Nvim..."
_install nvim

mkdir -p ${HOME}/.config/nvim

echo_info "Symlink init.vim..."
ln -sfT "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim/init.vim"

echo_done "Nvim configuration!"
