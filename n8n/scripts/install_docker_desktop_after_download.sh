#!/bin/bash

# Install Docker Desktop after manual download

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔧 Installing Docker Desktop"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd ~/Downloads

# Find Docker Desktop .deb file
DEB_FILE=$(find . -maxdepth 1 -name "docker-desktop-*.deb" -type f | head -1)

if [ -z "$DEB_FILE" ]; then
    echo "❌ Docker Desktop .deb file not found in ~/Downloads"
    echo ""
    echo "Please download it first:"
    echo "1. Visit: https://www.docker.com/products/docker-desktop/"
    echo "2. Download the .deb file"
    echo "3. Save to ~/Downloads"
    echo "4. Run this script again"
    exit 1
fi

# Check file size (should be > 100MB)
FILE_SIZE=$(stat -c%s "$DEB_FILE" 2>/dev/null || stat -f%z "$DEB_FILE")
MIN_SIZE=$((100 * 1024 * 1024))  # 100MB

if [ "$FILE_SIZE" -lt "$MIN_SIZE" ]; then
    echo "⚠️  File seems too small ($(du -h "$DEB_FILE" | cut -f1))"
    echo "   Expected: ~500MB"
    echo ""
    read -p "Continue anyway? (y/n): " confirm
    if [ "$confirm" != "y" ]; then
        exit 1
    fi
fi

echo "📦 Found: $DEB_FILE"
echo "📊 Size: $(du -h "$DEB_FILE" | cut -f1)"
echo ""

# Install dependencies
echo "📥 Installing dependencies..."
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    pass \
    uidmap

# Install Docker Desktop
echo ""
echo "🔧 Installing Docker Desktop..."
sudo apt install -y "./$DEB_FILE"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Docker Desktop installed successfully!"
    echo ""
    
    # Start Docker Desktop
    echo "🚀 Starting Docker Desktop..."
    systemctl --user enable docker-desktop 2>/dev/null
    systemctl --user start docker-desktop 2>/dev/null
    
    echo ""
    echo "⏳ Waiting for Docker Desktop to initialize..."
    sleep 5
    
    echo ""
    echo "📋 Docker contexts:"
    docker context ls 2>/dev/null || echo "   (Contexts will appear after Docker Desktop fully starts)"
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "   ✅ Installation Complete!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "📋 Next Steps:"
    echo ""
    echo "1. Switch to Docker Desktop context:"
    echo "   docker context use desktop-linux"
    echo ""
    echo "2. Or use helper script:"
    echo "   ./scripts/docker_switch_context.sh desktop"
    echo ""
    echo "3. Switch back to CLI Docker:"
    echo "   docker context use default"
    echo ""
else
    echo ""
    echo "❌ Installation failed"
    exit 1
fi

