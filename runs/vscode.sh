#!/usr/bin/env bash

echo "🧠 Installing and configuring Visual Studio Code..."

# Check for Homebrew
if ! command -v brew &>/dev/null; then
    echo "❌ Homebrew is not installed. Please run the homebrew setup first."
    exit 1
fi

# Install VS Code
if ! command -v code &>/dev/null; then
    echo "📦 Installing Visual Studio Code..."
    brew install --cask visual-studio-code
else
    echo "✅ Visual Studio Code already installed."
fi

# Enable `code` command in PATH (if it's not already)
if ! command -v code &>/dev/null; then
    echo "🔧 Linking VS Code CLI to PATH..."
    export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
    echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >>~/.zshrc
fi

# Install common extensions
echo "🧩 Installing common VS Code extensions..."
extensions=(
    aaronthomas.vscode-snazzy-operator
    ahmadawais.shades-of-purple
    alefragnani.bookmarks
    alefragnani.project-manager
    alexkrechik.cucumberautocomplete
    antfu.vite
    apollographql.vscode-apollo
    barrsan.reui
    bierner.markdown-mermaid
    bradlc.vscode-tailwindcss
    bsides.snazzy-operator-plus
    burkeholland.simple-react-snippets
    byi8220.indented-block-highlighting
    christian-kohler.path-intellisense
    chrmarti.regex
    davidanson.vscode-markdownlint
    daylerees.rainglow
    donjayamanne.githistory
    dotjoshjohnson.xml
    dracula-theme.theme-dracula
    eamodio.gitlens
    ecmel.vscode-html-css
    editorconfig.editorconfig
    enkia.tokyo-night
    expo.vscode-expo-tools
    formulahendry.auto-rename-tag
    foxundermoon.shell-format
    github.copilot
    github.copilot-chat
    github.vscode-github-actions
    golang.go
    graphql.vscode-graphql
    graphql.vscode-graphql-syntax
    hashicorp.terraform
    helgardrichard.helium-icon-theme
    humao.rest-client
    johnpapa.vscode-peacock
    kamikillerto.vscode-colorize
    kisstkondoros.csstriggers
    kisstkondoros.vscode-gutter-preview
    kumar-harsh.graphql-for-vscode
    liviuschera.noctis
    mariomatheu.syntax-project-pbxproj
    mikestead.dotenv
    mrmlnc.vscode-autoprefixer
    ms-mssql.mssql
    ms-mssql.sql-bindings-vscode
    ms-playwright.playwright
    ms-python.debugpy
    ms-python.python
    ms-python.vscode-pylance
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode.makefile-tools
    ms-vscode.remote-explorer
    ms-vscode.theme-materialkit
    ms-vsliveshare.vsliveshare
    msjsdiag.vscode-react-native
    naumovs.color-highlight
    pflannery.vscode-versionlens
    pranaygp.vscode-css-peek
    prisma.prisma
    redhat.vscode-yaml
    rooveterinaryinc.roo-cline
    rvest.vs-code-prettier-eslint
    simonsiefke.svg-preview
    sporiley.css-auto-prefix
    streetsidesoftware.code-spell-checker
    tyriar.sort-lines
    visualstudioexptteam.intellicode-api-usage-examples
    visualstudioexptteam.vscodeintellicode
    vitest.explorer
    vscode-icons-team.vscode-icons
    waderyan.gitblame
    wayou.vscode-todo-highlight
    whizkydee.material-palenight-theme
    will-stone.plastic
    wix.vscode-import-cost
    xabikos.reactsnippets
    yzhang.markdown-all-in-one
    zhuangtongfa.material-theme
    zignd.html-css-class-completion
)

for ext in "${extensions[@]}"; do
    if code --list-extensions | grep -q "$ext"; then
        echo "✅ Extension $ext already installed"
    else
        echo "📦 Installing $ext..."
        code --install-extension "$ext"
    fi
done

# Optional: Sync settings if you have a settings.json
SETTINGS_SRC="$DEV_ENV/configs/vscode/settings.json"
SETTINGS_DEST="$HOME/Library/Application Support/Code/User/settings.json"

if [[ -f "$SETTINGS_SRC" ]]; then
    echo "⚙️ Copying VS Code settings.json..."
    mkdir -p "$(dirname "$SETTINGS_DEST")"
    cp "$SETTINGS_SRC" "$SETTINGS_DEST"
    echo "✅ VS Code settings synced."
else
    echo "ℹ️ No custom settings.json found in configs/vscode."
fi

echo "🎉 VS Code setup complete!"
