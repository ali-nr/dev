#!/usr/bin/env bash

set -eu

echo "🖥️  Setting up Slack..."

# Install Slack
if ! brew list --cask slack &>/dev/null; then
    echo "📦 Installing Slack..."
    brew install --cask slack
else
    echo "✅ Slack already installed"
fi

# Create configs directory structure if needed
# CONFIG_DIR="$PWD/configs/slack"
# SLACK_CONFIG_DIR="$HOME/Library/Application Support/Slack"

# If we wanted to add custom configurations for Slack, we would do it here
# Currently, Slack doesn't typically need command-line configuration
# But the structure is here if needed in the future

echo "✅ Slack setup complete!"
