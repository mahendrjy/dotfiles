#!/bin/bash

source "$(dirname "$0")/../helpers.sh"

echo_info "Uninstalling git config..."

[ -L "$HOME/.gitconfig"        ] && rm "$HOME/.gitconfig"        && echo_done "Removed ~/.gitconfig symlink"
[ -L "$HOME/.gitignore_global" ] && rm "$HOME/.gitignore_global" && echo_done "Removed ~/.gitignore_global symlink"

git config --global --unset core.excludesfile 2>/dev/null || true
git config --global --unset core.pager        2>/dev/null || true
