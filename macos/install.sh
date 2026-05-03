#!/bin/bash

source "$(dirname "$0")/../helpers.sh"

echo_info "Applying macOS defaults..."

# Close System Preferences to prevent overriding settings
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

###############################################################################
# Keyboard & Input
###############################################################################

# Disable press-and-hold for keys (enables key repeat in all apps, e.g. vim)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fastest key repeat rate and shortest delay
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Disable auto-correct, smart quotes and dashes (they break code)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###############################################################################
# Finder
###############################################################################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show status bar and path bar
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Avoid creating .DS_Store files on network and USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

###############################################################################
# Dock
###############################################################################

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hide delay
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Don't show recent apps in Dock
defaults write com.apple.dock show-recents -bool false

# Restore default icon size (48)
defaults write com.apple.dock tilesize -int 48

###############################################################################
# Screenshots
###############################################################################

# Save screenshots to ~/Desktop/Screenshots
mkdir -p "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"

# Save screenshots as PNG
defaults write com.apple.screencapture type -string "png"

# Disable screenshot shadow
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Save / Print dialogs
###############################################################################

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

###############################################################################
# Activity Monitor
###############################################################################

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Dock — configure via dockutil if installed
###############################################################################

if command -v dockutil &>/dev/null; then
  echo_info "Configuring Dock apps..."

  dockutil --remove all --no-restart

  dockutil --add /Applications/Safari.app               --no-restart
  dockutil --add /Applications/Google\ Chrome.app       --no-restart 2>/dev/null || true
  dockutil --add /Applications/Visual\ Studio\ Code.app --no-restart 2>/dev/null || true
  dockutil --add '~/Downloads' --view fan --display stack --no-restart
fi

###############################################################################
# Restart affected apps
###############################################################################

for app in "Finder" "Dock" "SystemUIServer"; do
  killall "$app" &>/dev/null || true
done

echo_done "macOS defaults applied! Some changes require a logout/restart to take effect."
