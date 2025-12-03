#!/bin/bash

# Quick script to switch between Docker Desktop and CLI Docker

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔄 Docker Context Switcher"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Show current contexts
echo "📋 Available Docker contexts:"
docker context ls
echo ""

# Get current context
CURRENT=$(docker context ls | grep '*' | awk '{print $1}')

if [ -z "$CURRENT" ]; then
    CURRENT="default"
fi

echo "📍 Current context: $CURRENT"
echo ""

# Switch based on argument
if [ "$1" == "desktop" ]; then
    if docker context ls | grep -q "desktop-linux"; then
        docker context use desktop-linux
        echo "✅ Switched to Docker Desktop (desktop-linux)"
    else
        echo "❌ Docker Desktop context not found"
        echo "   Start Docker Desktop first, then try again"
        exit 1
    fi
elif [ "$1" == "cli" ] || [ "$1" == "default" ]; then
    docker context use default
    echo "✅ Switched to CLI Docker (default)"
elif [ "$1" == "status" ] || [ -z "$1" ]; then
    echo "Usage: $0 [desktop|cli|status]"
    echo ""
    echo "  desktop  - Switch to Docker Desktop"
    echo "  cli      - Switch to CLI Docker"
    echo "  status   - Show current status (default)"
    echo ""
else
    echo "❌ Unknown option: $1"
    echo "Usage: $0 [desktop|cli|status]"
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

