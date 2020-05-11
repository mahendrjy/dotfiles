#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring homebrew..."
echo_info "Installing homebrew pkgs..."

sudo apt-get install build-essential curl file git
git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
mkdir ~/.linuxbrew/bin
ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)

PKGS=(
  yarn
  exa
  nvm
)


for pkg in "${PKGS[@]}"; do
  echo_info "Installing ${pkg}..."
  if ! [ -x "$(command -v rainbow)" ]; then
    brew install "$pkg"
  else
    rainbow --red=error --yellow=warning brew install "$pkg"
  fi
  echo_done "${pkg} installed!"
done

echo_done "homebrew configuration!"
