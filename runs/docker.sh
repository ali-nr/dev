#!/usr/bin/env bash

set -eu

echo "🐳 Installing Docker Desktop..."

# Install Docker if not present
if [[ ! -d "/Applications/Docker.app" && ! $(brew list --cask | grep -q "^docker$") ]]; then
    echo "📦 Installing Docker Desktop..."
    brew install --cask docker
else
    echo "✅ Docker Desktop already installed"
fi

# Start Docker Desktop if not already running
if ! pgrep -f Docker.app &>/dev/null; then
    echo "🚀 Launching Docker Desktop..."
    open -a Docker
    echo "⏳ Waiting for Docker to be ready..."
    while ! docker info &>/dev/null; do
        sleep 1
    done
    echo "✅ Docker is running"
else
    echo "✅ Docker is already running"
fi

# Test Docker with hello-world
echo "🧪 Running test container (hello-world)..."
docker run --rm hello-world || echo "⚠️ You may need to grant Docker permissions manually on first run"

echo "✅ Docker setup complete!"
