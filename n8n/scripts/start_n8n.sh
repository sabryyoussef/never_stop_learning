#!/bin/bash

# Start n8n Docker container

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   🚀 Starting n8n Server"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if n8n container exists
if docker ps -a | grep -q "n8n"; then
    echo "📦 n8n container found"
    
    # Check if it's running
    if docker ps | grep -q "n8n"; then
        echo "✅ n8n is already running!"
        echo ""
        echo "🌐 Access n8n at: http://localhost:5678"
    else
        echo "🔄 Starting n8n container..."
        docker start n8n
        
        if [ $? -eq 0 ]; then
            echo "✅ n8n started successfully!"
            echo ""
            echo "⏳ Waiting for n8n to be ready..."
            sleep 5
            echo ""
            echo "🌐 Access n8n at: http://localhost:5678"
        else
            echo "❌ Failed to start n8n"
            exit 1
        fi
    fi
else
    echo "📦 Creating new n8n container..."
    docker run -d \
        --name n8n \
        -p 5678:5678 \
        -v /home/sabry3/never_stop_learning/n8n/n8n-data:/home/node/.n8n \
        n8nio/n8n
    
    if [ $? -eq 0 ]; then
        echo "✅ n8n container created and started!"
        echo ""
        echo "⏳ Waiting for n8n to be ready..."
        sleep 5
        echo ""
        echo "🌐 Access n8n at: http://localhost:5678"
    else
        echo "❌ Failed to create n8n container"
        exit 1
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

