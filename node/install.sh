#!/bin/bash

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

echo_info "Configuring Node..."

echo_info "Installing nvm..."
brew install nvm

mkdir -p ~/.nvm

# Source nvm for this session (Apple Silicon path first, then fallback)
export NVM_DIR="$HOME/.nvm"
NVM_SH="/opt/homebrew/opt/nvm/nvm.sh"
[[ -s "$NVM_SH" ]] || NVM_SH="$NVM_DIR/nvm.sh"
[[ -s "$NVM_SH" ]] && source "$NVM_SH"

echo_info "Installing Node.js LTS..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

# Install global npm packages
npm i -g add-gitignore
npm i -g prettier
npm i -g eslint

echo_done "Node configuration!"
