# dotfiles

My personal macOS dotfiles. Clone this repo, run one command, and a new Mac is fully configured.

## What's included

| Module | What it does |
|--------|-------------|
| `zsh/` | zsh + oh-my-zsh + zgen plugins, aliases, functions |
| `git/` | git config, delta diffs, lazygit, global gitignore |
| `ssh/` | SSH key generation, GitHub multi-account config |
| `tmux/` | tmux config + TPM plugins |
| `node/` | nvm + Node LTS + global npm packages |
| `macos/` | Sensible macOS defaults (key repeat, Finder, Dock) |
| `code/` | VS Code extensions |
| `fonts/` | JetBrains Mono Nerd Font |
| `ranger/` | Ranger file manager config |
| `mackup/` | App settings backup/restore via iCloud |
| `Brewfile` | All packages, casks (GUI apps), and Mac App Store apps |

---

## Install everything (fresh Mac)

```bash
git clone https://github.com/mahendrjy/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

That's it. The script will:
1. Install Homebrew
2. Install all packages, apps and fonts from `Brewfile`
3. Symlink configs for zsh, git, tmux, ranger, etc.
4. Apply macOS defaults
5. Generate SSH keys and print instructions for adding them to GitHub

> After it finishes, restart your terminal or run `exec zsh`.

---

## Uninstall everything

```bash
make uninstall
```

This removes all symlinks and uninstalls Homebrew packages listed in the Brewfile. Your SSH keys and personal files are left untouched.

---

## Update

```bash
make update
```

Pulls the latest dotfiles, updates all Homebrew packages, and updates oh-my-zsh.

---

## Install or uninstall a single module

```bash
# See all available modules
make list

# Install just one module
make install-zsh
make install-git
make install-tmux
make install-node
make install-ssh
make install-macos
make install-fonts
make install-code

# Uninstall just one module
make uninstall-zsh
make uninstall-git
make uninstall-tmux
make uninstall-ssh
```

---

## Customize packages

Edit `Brewfile` to add or remove packages, GUI apps, or Mac App Store apps:

```ruby
# Add a CLI tool
brew "htop"

# Add a GUI app
cask "spotify"

# Add a Mac App Store app (find the ID with: mas search <name>)
mas "Bear", id: 1091189122
```

Then run `make update` to apply changes.

---

## Add a new module

1. Create a folder: `mkdir mymodule`
2. Add an install script: `mymodule/install.sh`
3. Optionally add an uninstall script: `mymodule/uninstall.sh`

The main `install.sh` and `make install-mymodule` will automatically pick it up.

**Minimal `install.sh` template:**

```bash
#!/bin/bash

source "$(dirname "$0")/../helpers.sh"

echo_info "Configuring mymodule..."

# your setup here
ln -sf "$(dirname "$0")/config" "$HOME/.mymodule"

echo_done "mymodule configured!"
```

---

## SSH + GitHub setup

After `./install.sh` finishes, it prints your public keys and exact steps to add them to GitHub. The short version:

1. Copy the personal public key → [github.com/settings/ssh/new](https://github.com/settings/ssh/new)
2. Copy the work public key → your work GitHub account's SSH settings
3. Test with:
   ```bash
   ssh -T git@github.com-pika   # personal
   ssh -T git@github.com-work   # work
   ```
4. Clone personal repos with `git@github.com-pika:username/repo.git`
5. Clone work repos with `git@github.com-work:org/repo.git`

---

## App settings backup (mackup)

[mackup](https://github.com/lra/mackup) syncs app settings to iCloud so restoring a new Mac is instant.

```bash
# Back up settings to iCloud
mackup backup

# Restore settings on a new Mac (run after ./install.sh)
mackup restore
```

Edit `mackup/mackup.cfg` to control which apps are synced.

---

## Structure

```
dotfiles/
├── install.sh          # main entry point
├── Brewfile            # all packages, casks, and App Store apps
├── Makefile            # install / uninstall / update commands
├── helpers.sh          # shared helper functions
├── distro.sh           # package manager config
├── git/
│   ├── install.sh
│   ├── uninstall.sh
│   ├── gitconfig       # symlinked to ~/.gitconfig
│   └── gitignore_global
├── zsh/
│   ├── install.sh
│   ├── uninstall.sh
│   ├── zshrc           # symlinked to ~/.zshrc
│   ├── aliases.zsh
│   ├── functions.zsh
│   └── plugins.zsh
├── tmux/
│   ├── install.sh
│   ├── uninstall.sh
│   └── tmux.conf       # symlinked to ~/.tmux.conf
├── ssh/
│   ├── install.sh
│   ├── uninstall.sh
│   ├── config          # symlinked to ~/.ssh/config
│   └── gitconfig
├── macos/
│   └── install.sh      # macOS defaults + Dock config
├── mackup/
│   ├── install.sh
│   └── mackup.cfg      # symlinked to ~/.mackup.cfg
├── code/
│   ├── install.sh
│   └── extensions.json
├── node/
│   └── install.sh
├── fonts/
│   └── install.sh
└── ranger/
    ├── install.sh
    ├── rc.conf
    ├── scope.sh
    └── commands.py
```
