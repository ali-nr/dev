#!/usr/bin/env bash

set -eu

echo "🔍 Checking for Zellij..."

if ! command -v zellij &>/dev/null; then
    echo "📦 Installing Zellij with Homebrew..."
    brew install zellij
else
    echo "✅ Zellij is already installed"
fi

CONFIG_DIR="$DEV_ENV/configs/zellij"
DEST_DIR="$HOME/.config/zellij"

# Create config dir if missing
mkdir -p "$DEST_DIR"

# Copy main config.kdl
if [[ -f "$CONFIG_DIR/config.kdl" ]]; then
    echo "📄 Copying config.kdl to $DEST_DIR"
    cp "$CONFIG_DIR/config.kdl" "$DEST_DIR/"
else
    echo "⚠️  No config.kdl found at $CONFIG_DIR"
fi

# Copy layouts folder if exists
if [[ -d "$CONFIG_DIR/layouts" ]]; then
    echo "📁 Copying layouts to $DEST_DIR"
    cp -r "$CONFIG_DIR/layouts" "$DEST_DIR/"
else
    echo "ℹ️  No layouts directory found at $CONFIG_DIR"
fi

echo "✅ Zellij setup complete"
