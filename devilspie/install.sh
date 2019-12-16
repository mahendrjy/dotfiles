#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Devilspie..."
_install devilspie

mkdir -p ${HOME}/.devilspie

echo_info "Symlink firefox_transparent.ds.."
ln -sfT "${HOME}/dotfiles/.devilspie/firefox_transparent.ds" "${HOME}/.devilspie/firefox_transparent.ds"

echo_info "Symlink kitty_transparent.ds.."
ln -sfT "${HOME}/dotfiles/.devilspie/kitty_transparent.ds" "${HOME}/.devilspie/kitty_transparent.ds"

echo_info "Symlink transmission_transparent.ds.."
ln -sfT "${HOME}/dotfiles/.devilspie/transmission_transparent.ds" "${HOME}/.devilspie/transmission_transparent.ds"

echo_info "Symlink vscode_transparent.ds.."
ln -sfT "${HOME}/dotfiles/.devilspie/vscode_transparent.ds" "${HOME}/.devilspie/vscode_transparent.ds"

echo_done "Devilspie configuration!"
