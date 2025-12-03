#!/bin/bash

# Fix Docker Desktop not showing containers

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔧 Fix Docker Desktop Containers Not Showing"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check symlink
echo "1. Checking symlink..."
if [ -L ~/.docker/desktop/docker.sock ]; then
    TARGET=$(readlink -f ~/.docker/desktop/docker.sock)
    echo "   ✅ Symlink exists: $TARGET"
    if [ "$TARGET" = "/var/run/docker.sock" ]; then
        echo "   ✅ Points to correct socket"
    else
        echo "   ❌ Points to wrong location: $TARGET"
        echo "   Fixing..."
        systemctl --user stop docker-desktop
        sudo rm -f ~/.docker/desktop/docker.sock
        sudo ln -sf /var/run/docker.sock ~/.docker/desktop/docker.sock
        sudo chown $USER:$USER ~/.docker/desktop/docker.sock
        systemctl --user start docker-desktop
    fi
else
    echo "   ❌ Not a symlink!"
    echo "   Creating symlink..."
    systemctl --user stop docker-desktop
    sudo mv ~/.docker/desktop/docker.sock ~/.docker/desktop/docker.sock.backup 2>/dev/null
    sudo ln -sf /var/run/docker.sock ~/.docker/desktop/docker.sock
    sudo chown $USER:$USER ~/.docker/desktop/docker.sock
    systemctl --user start docker-desktop
fi

# Check docker group
echo ""
echo "2. Checking docker group membership..."
if groups | grep -q docker; then
    echo "   ✅ User is in docker group"
else
    echo "   ⚠️  User not in docker group"
    echo "   Adding user to docker group..."
    sudo usermod -aG docker $USER
    echo "   ✅ Added. You may need to log out and back in, or run: newgrp docker"
fi

# Test connection
echo ""
echo "3. Testing connection..."
docker context use desktop-linux 2>/dev/null
if docker ps -a &>/dev/null; then
    echo "   ✅ Connection works!"
    echo "   Containers found:"
    docker ps -a --format "  - {{.Names}} ({{.Status}})"
else
    echo "   ❌ Connection failed"
    echo "   Testing direct socket connection..."
    if docker -H unix:///var/run/docker.sock ps -a &>/dev/null; then
        echo "   ✅ Direct socket works - permission issue"
    else
        echo "   ❌ Direct socket also fails"
    fi
fi

# Restart Docker Desktop
echo ""
echo "4. Restarting Docker Desktop..."
systemctl --user stop docker-desktop
sleep 2
systemctl --user start docker-desktop
sleep 5

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   ✅ Fix Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Wait 10-15 seconds for Docker Desktop to fully start"
echo ""
echo "2. In Docker Desktop GUI:"
echo "   - Click 'Containers' tab"
echo "   - Click refresh/reload button"
echo "   - Or close and reopen Docker Desktop"
echo ""
echo "3. If still not showing:"
echo "   - Check: docker context use desktop-linux && docker ps -a"
echo "   - Check logs: journalctl --user -u docker-desktop -n 30"
echo ""
echo "4. If user was added to docker group:"
echo "   - Log out and back in, OR"
echo "   - Run: newgrp docker"
echo "   - Then restart Docker Desktop"
echo ""

