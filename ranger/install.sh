#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Installing Ranger..."
sudo apt install ranger

echo_info "Configuring Ranger..."
echo_info "Symlink rc.conf..."
ln -sfT "${HOME}/dotfiles/ranger/rc.conf" "${HOME}/.config/ranger/rc.conf"

echo_info "Symlink scope.sh..."
ln -sfT "${HOME}/dotfiles/ranger/scope.sh" "${HOME}/.config/ranger/scope.sh"

echo_info "Symlink commands.py..."
ln -sfT "${HOME}/dotfiles/ranger/commands.py" "${HOME}/.config/ranger/commands.py"

echo_done "Ranger configuration!"
