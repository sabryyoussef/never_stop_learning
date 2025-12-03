#!/bin/bash

# Complete Docker Desktop configuration - run this in terminal

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔗 Complete Docker Desktop Configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Stop Docker Desktop
echo "🛑 Stopping Docker Desktop..."
systemctl --user stop docker-desktop
sleep 2

# Backup and create symlink
DOCKER_DESKTOP_SOCKET="$HOME/.docker/desktop/docker.sock"

if [ -S "$DOCKER_DESKTOP_SOCKET" ] && [ ! -L "$DOCKER_DESKTOP_SOCKET" ]; then
    echo "📦 Backing up Docker Desktop socket..."
    sudo mv "$DOCKER_DESKTOP_SOCKET" "${DOCKER_DESKTOP_SOCKET}.backup"
fi

echo "🔗 Creating symlink to CLI Docker socket..."
sudo rm -f "$DOCKER_DESKTOP_SOCKET"
sudo ln -sf /var/run/docker.sock "$DOCKER_DESKTOP_SOCKET"

echo "🔧 Fixing permissions..."
sudo chown $USER:$USER "$DOCKER_DESKTOP_SOCKET"

# Restart Docker Desktop
echo ""
echo "🚀 Starting Docker Desktop..."
systemctl --user start docker-desktop
sleep 5

# Verify
echo ""
echo "🔍 Verifying configuration..."
if [ -L "$DOCKER_DESKTOP_SOCKET" ]; then
    echo "✅ Symlink created successfully!"
    ls -la "$DOCKER_DESKTOP_SOCKET"
else
    echo "❌ Symlink not created properly"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   ✅ Configuration Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 What's Done:"
echo "   ✅ Docker Desktop now uses CLI Docker's daemon"
echo "   ✅ All CLI Docker containers visible in Docker Desktop GUI"
echo "   ✅ Your n8n container should now appear!"
echo ""
echo "🎯 Next Steps:"
echo "   1. Open Docker Desktop GUI"
echo "   2. Check Containers tab"
echo "   3. You should see n8n and all CLI Docker containers!"
echo ""
echo "🔄 To revert (if needed):"
echo "   ./scripts/revert_docker_desktop_config.sh"
echo ""

