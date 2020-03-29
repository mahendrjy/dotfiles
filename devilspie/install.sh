#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Installing Devilspie..."
sudo apt install devilspie

echo_info "Configuring Devilspie..."
mkdir -p ${HOME}/.devilspie

echo_info "Symlink kitty_transparent.ds.."
ln -sfT "${HOME}/dotfiles/devilspie/kitty_transparent.ds" "${HOME}/.devilspie/kitty_transparent.ds"

echo_info "Symlink transmission_transparent.ds.."
ln -sfT "${HOME}/dotfiles/devilspie/transmission_transparent.ds" "${HOME}/.devilspie/transmission_transparent.ds"

echo_info "Symlink vscode_transparent.ds.."
ln -sfT "${HOME}/dotfiles/devilspie/vscode_transparent.ds" "${HOME}/.devilspie/vscode_transparent.ds"

echo_info "Symlink insomnia_transparent.ds.."
ln -sfT "${HOME}/dotfiles/devilspie/insomnia_transparent.ds" "${HOME}/.devilspie/insomnia_transparent.ds"

echo_done "Devilspie configuration!"
