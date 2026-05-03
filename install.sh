#!/bin/bash

set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo -v

# Keep sudo alive throughout the install
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "Hello $(whoami)! Let's get you set up."

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add Homebrew to PATH for this session (handles both Apple Silicon and Intel)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

cd "$DOTFILES"

source ./helpers.sh

# Install everything from the Brewfile (formulas + casks + Mac App Store apps)
echo_info "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile" --verbose

# Run all module config scripts in explicit order — ssh is intentionally last
echo_info "Running module config scripts..."
_symlink_except ssh macos

echo_info "Applying macOS defaults..."
bash "$DOTFILES/macos/install.sh"

# Change default shell to zsh if needed
if [[ "$SHELL" != "$(which zsh)" ]]; then
  echo_info "Changing default shell to zsh..."
  sudo chsh -s "$(which zsh)" "$(whoami)"
fi

mkdir -p "$HOME/code"

# SSH is last — keys are generated here and you'll need to add them to GitHub
bash "$DOTFILES/ssh/install.sh"
