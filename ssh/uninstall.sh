#!/bin/bash

source "$(dirname "$0")/../helpers.sh"

echo_info "Uninstalling SSH config..."

[ -L "${HOME}/.ssh/config"   ] && rm "${HOME}/.ssh/config"   && echo_done "Removed ~/.ssh/config symlink"
[ -L "${HOME}/.gitconfig"    ] && rm "${HOME}/.gitconfig"    && echo_done "Removed ~/.gitconfig symlink"

echo_warning "SSH key at ~/.ssh/id_github was NOT deleted."
echo_info "Delete manually if you want: rm ~/.ssh/id_github ~/.ssh/id_github.pub"
