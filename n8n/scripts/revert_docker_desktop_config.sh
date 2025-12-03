#!/bin/bash

# Revert Docker Desktop to use its own daemon

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔄 Reverting Docker Desktop Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Stop Docker Desktop
echo "🛑 Stopping Docker Desktop..."
systemctl --user stop docker-desktop 2>/dev/null

# Remove symlink
DOCKER_DESKTOP_SOCKET="$HOME/.docker/desktop/docker.sock"
if [ -L "$DOCKER_DESKTOP_SOCKET" ]; then
    echo "🔗 Removing symlink..."
    rm -f "$DOCKER_DESKTOP_SOCKET"
fi

# Restore backup
if [ -S "${DOCKER_DESKTOP_SOCKET}.backup" ]; then
    echo "📦 Restoring original socket..."
    sudo mv "${DOCKER_DESKTOP_SOCKET}.backup" "$DOCKER_DESKTOP_SOCKET"
fi

# Restart Docker Desktop
echo ""
echo "🚀 Restarting Docker Desktop..."
systemctl --user start docker-desktop

echo ""
echo "✅ Docker Desktop reverted to use its own daemon"
echo ""

