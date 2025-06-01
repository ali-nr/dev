#!/usr/bin/env bash

set -eu

echo "📦 Installing Ghostty terminal..."

if ! command -v ghostty &>/dev/null; then
    brew install --no-quarantine --cask ghostty
    echo "✅ Ghostty installed successfully."
else
    echo "ℹ️ Ghostty is already installed."
fi
