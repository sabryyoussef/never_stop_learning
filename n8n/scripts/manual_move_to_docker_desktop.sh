#!/bin/bash

# Manual script to move Odoo containers to Docker Desktop
# This script provides step-by-step commands you can run manually

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   📋 Manual Steps to Move Odoo Containers"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

cd /home/sabry3/never_stop_learning/n8n || exit 1

echo "Step 1: Stop Odoo containers in default context"
echo "Run these commands:"
echo ""
echo "  docker context use default"
echo "  docker stop n8n-odoo-16-1 n8n-odoo-17-1 n8n-odoo-18-1 n8n-odoo-19-1 n8n-db-1"
echo "  docker rm n8n-odoo-16-1 n8n-odoo-17-1 n8n-odoo-18-1 n8n-odoo-19-1 n8n-db-1"
echo ""

read -p "Have you stopped the containers? (y/n): " answer
if [[ ! $answer =~ ^[Yy]$ ]]; then
    echo "Please stop the containers first, then run this script again."
    exit 1
fi

echo ""
echo "Step 2: Creating containers in Docker Desktop context..."
docker context use desktop-linux

if docker-compose -f docker-compose-odoo.yml up -d; then
    echo "✅ Containers created in Docker Desktop!"
else
    echo "❌ Failed to create containers"
    exit 1
fi

echo ""
echo "Step 3: Verifying..."
sleep 3
docker ps --format "  ✅ {{.Names}} - {{.Status}} - {{.Ports}}"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   ✅ DONE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎯 Containers should now appear in Docker Desktop GUI!"
echo ""
echo "🌐 Access URLs:"
echo "   - Odoo 16: http://localhost:8068"
echo "   - Odoo 17: http://localhost:8070"
echo "   - Odoo 18: http://localhost:8071"
echo "   - Odoo 19: http://localhost:8072"
echo ""

