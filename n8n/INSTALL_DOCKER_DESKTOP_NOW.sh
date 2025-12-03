#!/bin/bash
# Quick install script - run this in your terminal

cd ~/Downloads

echo "🔧 Installing Docker Desktop..."
echo ""

# Install dependencies
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release pass uidmap

# Install Docker Desktop
sudo apt install -y ./docker-desktop-amd64.deb

# Start Docker Desktop
systemctl --user enable docker-desktop
systemctl --user start docker-desktop

echo ""
echo "⏳ Waiting for Docker Desktop to start..."
sleep 5

echo ""
echo "📋 Docker contexts:"
docker context ls

echo ""
echo "✅ Installation complete!"
echo ""
echo "🔄 To switch to Docker Desktop:"
echo "   docker context use desktop-linux"
echo ""
echo "🔄 To switch back to CLI Docker:"
echo "   docker context use default"

