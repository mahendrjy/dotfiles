#!/bin/bash

email="pikaatic@gmail.com"

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring SSH..."
mkdir -p ${HOME}/.ssh

# How to Setup SSH Keys on GitHub
# https://devconnected.com/how-to-setup-ssh-keys-on-github/
echo_info "Generating an RSA token for GitHub"
ssh-keygen -t rsa -b 4096 -C ${email}
cat ~/.ssh/id_rsa.pub
xclip -sel clip <~/.ssh/id_rsa.pub
echo_info "Add SSH key to your GitHub Account"

echo_info "Symlink config..."
ln -sfT "$HOME/dotfiles/ssh/config" "$HOME/.ssh/config"

echo_done "SSH configuration!"
