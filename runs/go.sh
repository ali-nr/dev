#!/usr/bin/env bash

set -eu

echo "🐹 Installing Go..."

if ! command -v go &>/dev/null; then
    brew install go
else
    echo "✅ Go is already installed"
fi

# Add Go path exports if not already in .zshrc
ZSHRC="$HOME/.zshrc"
GO_COMMENT="# >>> GO ENV >>>"

if ! grep -q "$GO_COMMENT" "$ZSHRC"; then
    echo "🔧 Adding Go env vars to .zshrc..."
    {
        echo ""
        echo "$GO_COMMENT"
        echo "export GOPATH=\$HOME/go"
        echo "export GOBIN=\$GOPATH/bin"
        echo "export PATH=\$PATH:\$GOBIN"
        echo "# <<< GO ENV <<<"
    } >> "$ZSHRC"
else
    echo "✅ Go env already present in .zshrc"
fi
