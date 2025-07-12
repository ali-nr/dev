#!/usr/bin/env bash

set -eu

echo "🎵 Setting up Spotify..."

# Install Spotify
if ! brew list --cask spotify &>/dev/null; then
    echo "📦 Installing Spotify..."
    brew install --cask spotify
else
    echo "✅ Spotify already installed"
fi

# Create configs directory structure if needed
# CONFIG_DIR="$PWD/configs/spotify"
# SPOTIFY_CONFIG_DIR="$HOME/Library/Application Support/Spotify"

# If we wanted to add custom configurations for Spotify, we would do it here
# Currently, Spotify doesn't typically need command-line configuration
# But the structure is here if needed in the future

echo "✅ Spotify setup complete!"
