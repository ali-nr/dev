#!/usr/bin/env bash

set -eu

echo "☁️ Setting up Google Drive..."

# Install Google Drive
if ! brew list --cask google-drive &>/dev/null; then
    echo "📦 Installing Google Drive..."
    brew install --cask google-drive
else
    echo "✅ Google Drive already installed"
fi

# Create configs directory structure if needed
# CONFIG_DIR="$PWD/configs/google-drive"
# DRIVE_CONFIG_DIR="$HOME/Library/Application Support/Google/DriveFS"

# If we wanted to add custom configurations for Google Drive, we would do it here
# Currently, Google Drive doesn't typically need command-line configuration
# But the structure is here if needed in the future

echo "✅ Google Drive setup complete!"
