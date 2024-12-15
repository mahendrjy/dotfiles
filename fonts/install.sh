#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring fonts..."
echo_info "Installing fonts..."
mkdir -p ${HOME}/Library/Fonts

echo_info "Installing Operator Mono font..."
cp -a Operator\ Mono/. ${HOME}/Library/Fonts
cp -a Operator\ Mono\ Lig/. ${HOME}/Library/Fonts
cp -a Dank\ Mono/. ${HOME}/Library/Fonts

# Install emoji fonts via Homebrew
brew install --cask font-erica-one

echo_done "fonts configuration!"
