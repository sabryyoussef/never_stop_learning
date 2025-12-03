#!/bin/bash

# Alternative fix: Make Docker Desktop context point to CLI Docker

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔄 Alternative Fix for Docker Desktop"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Since Docker Desktop keeps recreating its socket,"
echo "we'll use a different approach:"
echo ""

echo "Option 1: Use context switching (EASIEST)"
echo "  - Keep both daemons separate"
echo "  - Easy script to switch contexts"
echo "  - No conflicts, no issues"
echo ""

echo "Option 2: Configure Docker Desktop to use CLI Docker socket"
echo "  - Modify Docker Desktop settings"
echo "  - Point to /var/run/docker.sock"
echo ""

read -p "Choose option (1 or 2): " choice

if [ "$choice" == "1" ]; then
    echo ""
    echo "✅ Using context switching approach"
    echo ""
    echo "You can easily switch between contexts:"
    echo "  ./scripts/quick_docker_switch.sh cli      # See CLI containers"
    echo "  ./scripts/quick_docker_switch.sh desktop  # See Desktop containers"
    echo ""
    echo "Or use Docker Desktop GUI with default context,"
    echo "and switch to desktop-linux when needed."
    
elif [ "$choice" == "2" ]; then
    echo ""
    echo "🔧 Configuring Docker Desktop context..."
    
    # Stop Docker Desktop
    systemctl --user stop docker-desktop
    
    # Try to update context
    docker context update desktop-linux --docker "host=unix:///var/run/docker.sock" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ Context updated"
    else
        echo "⚠️  Context update method not available"
        echo ""
        echo "Trying manual context configuration..."
        
        # Create a new context that points to CLI Docker
        docker context create cli-docker --docker "host=unix:///var/run/docker.sock" 2>/dev/null
        
        if [ $? -eq 0 ]; then
            echo "✅ Created 'cli-docker' context"
            echo ""
            echo "To use it:"
            echo "  docker context use cli-docker"
            echo ""
            echo "Docker Desktop can use this context too!"
        fi
    fi
    
    # Restart Docker Desktop
    systemctl --user start docker-desktop
    
else
    echo "Invalid choice"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

