DOTFILES := $(shell pwd)
MODULES   := $(shell find . -maxdepth 2 -name "install.sh" ! -path "./install.sh" | sed 's|./||;s|/install.sh||' | sort)

.DEFAULT_GOAL := help

# ─────────────────────────────────────────────────────────────────────────────
# Help
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: help
help:
	@echo ""
	@echo "  dotfiles — usage"
	@echo ""
	@echo "  make install              Install everything (full setup)"
	@echo "  make update               Update packages and pull latest changes"
	@echo "  make uninstall            Remove all symlinks and uninstall packages"
	@echo ""
	@echo "  make install-<module>     Install a single module  e.g. make install-zsh"
	@echo "  make uninstall-<module>   Uninstall a single module"
	@echo ""
	@echo "  Available modules:"
	@for m in $(MODULES); do echo "    $$m"; done
	@echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Full install / uninstall / update
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: install
install:
	@bash $(DOTFILES)/install.sh

.PHONY: update
update:
	@echo "Pulling latest dotfiles..."
	@git pull --rebase
	@echo "Updating Homebrew packages..."
	@brew bundle --file="$(DOTFILES)/Brewfile" --verbose
	@echo "Updating oh-my-zsh..."
	@zsh -ic "omz update" 2>/dev/null || true
	@echo "Done! Reload your shell: exec zsh"

.PHONY: uninstall
uninstall:
	@echo "Removing all dotfile symlinks..."
	@[ -L "$(HOME)/.zshrc"            ] && rm "$(HOME)/.zshrc"            || true
	@[ -L "$(HOME)/.gitconfig"        ] && rm "$(HOME)/.gitconfig"        || true
	@[ -L "$(HOME)/.gitignore_global" ] && rm "$(HOME)/.gitignore_global" || true
	@[ -L "$(HOME)/.tmux.conf"        ] && rm "$(HOME)/.tmux.conf"        || true
	@[ -L "$(HOME)/.mackup.cfg"       ] && rm "$(HOME)/.mackup.cfg"       || true
	@[ -L "$(HOME)/.ssh/config"       ] && rm "$(HOME)/.ssh/config"       || true
	@[ -L "$(HOME)/.config/ranger/rc.conf"     ] && rm "$(HOME)/.config/ranger/rc.conf"     || true
	@[ -L "$(HOME)/.config/ranger/scope.sh"    ] && rm "$(HOME)/.config/ranger/scope.sh"    || true
	@[ -L "$(HOME)/.config/ranger/commands.py" ] && rm "$(HOME)/.config/ranger/commands.py" || true
	@echo "Uninstalling Homebrew packages..."
	@brew bundle cleanup --file="$(DOTFILES)/Brewfile" --force || true
	@echo "Done. Your shell is now unconfigured — open a new terminal."

# ─────────────────────────────────────────────────────────────────────────────
# Per-module install  (make install-zsh, make install-git, ...)
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: $(addprefix install-,$(MODULES))
$(addprefix install-,$(MODULES)): install-%:
	@if [ -f "$(DOTFILES)/$*/install.sh" ]; then \
		echo "Installing module: $*"; \
		bash "$(DOTFILES)/$*/install.sh"; \
	else \
		echo "No install.sh found for module: $*"; \
	fi

# ─────────────────────────────────────────────────────────────────────────────
# Per-module uninstall (make uninstall-zsh, make uninstall-git, ...)
# Each module can provide an uninstall.sh; otherwise prints a message.
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: $(addprefix uninstall-,$(MODULES))
$(addprefix uninstall-,$(MODULES)): uninstall-%:
	@if [ -f "$(DOTFILES)/$*/uninstall.sh" ]; then \
		echo "Uninstalling module: $*"; \
		bash "$(DOTFILES)/$*/uninstall.sh"; \
	else \
		echo "No uninstall.sh for $* — manually remove its symlinks if needed."; \
	fi

# ─────────────────────────────────────────────────────────────────────────────
# Convenience
# ─────────────────────────────────────────────────────────────────────────────
.PHONY: list
list:
	@echo "Available modules:"
	@for m in $(MODULES); do echo "  $$m"; done
