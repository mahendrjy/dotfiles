#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring homebrew..."
_install homebrew

echo_info "Installing homebrew pkgs..."
PKGS=(
  yarn
  exa
  youtube-dl
  nvm
  docker
  docker-compose
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
