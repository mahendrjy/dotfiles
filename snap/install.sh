#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Configuring snap..."
echo_info "Installing snap pkgs..."
sudo apt install snapd

PKGS=(
  breaktimer # Manage periodic breaks. Avoid eye-strain and RSI.
  code --classic # Visual Studio Code. Code editing. Redefined.
  colorpicker-app # A mininal but complete Colorpicker desktop app
  taskbook # Tasks, boards & notes for the command-line habitat.
  insomnia # Insomnia REST Client
  fkill # Fabulously kill processes. Cross-platform.
  mutt # Mutt is a sophisticated text-based Mail User Agent.
  hollywood --classic # fill your console with Hollywood melodrama technobabble.
  heroku --classic # CLI client for Heroku.
  youtube-dl # Download videos from youtube.com or other video platforms.
  gitkraken # For repo management, in-app code editing & issue tracking.
  datagrip --classic # IntelliJ-based IDE for databases and SQL
  docker # Docker container runtime.
  cool-retro-term --classic # cool-retro-term is a terminal emulator.
)

for pkg in "${PKGS[@]}"; do
  echo_info "Installing ${pkg}..."
  if ! [ -x "$(command -v rainbow)" ]; then
    sudo snap install "$pkg"
  else
    rainbow --red=error --yellow=warning snap install "$pkg"
  fi
  echo_done "${pkg} installed!"
done

echo_done "snap configuration!"
