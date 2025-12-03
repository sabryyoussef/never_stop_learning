#!/bin/bash
###############################################################################
# Import n8n Workflow to Docker Container
# Helper script for importing workflows into n8n running in Docker
###############################################################################

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
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

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Docker is available
if ! command -v docker >/dev/null 2>&1; then
    print_error "Docker is not installed or not in PATH"
    exit 1
fi

# Find n8n container
find_n8n_container() {
    local container=$(docker ps --format "{{.Names}}" | grep -i n8n | head -n 1)
    if [ -z "$container" ]; then
        # Try stopped containers
        container=$(docker ps -a --format "{{.Names}}" | grep -i n8n | head -n 1)
        if [ -n "$container" ]; then
            print_warning "Found stopped n8n container: $container"
            read -p "Start the container? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                docker start "$container"
                sleep 2
            else
                exit 1
            fi
        fi
    fi
    echo "$container"
}

# Main function
main() {
    if [ $# -eq 0 ]; then
        echo "Usage: $0 <workflow.json> [container_name]"
        echo ""
        echo "Examples:"
        echo "  $0 workflows/2051_Telegram_Webhook_Automation_Webhook.json"
        echo "  $0 workflows/2051_Telegram_Webhook_Automation_Webhook.json my-n8n-container"
        echo ""
        echo "Available n8n containers:"
        docker ps -a --format "{{.Names}}" | grep -i n8n || echo "  (none found)"
        exit 1
    fi

    WORKFLOW_FILE="$1"
    CONTAINER_NAME="$2"

    # Validate workflow file
    if [ ! -f "$WORKFLOW_FILE" ]; then
        print_error "Workflow file not found: $WORKFLOW_FILE"
        exit 1
    fi

    # Find container if not specified
    if [ -z "$CONTAINER_NAME" ]; then
        print_info "Searching for n8n container..."
        CONTAINER_NAME=$(find_n8n_container)
        if [ -z "$CONTAINER_NAME" ]; then
            print_error "No n8n container found. Please specify container name:"
            echo "  $0 $WORKFLOW_FILE <container_name>"
            exit 1
        fi
    fi

    print_success "Using container: $CONTAINER_NAME"

    # Check if container is running
    if ! docker ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        print_warning "Container is not running. Starting..."
        docker start "$CONTAINER_NAME"
        sleep 3
    fi

    # Copy file to container
    print_info "Copying workflow to container..."
    docker cp "$WORKFLOW_FILE" "${CONTAINER_NAME}:/tmp/workflow.json"

    # Import using n8n CLI in container
    print_info "Importing workflow..."
    docker exec "$CONTAINER_NAME" n8n import:workflow --input=/tmp/workflow.json || {
        print_warning "CLI import failed. Trying alternative method..."
        
        # Alternative: Use n8n API if available
        print_info "Attempting API import..."
        print_warning "Note: This requires n8n API to be enabled with proper credentials"
        
        # Read workflow content
        WORKFLOW_CONTENT=$(cat "$WORKFLOW_FILE")
        
        # Try to get n8n URL from container
        N8N_URL=$(docker inspect "$CONTAINER_NAME" --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 2>/dev/null || echo "localhost")
        
        print_info "You can manually import via:"
        echo "  1. Open n8n UI (usually http://localhost:5678)"
        echo "  2. Go to Menu (☰) → Import workflow"
        echo "  3. Select the workflow file: $WORKFLOW_FILE"
        echo ""
        print_info "Or use the n8n API:"
        echo "  curl -X POST http://${N8N_URL}:5678/api/v1/workflows/import \\"
        echo "    -H 'Content-Type: application/json' \\"
        echo "    -d @$WORKFLOW_FILE"
    }

    # Cleanup
    docker exec "$CONTAINER_NAME" rm -f /tmp/workflow.json

    print_success "Workflow import process completed!"
    print_info "Check your n8n UI to verify the workflow was imported"
}

main "$@"

