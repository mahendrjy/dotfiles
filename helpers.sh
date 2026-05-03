#!/bin/bash

function echo_error() {
  printf '\n\033[31mERROR:\033[0m %s\n' "$1"
}

function echo_warning() {
  printf '\n\033[33mWARNING:\033[0m %s\n' "$1"
}

function echo_done() {
  printf '\n\033[32mDONE:\033[0m %s\n' "$1"
}

function echo_info() {
  printf '\n\033[36m%s\033[0m\n' "$1"
}

function _update() {
  if [[ $1 == "system" ]]; then
    echo_info "Updating system packages..."
    "$PKGMN" "$PKGU"
  else
    echo_info "Updating ${1}..."
    "$PKGMN" "$PKGI" "$1"
  fi
}

function _install() {
  if [[ $1 == "core" ]]; then
    for pkg in "${PKG[@]}"; do
      echo_info "Installing ${pkg}..."
      "$PKGMN" "$PKGI" "$pkg" || echo_warning "Failed to install ${pkg}, skipping..."
      echo_done "${pkg} installed!"
    done
  else
    echo_info "Installing ${1}..."
    "$PKGMN" "$PKGI" "$1"
  fi
}

# Run install.sh for every subdirectory, optionally skipping named dirs.
# Usage: _symlink_except dir1 dir2 ...
function _symlink_except() {
  local skip=("$@")
  local dotfiles_dir
  dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local dirs
  dirs=$(find "$dotfiles_dir" -maxdepth 1 -mindepth 1 -type d -not -name '.git' -print | sort)

  for dir in $dirs; do
    local dirname
    dirname="$(basename "$dir")"

    local should_skip=false
    for s in "${skip[@]}"; do
      [[ "$dirname" == "$s" ]] && should_skip=true && break
    done
    [[ "$should_skip" == true ]] && continue

    if [[ -f "$dir/install.sh" ]]; then
      echo_info "Installing ${dirname}..."
      bash "$dir/install.sh"
    fi
  done
}
