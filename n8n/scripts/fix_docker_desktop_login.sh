#!/bin/bash

# Fix Docker Desktop login by initializing pass

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔐 Fixing Docker Desktop Login"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if pass is installed
if ! command -v pass &> /dev/null; then
    echo "❌ pass is not installed"
    echo "Installing pass..."
    sudo apt-get update
    sudo apt-get install -y pass
fi

# Check if GPG key exists
GPG_KEY=$(gpg --list-keys vendorah2@gmail.com 2>/dev/null | grep -oP '^pub.*\/\K[0-9A-F]+' | head -1)

if [ -z "$GPG_KEY" ]; then
    echo "🔑 Creating GPG key for pass..."
    echo ""
    gpg --batch --gen-key <<EOF
%no-protection
Key-Type: RSA
Key-Length: 2048
Name-Real: Docker Desktop User
Name-Email: vendorah2@gmail.com
Expire-Date: 0
%commit
EOF
    
    if [ $? -eq 0 ]; then
        echo "✅ GPG key created"
    else
        echo "❌ Failed to create GPG key"
        exit 1
    fi
else
    echo "✅ GPG key already exists"
fi

# Initialize pass
echo ""
echo "🔐 Initializing pass password store..."
pass init vendorah2@gmail.com

if [ $? -eq 0 ]; then
    echo "✅ pass initialized successfully!"
else
    echo "⚠️  pass initialization had issues, but continuing..."
fi

# Restart Docker Desktop
echo ""
echo "🔄 Restarting Docker Desktop..."
systemctl --user restart docker-desktop

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   ✅ Setup Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Open Docker Desktop GUI"
echo "2. Try logging in with:"
echo "   Email: vendorah2@gmail.com"
echo "   Password: [your password]"
echo ""
echo "3. If still having issues, check Docker Desktop logs:"
echo "   journalctl --user -u docker-desktop -f"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

