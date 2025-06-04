#!/usr/bin/env bash

set -eu

echo "🖥️  Setting up iTerm2 with Material Design theme..."

CONFIG_DIR="$DEV_ENV/configs/iterm"

# Install iTerm2
if ! brew list --cask iterm2 &>/dev/null; then
    echo "📦 Installing iTerm2..."
    brew install --cask iterm2
else
    echo "✅ iTerm2 already installed"
fi

# Install Material Design theme (if itermcolors file exists)
THEME_FILE="$CONFIG_DIR/material-design-colors.itermcolors"
if [[ -f "$THEME_FILE" ]]; then
    echo "🎨 Installing Material Design theme..."
    osascript <<EOF
tell application "iTerm"
    open POSIX file "$THEME_FILE"
end tell
EOF
    echo "🎨 Theme file opened — select it in: Preferences → Profiles → Colors → Color Presets"
else
    echo "ℹ️  No theme file found at $THEME_FILE — skipping theme install"
fi

# Load saved preferences if you have a plist
PLIST_FILE="$CONFIG_DIR/com.googlecode.iterm2.plist"
if [[ -f "$PLIST_FILE" ]]; then
    echo "📄 Setting iTerm2 to load preferences from $CONFIG_DIR"
    cp "$PLIST_FILE" ~/Library/Preferences/
    defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$CONFIG_DIR"
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
    echo "⚠️  Restart iTerm2 for preferences to take effect"
else
    echo "ℹ️  No plist found — skipping preference syncing"
fi

echo "✅ iTerm2 setup complete!"
