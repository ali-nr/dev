# Warp Terminal Zsh Integration

# Enable Warp AI features
export WARP_AI_ENABLED=true

# Add Warp specific aliases
alias ws="warp subshell"
alias wc="warp close-subshell"
alias wl="warp list-subshells"

# Add Warp to the PATH if not already there
if [[ ":$PATH:" != *":/Applications/Warp.app/Contents/Resources:"* ]]; then
    export PATH="$PATH:/Applications/Warp.app/Contents/Resources"
fi
