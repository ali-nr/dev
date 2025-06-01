#!/usr/bin/env bash

echo "🔍 Checking for zsh..."

if ! command -v zsh &>/dev/null; then
    echo "📦 Installing zsh..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install -y zsh
    else
        echo "❌ Unsupported OS"
        exit 1
    fi
else
    echo "✅ zsh already installed"
fi

# Set default shell to zsh if not already
if [[ "$SHELL" != "$(which zsh)" ]]; then
    echo "🔧 Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo "✅ Shell changed to zsh. Please restart your terminal."
else
    echo "✅ zsh is already the default shell"
fi

CONFIG_DIR="$DEV_ENV/configs/zsh"

# Copy .zshrc
if [[ -f "$CONFIG_DIR/.zshrc" ]]; then
    echo "📄 Copying .zshrc to home directory..."
    cp "$CONFIG_DIR/.zshrc" ~/.zshrc
else
    echo "⚠️  .zshrc not found in $CONFIG_DIR"
fi

# Copy aliases.zsh and append source to .zshrc
if [[ -f "$CONFIG_DIR/aliases.zsh" ]]; then
    echo "📄 Copying aliases.zsh to home directory..."
    cp "$CONFIG_DIR/aliases.zsh" ~/.aliases.zsh
    if ! grep -q "source ~/.aliases.zsh" ~/.zshrc; then
        echo "source ~/.aliases.zsh" >>~/.zshrc
        echo "✅ .zshrc updated to include aliases"
    fi
else
    echo "⚠️  aliases.zsh not found in $CONFIG_DIR"
fi

# Ensure .zprofile sources .zshrc (for login shells like Ghostty)
ZPROFILE="$HOME/.zprofile"
if ! grep -q 'source ~/.zshrc' "$ZPROFILE" 2>/dev/null; then
    echo '[[ -f ~/.zshrc ]] && source ~/.zshrc' >>"$ZPROFILE"
    echo "✅ .zprofile updated to source .zshrc"
else
    echo "ℹ️  .zprofile already sources .zshrc"
fi

# Optional oh-my-zsh
read -p "✨ Install oh-my-zsh? (y/n): " INSTALL_OMZ
if [[ "$INSTALL_OMZ" == "y" ]]; then
    echo "🚀 Installing oh-my-zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "🎉 oh-my-zsh installed!"
else
    echo "⏭️  Skipped oh-my-zsh install"
fi
