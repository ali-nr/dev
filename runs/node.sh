#!/usr/bin/env bash

echo "🧑‍💻 Installing Node.js, pnpm, and n (Node version manager)..."
# Node: https://nodejs.org
# pnpm: https://pnpm.io
# n: https://github.com/tj/n

brew install node
echo "✅ Node.js installed."

npm install -g pnpm
echo "✅ pnpm installed."

npm install -g n
echo "✅ n installed."

n lts
echo "✅ Switched to latest LTS version of Node."

# ---- Setup environment variables for n (zsh only) ----

N_PREFIX="$HOME/.n"
RC_FILE="$HOME/.zshrc"

if ! grep -q 'N_PREFIX' "$RC_FILE"; then
    echo "🔧 Adding N_PREFIX and PATH to $RC_FILE"
    {
        echo ""
        echo "# 👉 n (Node.js version manager) setup"
        echo "export N_PREFIX=\"$N_PREFIX\""
        echo "export PATH=\"\$N_PREFIX/bin:\$PATH\""
    } >>"$RC_FILE"
    echo "✅ Environment variables added to .zshrc"
else
    echo "ℹ️  N_PREFIX already configured in .zshrc"
fi

mkdir -p "$N_PREFIX/bin"
echo "✅ Ensured $N_PREFIX/bin directory exists."
