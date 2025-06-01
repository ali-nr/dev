#!/usr/bin/env bash

# Title: homebrew.sh
# Description: Installs Homebrew if not already present

set -euo pipefail

echo "🔧 Checking Homebrew installation..."

if ! command -v brew &>/dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # For Intel Macs
    if [[ $(uname -m) == "x86_64" ]]; then
        echo 'eval "$(/usr/local/bin/brew shellenv)"' >>~/.zprofile
        eval "$(/usr/local/bin/brew shellenv)"
    else
        # For Apple Silicon
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew is already installed."
fi

echo "🔄 Updating Homebrew..."
brew update

echo "✅ Homebrew is ready to use."
