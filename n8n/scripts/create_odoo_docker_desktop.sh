#!/bin/bash

# Create Odoo 16, 17, 18, 19 in Docker Desktop

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🐘 Creating Odoo Containers in Docker Desktop"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Switch to Docker Desktop context
docker context use desktop-linux

if [ $? -ne 0 ]; then
    echo "❌ Failed to switch to Docker Desktop context"
    echo "Make sure Docker Desktop is running"
    exit 1
fi

echo "📍 Using Docker Desktop context"
echo ""

# Create Odoo containers
for version in 16 17 18 19; do
    echo "📦 Creating Odoo $version..."
    
    # Create container name
    CONTAINER_NAME="odoo-$version"
    
    # Create Odoo container
    docker run -d \
        --name "$CONTAINER_NAME" \
        -p "806$version:8069" \
        -e POSTGRES_HOST=db \
        -e POSTGRES_USER=odoo \
        -e POSTGRES_PASSWORD=odoo \
        -e POSTGRES_DB=postgres \
        odoo:$version
    
    if [ $? -eq 0 ]; then
        echo "   ✅ Odoo $version created successfully"
        echo "   🌐 Access at: http://localhost:806$version"
    else
        echo "   ⚠️  Odoo $version creation had issues"
    fi
    echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   ✅ Odoo Containers Created!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Created Containers:"
docker ps -a --filter "name=odoo" --format "  - {{.Names}} ({{.Status}}) - Port: {{.Ports}}"
echo ""
echo "🌐 Access URLs:"
echo "  - Odoo 16: http://localhost:80616"
echo "  - Odoo 17: http://localhost:80617"
echo "  - Odoo 18: http://localhost:80618"
echo "  - Odoo 19: http://localhost:80619"
echo ""
echo "💡 Note: These containers need PostgreSQL databases"
echo "   You may want to create a docker-compose.yml for proper setup"
echo ""

