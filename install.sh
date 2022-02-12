#!/bin/bash

sudo -v

# Keep-alive: update existing `sudo` time stamp until `install` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "Hello $(whoami)! Let's get you set up."

. distro.sh
. packages.sh
. helpers.sh

# Install packages in the official repositories
# echo_info "Installing core packages..."
_install core

# _update system

_symlink
