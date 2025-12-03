#!/bin/bash

# Install Docker Desktop and configure to avoid conflicts

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🐳 Docker Desktop Installation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if Docker Desktop is already installed
if command -v docker-desktop &> /dev/null || [ -f /usr/share/applications/docker-desktop.desktop ]; then
    echo "✅ Docker Desktop is already installed"
    echo ""
    echo "📋 Current Docker contexts:"
    docker context ls
    exit 0
fi

# Check current Docker installation
echo "📦 Checking current Docker installation..."
if command -v docker &> /dev/null; then
    echo "✅ Docker CLI found: $(docker --version)"
    echo ""
    echo "📋 Current Docker context:"
    docker context ls
    echo ""
else
    echo "⚠️  Docker CLI not found"
fi

# Create download directory
DOWNLOAD_DIR="$HOME/Downloads"
mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

echo "📥 Downloading Docker Desktop..."
echo ""
echo "Please download Docker Desktop manually:"
echo "1. Visit: https://www.docker.com/products/docker-desktop/"
echo "2. Download the .deb file for Linux"
echo "3. Save to: $DOWNLOAD_DIR"
echo ""
read -p "Press Enter after downloading, or 's' to skip download and install from existing file: " choice

if [ "$choice" != "s" ]; then
    # Look for existing .deb file
    DEB_FILE=$(find "$DOWNLOAD_DIR" -name "docker-desktop-*.deb" -type f | head -1)
    
    if [ -z "$DEB_FILE" ]; then
        echo ""
        echo "❌ Docker Desktop .deb file not found in $DOWNLOAD_DIR"
        echo "Please download it first, then run this script again"
        exit 1
    fi
else
    DEB_FILE=$(find "$DOWNLOAD_DIR" -name "docker-desktop-*.deb" -type f | head -1)
    if [ -z "$DEB_FILE" ]; then
        echo "❌ No .deb file found. Please download Docker Desktop first."
        exit 1
    fi
fi

echo ""
echo "📦 Installing Docker Desktop from: $DEB_FILE"
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
sudo apt install -y "$DEB_FILE"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Docker Desktop installed successfully!"
    echo ""
    
    # Configure contexts
    echo "🔧 Configuring Docker contexts..."
    sleep 2
    
    # Check if desktop-linux context exists
    if docker context ls | grep -q "desktop-linux"; then
        echo "✅ Docker Desktop context found: desktop-linux"
    else
        echo "⏳ Docker Desktop context will be created on first launch"
    fi
    
    echo ""
    echo "📋 Available Docker contexts:"
    docker context ls
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "   ✅ Installation Complete!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "📋 Next Steps:"
    echo ""
    echo "1. Start Docker Desktop:"
    echo "   - From applications menu, or"
    echo "   - Run: systemctl --user start docker-desktop"
    echo ""
    echo "2. Switch to Docker Desktop context:"
    echo "   docker context use desktop-linux"
    echo ""
    echo "3. Switch back to CLI Docker:"
    echo "   docker context use default"
    echo ""
    echo "4. Check contexts anytime:"
    echo "   docker context ls"
    echo ""
    echo "📖 See: docs/setup/DOCKER_DESKTOP_SETUP.md for details"
    echo ""
else
    echo ""
    echo "❌ Installation failed"
    exit 1
fi

