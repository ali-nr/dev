#!/usr/bin/env bash

echo "🔧 Setting up GitHub CLI..."

# Check if gh is already installed
if command -v gh &>/dev/null; then
    echo "✅ GitHub CLI is already installed"
else
    echo "📦 Installing GitHub CLI..."
    
    # Install via Homebrew on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &>/dev/null; then
            brew install gh
            echo "✅ GitHub CLI installed via Homebrew"
        else
            echo "❌ Homebrew not found. Please install Homebrew first."
            exit 1
        fi
    # Install via apt on Ubuntu/Debian
    elif command -v apt &>/dev/null; then
        sudo apt update
        sudo apt install gh
        echo "✅ GitHub CLI installed via apt"
    # Install via yum on CentOS/RHEL
    elif command -v yum &>/dev/null; then
        sudo yum install gh
        echo "✅ GitHub CLI installed via yum"
    else
        echo "❌ Unsupported package manager. Please install GitHub CLI manually."
        echo "Visit: https://github.com/cli/cli#installation"
        exit 1
    fi
fi

# Check if already authenticated
if gh auth status &>/dev/null; then
    echo "✅ GitHub CLI is already authenticated"
    gh auth status
else
    echo "🔐 Authenticating with GitHub..."
    echo "This will open your browser to authenticate with GitHub"
    
    # Authenticate with GitHub
    gh auth login --web --git-protocol https
    
    if gh auth status &>/dev/null; then
        echo "✅ GitHub CLI authentication successful"
    else
        echo "❌ GitHub CLI authentication failed"
        exit 1
    fi
fi

# Set up some useful aliases
echo "⚙️  Setting up GitHub CLI aliases..."

# Create useful aliases
gh alias set prs 'pr list --author @me' 2>/dev/null || echo "Alias 'prs' already exists"
gh alias set issues 'issue list --author @me' 2>/dev/null || echo "Alias 'issues' already exists"
gh alias set repo-clone 'repo clone' 2>/dev/null || echo "Alias 'repo-clone' already exists"
gh alias set pr-create 'pr create --web' 2>/dev/null || echo "Alias 'pr-create' already exists"

echo "✅ GitHub CLI aliases configured"

# Configure default editor for GitHub CLI
echo "📝 Configuring default editor..."
gh config set editor "code --wait"
echo "✅ Default editor set to VS Code"

# Set default protocol to HTTPS
echo "🔗 Setting default protocol to HTTPS..."
gh config set git_protocol https
echo "✅ Default Git protocol set to HTTPS"

echo ""
echo "🎉 GitHub CLI setup complete!"
echo ""
echo "📚 Useful commands:"
echo "  gh repo create         - Create a new repository"
echo "  gh repo clone          - Clone a repository"
echo "  gh pr create           - Create a pull request"
echo "  gh pr list             - List pull requests"
echo "  gh issue create        - Create an issue"
echo "  gh issue list          - List issues"
echo "  gh workflow list       - List GitHub Actions workflows"
echo "  gh workflow run        - Run a GitHub Actions workflow"
echo ""
echo "📖 For more commands, run: gh help"
