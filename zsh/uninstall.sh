#!/bin/bash

source "$(dirname "$0")/../helpers.sh"

echo_info "Uninstalling ZSH config..."

[ -L "$HOME/.zshrc" ] && rm "$HOME/.zshrc" && echo_done "Removed ~/.zshrc symlink"

echo_info "To fully remove oh-my-zsh: uninstall_oh_my_zsh"
echo_info "To fully remove zgen: rm -rf ~/.zgen"
