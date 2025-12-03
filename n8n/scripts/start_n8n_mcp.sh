#!/bin/bash
###############################################################################
# Start n8n-MCP Server
# Model Context Protocol server for n8n workflow automation
###############################################################################

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

MCP_DIR="/home/sabry3/never_stop_learning/n8n/n8n-mcp"

# Check if directory exists
if [ ! -d "$MCP_DIR" ]; then
    print_warning "n8n-mcp directory not found. Cloning..."
    cd /home/sabry3/never_stop_learning/n8n
    git clone https://github.com/czlonkowski/n8n-mcp.git
fi

cd "$MCP_DIR"

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    print_info "Installing dependencies..."
    npm install
fi

# Check if built
if [ ! -d "dist" ]; then
    print_info "Building project..."
    npm run build
fi

# Check if database exists
if [ ! -f "n8n-nodes.db" ] || [ ! -s "n8n-nodes.db" ]; then
    print_info "Initializing database..."
    npm run rebuild
fi

print_info "Starting n8n-MCP server..."

# Check mode
MODE=${1:-stdio}

if [ "$MODE" = "http" ]; then
    print_info "Starting in HTTP mode..."
    print_info "Server will be available for HTTP connections"
    export MCP_MODE=http
    export PORT=${PORT:-8100}
    export LOG_LEVEL=${LOG_LEVEL:-info}
    npm run start:http
elif [ "$MODE" = "stdio" ]; then
    print_info "Starting in stdio mode (for Claude Desktop)..."
    export MCP_MODE=stdio
    export LOG_LEVEL=error
    export DISABLE_CONSOLE_OUTPUT=true
    npm start
else
    print_warning "Unknown mode: $MODE"
    print_info "Usage: $0 [stdio|http]"
    print_info "  stdio - For Claude Desktop (default)"
    print_info "  http  - For HTTP access"
    exit 1
fi

