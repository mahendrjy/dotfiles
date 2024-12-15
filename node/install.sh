#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring Node..."

echo_info "Installing nvm..."
brew install nvm

# Create nvm directory
mkdir -p ~/.nvm

# Add nvm config to ~/.zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"' >> ~/.zshrc
echo '[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"' >> ~/.zshrc

# Source nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

echo_info "Installing Node.js..."
nvm install node
nvm use node

# Install global npm packages
npm i -g add-gitignore
npm i -g lite-server
npm i -g pageres
npm i -g surge
npm i -g imgur-uploader-cli
npm i -g share-cli
npm i -g prettier
npm i -g eslint
# npm i -g brightness-cli

echo_done "Node configuration!"
