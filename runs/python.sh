#!/usr/bin/env bash

set -eu

echo "🐍 Installing Python with pyenv..."

# Install pyenv if not installed
if ! command -v pyenv &>/dev/null; then
    brew install pyenv
    echo 'eval "$(pyenv init --path)"' >>~/.zprofile
    echo 'eval "$(pyenv init -)"' >>~/.zshrc
    echo "✅ pyenv installed and shell integration added"
else
    echo "✅ pyenv already installed"
fi

# Install latest Python version
LATEST=$(pyenv install --list | grep -E '^\s*3\.[0-9]+\.[0-9]+$' | tail -1 | xargs)
if ! pyenv versions | grep -q "$LATEST"; then
    echo "⬇️ Installing Python $LATEST..."
    pyenv install "$LATEST"
else
    echo "✅ Python $LATEST already installed"
fi

# Set as global
pyenv global "$LATEST"
echo "🌍 Global Python version set to $LATEST"

# Rehash after install
pyenv rehash

# Ensure pipx is installed for CLI tools
if ! command -v pipx &>/dev/null; then
    echo "📦 Installing pipx..."
    brew install pipx
    pipx ensurepath
else
    echo "✅ pipx already installed"
fi

echo "✅ Python setup complete!"
