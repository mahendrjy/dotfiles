#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring bash..."
_install bash

echo_info "Installing bash..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

echo_info "Symlink .bashrc..."
ln -sfT "$HOME/dotfiles/bash/bashrc" "$HOME/.bashrc"

echo_done "bash configuration!"
