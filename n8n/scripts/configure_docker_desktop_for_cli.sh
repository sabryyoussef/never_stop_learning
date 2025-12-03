#!/bin/bash

# Configure Docker Desktop to see CLI Docker containers
# WARNING: This makes Docker Desktop use CLI Docker's daemon

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔗 Configure Docker Desktop for CLI Docker"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "⚠️  WARNING: This will make Docker Desktop use CLI Docker's daemon"
echo "   Both will see the same containers, but may conflict!"
echo ""
read -p "Continue? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "Cancelled"
    exit 0
fi

# Stop Docker Desktop
echo ""
echo "🛑 Stopping Docker Desktop..."
systemctl --user stop docker-desktop 2>/dev/null

# Backup original Docker Desktop socket
DOCKER_DESKTOP_SOCKET="$HOME/.docker/desktop/docker.sock"
if [ -S "$DOCKER_DESKTOP_SOCKET" ]; then
    echo "📦 Backing up Docker Desktop socket..."
    sudo mv "$DOCKER_DESKTOP_SOCKET" "${DOCKER_DESKTOP_SOCKET}.backup"
fi

# Create symlink to CLI Docker socket
echo "🔗 Creating symlink to CLI Docker socket..."
mkdir -p "$HOME/.docker/desktop"
sudo ln -sf /var/run/docker.sock "$DOCKER_DESKTOP_SOCKET"

# Fix permissions
echo "🔧 Fixing permissions..."
sudo chown $USER:$USER "$DOCKER_DESKTOP_SOCKET" 2>/dev/null || true

# Restart Docker Desktop
echo ""
echo "🚀 Restarting Docker Desktop..."
systemctl --user start docker-desktop

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   ✅ Configuration Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 What changed:"
echo "   - Docker Desktop now uses CLI Docker's daemon"
echo "   - You'll see all CLI Docker containers in Docker Desktop GUI"
echo "   - Both Docker Desktop and CLI Docker see the same containers"
echo ""
echo "⚠️  Important Notes:"
echo "   - Both tools now use the same Docker daemon"
echo "   - Be careful not to run conflicting operations"
echo "   - Your n8n container should now appear in Docker Desktop!"
echo ""
echo "🔄 To revert:"
echo "   ./scripts/revert_docker_desktop_config.sh"
echo ""

