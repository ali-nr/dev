#!/usr/bin/env bash

echo "🔧 Setting up Git configuration..."

# Basic identity
git config --global user.name "AliReza N"
git config --global user.email "alireza.alnr@gmail.com"
echo "✅ Git user.name and user.email set"

# Helpful defaults
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "code --wait"
git config --global color.ui auto
git config --global core.autocrlf input
echo "✅ Git defaults configured"

# Check if SSH key exists
SSH_KEY="$HOME/.ssh/id_ed25519"

if [[ -f "$SSH_KEY" ]]; then
    echo "🔑 SSH key already exists at $SSH_KEY"
else
    echo "🔐 Generating new SSH key..."
    ssh-keygen -t ed25519 -C "you@example.com" -f "$SSH_KEY" -N ""
    echo "✅ SSH key generated"
fi

# Start SSH agent
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

# Copy public key to clipboard
if [[ "$OSTYPE" == "darwin"* ]]; then
    pbcopy <"$SSH_KEY.pub"
    echo "📋 SSH public key copied to clipboard!"
elif command -v xclip &>/dev/null; then
    xclip -sel clip <"$SSH_KEY.pub"
    echo "📋 SSH public key copied to clipboard!"
else
    echo "⚠️  Could not copy SSH key to clipboard. Manually copy from:"
    cat "$SSH_KEY.pub"
fi

echo "📎 Paste your key into GitHub/GitLab: https://github.com/settings/ssh/new"
echo "🎉 Git is ready to use!"
