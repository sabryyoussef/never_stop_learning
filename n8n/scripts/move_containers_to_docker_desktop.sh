#!/bin/bash

# Script to move ONLY Odoo containers from default context to Docker Desktop context
# n8n will remain in default context

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🔄 Moving Odoo Containers to Docker Desktop"
echo "   (n8n will stay in default context)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd /home/sabry3/never_stop_learning/n8n || exit 1

# Verify n8n is running in default context (will not be touched)
echo "📋 Checking n8n status (will remain untouched)..."
docker context use default
if docker ps --format "{{.Names}}" | grep -q "^n8n$"; then
    echo "✅ n8n is running in default context (will stay there)"
else
    echo "⚠️  n8n not found in default context"
fi
echo ""

# Step 1: Stop ONLY Odoo containers in default context
echo "1. Stopping Odoo containers in default context..."

# Try docker-compose first
if docker-compose -f docker-compose-odoo.yml down 2>/dev/null; then
    echo "✅ Containers stopped using docker-compose"
else
    echo "⚠️  docker-compose failed, trying to stop containers individually..."
    # Stop containers individually (more reliable)
    CONTAINERS="n8n-odoo-16-1 n8n-odoo-17-1 n8n-odoo-18-1 n8n-odoo-19-1 n8n-db-1"
    STOPPED=0
    for container in $CONTAINERS; do
        if docker stop "$container" 2>/dev/null; then
            echo "  ✅ Stopped $container"
            docker rm "$container" 2>/dev/null
            STOPPED=$((STOPPED + 1))
        fi
    done
    
    if [ $STOPPED -eq 0 ]; then
        echo "❌ Failed to stop containers. You may need to:"
        echo "   1. Add yourself to docker group: sudo usermod -aG docker $USER"
        echo "   2. Log out and log back in"
        echo "   3. Or run: sudo docker stop n8n-odoo-16-1 n8n-odoo-17-1 n8n-odoo-18-1 n8n-odoo-19-1 n8n-db-1"
        exit 1
    else
        echo "✅ Stopped $STOPPED containers"
    fi
fi

echo ""

# Step 2: Create containers in Docker Desktop context
echo "2. Creating containers in Docker Desktop context..."
docker context use desktop-linux
docker-compose -f docker-compose-odoo.yml up -d

if [ $? -ne 0 ]; then
    echo "❌ Failed to create containers in Docker Desktop"
    exit 1
fi

echo "✅ Containers created"
echo ""

# Step 3: Verify
echo "3. Verifying containers are in Docker Desktop..."
sleep 3
echo ""
echo "📦 Odoo containers in Docker Desktop:"
docker ps --format "  ✅ {{.Names}} - {{.Status}} - {{.Ports}}"

echo ""
echo "📋 Verifying n8n is still in default context (untouched)..."
docker context use default
if docker ps --format "{{.Names}}" | grep -q "^n8n$"; then
    echo "  ✅ n8n is still running in default context"
    docker ps --filter "name=^n8n$" --format "  ✅ {{.Names}} - {{.Status}} - {{.Ports}}"
else
    echo "  ⚠️  n8n not found (this shouldn't happen)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   ✅ DONE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎯 Odoo containers should now appear in Docker Desktop GUI!"
echo ""
echo "🌐 Access URLs:"
echo "   - Odoo 16: http://localhost:8068"
echo "   - Odoo 17: http://localhost:8070"
echo "   - Odoo 18: http://localhost:8071"
echo "   - Odoo 19: http://localhost:8072"
echo ""
echo "📋 n8n remains in default context:"
echo "   - n8n: http://localhost:5678"
echo ""

