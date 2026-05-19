<!--
  Sync Impact Report

  Version change: N/A → 1.0.0
  Modified principles: N/A (initial creation from template)
  Added sections:
    - I. Idempotent Setup
    - II. Modular Architecture
    - III. macOS-First
    - IV. Declarative Package Management
    - V. Security-Conscious
    - Tech Stack & Constraints
    - Development Workflow
    - Governance (amendment procedure, versioning policy, compliance review)
  Removed sections: N/A
  Templates requiring updates:
    - ✅ .specify/templates/plan-template.md (constitution check section is generic — no changes needed)
    - ✅ .specify/templates/spec-template.md (scope/requirements alignment unchanged)
    - ✅ .specify/templates/tasks-template.md (task categorization unchanged)
    - ✅ .specify/templates/checklist-template.md (generic — no changes needed)
    - ✅ .specify/extensions/git/commands/*.md (no outdated references)
  Follow-up TODOs: None
-->

# dotfiles Constitution

## Core Principles

### I. Idempotent Setup
Every install script MUST be safe to run multiple times (idempotent). Running
`./install.sh` or any `make install-*` target repeatedly MUST produce the same
result without side effects. Symlinks, file copies, and package installs MUST
check for existing state before acting. **Rationale**: Dotfiles are applied
repeatedly across machines and after updates — non-idempotent scripts cause
duplicate entries, broken symlinks, or data loss.

### II. Modular Architecture
Each tool or environment (zsh, git, tmux, node, macos, ssh, etc.) lives in its
own self-contained module directory. Every module MUST have an `install.sh` (and
optionally an `uninstall.sh`). Modules MUST NOT depend on each other's internal
state — only on shared helpers (`helpers.sh`, `distro.sh`). **Rationale**:
Granular modules enable targeted install/uninstall and make the codebase
approachable for contributors.

### III. macOS-First
All configuration and automation targets macOS. Scripts MAY assume macOS-
specific tooling (Homebrew, `defaults`, `plist`, etc.). Cross-platform features
SHOULD be gated behind `distro.sh` checks and MUST NOT break macOS behavior.
**Rationale**: The repo's primary purpose is macOS environment management;
guarding cross-platform paths avoids brittle conditionals in every script.

### IV. Declarative Package Management
The `Brewfile` is the single source of truth for all CLI tools, GUI applications,
and Mac App Store apps. Manual `brew install` outside the Brewfile is forbidden
— changes MUST go through the Brewfile and be applied via `make update`.
**Rationale**: A declarative manifest ensures reproducible environments across
machines and simplifies updates.

### V. Security-Conscious
SSH keys, Git credentials, and any secrets MUST NOT be stored in the repository.
The SSH module generates keys interactively and prints setup instructions — it
MUST NOT automate key generation without user confirmation. `.gitignore` MUST
exclude any files that could contain secrets. **Rationale**: A dotfiles repo
is often public (or shared); accidental secret commits are irreversible without
significant rotation effort.

## Tech Stack & Constraints

- **OS**: macOS (primary target; scripts assume macOS unless gated)
- **Shell**: zsh + oh-my-zsh (managed via zgen)
- **Package Manager**: Homebrew (Brewfile)
- **Build System**: GNU Make (Makefile targets)
- **Dotfiles Manager**: Mackup (app settings via iCloud)
- **Terminal Multiplexer**: tmux + TPM
- **Diff Tool**: delta
- **Shell History**: atuin (zoxide for directory navigation)
- **File Manager**: ranger (lf as alternative supported)
- **Editor**: VS Code (extensions managed via `code/` module)
- **Font**: JetBrains Mono Nerd Font
- **Git Hosting**: GitHub (personal + work accounts via SSH multi-account
  configuration in `ssh/gitconfig`)

## Development Workflow

### Make Targets
- `make list` – List all available modules
- `make install-<module>` – Install a single module
- `make uninstall-<module>` – Uninstall a single module
- `make update` – Pull latest dotfiles + update all packages
- `make uninstall` – Remove all symlinks and Homebrew packages

### Symlink Management
All symlinks are created by module install scripts using `ln -sf`. The target
path MUST be `$HOME/.<filename>` or `$HOME/.config/<app>/<filename>`. Source
paths MUST be relative to the module directory.

### Change Process
1. Edit the relevant module files (config, scripts, Brewfile)
2. Run `make install-<module>` to apply changes
3. Verify the change works as expected
4. Commit the module changes to the repository

## Governance

This constitution defines the non-negotiable rules for managing this dotfiles
repository. It supersedes ad-hoc practices.

### Amendment Procedure
1. Propose the change (amend this document)
2. Update version according to semantic versioning rules (see below)
3. Propagate changes to any affected templates, modules, or documentation
4. Commit with a message describing the governance change

### Versioning Policy
- **MAJOR** (X.0.0): Backward-incompatible principle removals or redefinitions
- **MINOR** (0.X.0): New principles, sections, or materially expanded guidance
- **PATCH** (0.0.X): Clarifications, wording fixes, non-semantic refinements

### Compliance Review
- Every `install.sh` or module change SHOULD be reviewed against these
  principles
- New modules MUST satisfy Modular Architecture (II) and Idempotent Setup (I)
- Brewfile changes MUST satisfy Declarative Package Management (IV)
- SSH and credential-related changes MUST satisfy Security-Conscious (V)

**Version**: 1.0.0 | **Ratified**: 2026-05-19 | **Last Amended**: 2026-05-19
