#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Installing ZSH with OH-MY-ZSH..."

echo_info "Installing oh-my-zsh..."
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo_info "Installing A lightweight and simple plugin manager for ZSH"
yes | git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

echo_info "Symlink .zshrc..."
yes | ln -sfT "$HOME/dotfiles/zsh/zshrc" "$HOME/.zshrc"

echo_info "changing shell..."
# chsh -s "$(command -v zsh)"
yes | sudo chsh -s $(which zsh) $(whoami)

echo_done "ZSH configuration!"
