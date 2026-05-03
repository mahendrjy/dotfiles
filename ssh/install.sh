#!/bin/bash

email="pikaatic@gmail.com"

source "$(dirname "$0")/../distro.sh"
source "$(dirname "$0")/../helpers.sh"

SSH_DIR="$(dirname "$0")"

echo_info "Configuring SSH..."
mkdir -p "${HOME}/.ssh"
chmod 700 "${HOME}/.ssh"

# Generate key only if it doesn't already exist
if [[ ! -f "${HOME}/.ssh/id_github" ]]; then
  echo_info "Generating SSH key..."
  ssh-keygen -t ed25519 -C "$email" -f "${HOME}/.ssh/id_github" -N ""
fi

# Add to keychain so you never need to enter a passphrase
eval "$(ssh-agent -s)" &>/dev/null
ssh-add --apple-use-keychain "${HOME}/.ssh/id_github" 2>/dev/null \
  || ssh-add "${HOME}/.ssh/id_github"

echo_info "Symlinking SSH config and gitconfig..."
ln -sf "$SSH_DIR/config"    "${HOME}/.ssh/config"
ln -sf "$SSH_DIR/gitconfig" "${HOME}/.gitconfig"

chmod 600 "${HOME}/.ssh/config"

echo_done "SSH configured!"

# ─────────────────────────────────────────────────────────────────────────────
printf '\n'
printf '╔══════════════════════════════════════════════════════════╗\n'
printf '║        FINAL STEP: Add your SSH key to GitHub           ║\n'
printf '╚══════════════════════════════════════════════════════════╝\n'
printf '\n'
printf 'Your public key (copy everything below):\n\n'
printf '  \033[33m%s\033[0m\n' "$(cat "${HOME}/.ssh/id_github.pub")"
printf '\n'
printf 'Steps:\n'
printf '  1. Go to \033[36mhttps://github.com/settings/ssh/new\033[0m\n'
printf '  2. Title: MacBook\n'
printf '  3. Paste the key above → click "Add SSH key"\n'
printf '\n'
printf 'Test it works:\n'
printf '  \033[36mssh -T git@github.com\033[0m\n'
printf '  (should say: Hi mahendrjy! You have successfully authenticated)\n'
printf '\n'
printf 'Then clone repos normally:\n'
printf '  \033[36mgit clone git@github.com:yourusername/repo.git\033[0m\n'
printf '\n'
