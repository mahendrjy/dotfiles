#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Installing ZSH with OH-MY-ZSH..."
sudo apt install zsh

echo_info "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo_info "Installing A lightweight and simple plugin manager for ZSH"
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

echo_info "Symlink .zshrc..."
ln -sfT "$HOME/dotfiles/zsh/zshrc" "$HOME/.zshrc"

echo_info "Changing shell..."
chsh -s "$(command -v zsh)"

echo_done "ZSH configuration!"
