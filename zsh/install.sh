#!/bin/bash

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

echo_info "Installing ZSH with OH-MY-ZSH..."

# Install oh-my-zsh non-interactively if not already installed
if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  echo_info "Installing oh-my-zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install zgen if not already installed
if [[ ! -d "${HOME}/.zgen" ]]; then
  echo_info "Installing zgen plugin manager..."
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

echo_info "Symlinking .zshrc..."
ln -sf "${HOME}/dotfiles/zsh/zshrc" "${HOME}/.zshrc"

# Change default shell to zsh if needed
if [[ "$SHELL" != "$(which zsh)" ]]; then
  echo_info "Changing default shell to zsh..."
  sudo chsh -s "$(which zsh)" "$(whoami)"
fi

echo_done "ZSH configuration!"
