#!/usr/bin/env bash

set -eu

echo "🚀 Setting up Roo Code Agents..."

REPO_URL="git@github.com:ali-nr/Roo-Code-Agents-Setup.git"
CLONE_DIR="$HOME/code/roo-code-agents"

# Clone or pull the repo
if [[ -d "$CLONE_DIR/.git" ]]; then
    echo "🔁 Repo already cloned. Pulling latest changes..."
    git -C "$CLONE_DIR" pull
else
    echo "⬇️ Cloning repo into $CLONE_DIR..."
    git clone "$REPO_URL" "$CLONE_DIR"
fi

# Ensure global .gitignore has Roo entries
GITIGNORE_FILE="$HOME/.gitignore"
touch "$GITIGNORE_FILE"
entries=(".roo" ".roomodes" "handoffs", "single-script", ".rooignore")

for entry in "${entries[@]}"; do
    if ! grep -qx "$entry" "$GITIGNORE_FILE"; then
        echo "$entry" >>"$GITIGNORE_FILE"
        echo "➕ Added $entry to $GITIGNORE_FILE"
    else
        echo "✅ $entry already exists in $GITIGNORE_FILE"
    fi
done

# Set as global gitignore if not already
if ! git config --global core.excludesfile | grep -q "$GITIGNORE_FILE"; then
    git config --global core.excludesfile "$GITIGNORE_FILE"
    echo "🔧 Set $GITIGNORE_FILE as global gitignore"
fi

# Copy contents from cloned repo into the DEV_ENV
echo "📁 Copying files from Roo repo into $DEV_ENV"

rsync -av --exclude '.git' --exclude '.gitignore' "$CLONE_DIR"/ "$DEV_ENV"/

echo "✅ Roo Code setup and sync complete!"
