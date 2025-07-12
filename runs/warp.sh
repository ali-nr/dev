#!/usr/bin/env bash

set -eu

echo "🖥️  Setting up Warp terminal..."

# Install Warp
if ! brew list --cask warp &>/dev/null; then
    echo "📦 Installing Warp..."
    brew install --cask warp
else
    echo "✅ Warp already installed"
fi

# Configure Warp with our settings
CONFIG_DIR="$PWD/configs/warp"
WARP_CONFIG_DIR="$HOME/.warp"
WARP_THEMES_DIR="$WARP_CONFIG_DIR/themes"

if [[ -d "$CONFIG_DIR" ]]; then
    echo "📄 Configuring Warp..."

    # Create Warp configuration directories
    mkdir -p "$WARP_THEMES_DIR"

    # Copy theme file
    if [[ -f "$CONFIG_DIR/snazzy.yaml" ]]; then
        echo "🎨 Installing Snazzy theme..."
        cp "$CONFIG_DIR/snazzy.yaml" "$WARP_THEMES_DIR/"
    fi

    # Copy settings file
    if [[ -f "$CONFIG_DIR/settings.yaml" ]]; then
        echo "⚙️ Installing Warp settings..."
        cp "$CONFIG_DIR/settings.yaml" "$WARP_CONFIG_DIR/"
    fi
fi

echo "✅ Warp terminal setup complete!"
