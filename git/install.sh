#!/bin/bash

name="Mahendra Choudhary"
email="pikaatic@gmail.com"

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"

echo_info "Configuring GIT..."

brew install git
brew install git-delta
brew install lazygit

# Identity
git config --global user.name "$name"
git config --global user.email "$email"

# Sensible defaults
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global push.autoSetupRemote true
git config --global rebase.autoStash true
git config --global fetch.prune true

# Use delta for beautiful diffs
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.side-by-side false
git config --global delta.line-numbers true

# Useful aliases
git config --global alias.lg "log --oneline --decorate --graph --all"
git config --global alias.st "status -sb"
git config --global alias.undo "reset HEAD~1 --mixed"
git config --global alias.aliases "config --get-regexp alias"

# Global gitignore
ln -sf "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"
git config --global core.excludesfile "$HOME/.gitignore_global"

echo_done "GIT configuration!"
