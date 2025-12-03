#!/bin/bash

# Quick script to easily switch Docker contexts and show containers

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔄 Quick Docker Context Switcher"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

CURRENT=$(docker context ls | grep '*' | awk '{print $1}')

echo "📍 Current context: $CURRENT"
echo ""
echo "📋 Available contexts:"
docker context ls
echo ""

if [ "$1" == "cli" ] || [ "$1" == "default" ]; then
    docker context use default
    echo "✅ Switched to CLI Docker (default)"
    echo ""
    echo "📦 Containers:"
    docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
elif [ "$1" == "desktop" ]; then
    docker context use desktop-linux
    echo "✅ Switched to Docker Desktop"
    echo ""
    echo "📦 Containers:"
    docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
elif [ "$1" == "show" ] || [ -z "$1" ]; then
    echo "📦 Containers in current context ($CURRENT):"
    docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
    echo ""
    echo "💡 Usage:"
    echo "   $0 cli      - Switch to CLI Docker and show containers"
    echo "   $0 desktop  - Switch to Docker Desktop and show containers"
    echo "   $0 show     - Show containers in current context"
else
    echo "❌ Unknown option: $1"
    echo "Usage: $0 [cli|desktop|show]"
fi

