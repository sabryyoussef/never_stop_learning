#!/bin/bash
###############################################################################
# N8N Workflows Automation Setup Script
# Automates the setup and usage of the n8n-community/all-n8n-workflows repo
###############################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_DIR="all-n8n-workflows"
REPO_URL="https://github.com/n8n-community/all-n8n-workflows.git"
VENV_DIR=".venv"
PORT=8000

# Print colored messages
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

print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Step 1: Clone repository
clone_repo() {
    print_header "Step 1: Cloning Repository"
    
    if [ -d "$REPO_DIR" ]; then
        print_warning "Repository directory already exists: $REPO_DIR"
        read -p "Do you want to update it? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Updating repository..."
            cd "$REPO_DIR" && git pull && cd ..
            print_success "Repository updated"
        else
            print_info "Skipping clone step"
        fi
    else
        print_info "Cloning repository from GitHub..."
        git clone "$REPO_URL" "$REPO_DIR"
        print_success "Repository cloned successfully"
    fi
}

# Step 2: Setup Python virtual environment
setup_venv() {
    print_header "Step 2: Setting Up Python Environment"
    
    cd "$REPO_DIR"
    
    if [ ! -d "$VENV_DIR" ]; then
        print_info "Creating Python virtual environment..."
        python3 -m venv "$VENV_DIR"
        print_success "Virtual environment created"
    else
        print_info "Virtual environment already exists"
    fi
    
    print_info "Activating virtual environment and installing dependencies..."
    source "$VENV_DIR/bin/activate"
    pip install -q -r requirements.txt
    print_success "Dependencies installed"
    
    cd ..
}

# Step 3: Start documentation server
start_server() {
    print_header "Step 3: Starting Documentation Server"
    
    cd "$REPO_DIR"
    source "$VENV_DIR/bin/activate"
    
    print_info "Starting FastAPI documentation server..."
    print_info "Server will be available at: http://localhost:$PORT"
    print_warning "Press Ctrl+C to stop the server"
    echo
    
    python run.py --host 0.0.0.0 --port "$PORT"
}

# Step 4: Import workflows (optional)
import_workflows() {
    print_header "Step 4: Import Workflows into n8n"
    
    cd "$REPO_DIR"
    
    if ! command_exists npx; then
        print_error "npx not found. Please install Node.js and npm first."
        print_info "Visit: https://nodejs.org/"
        return 1
    fi
    
    print_info "Checking n8n CLI availability..."
    if ! npx n8n --version >/dev/null 2>&1; then
        print_warning "n8n CLI not found. Installing..."
        npm install -g n8n
    fi
    
    print_info "Starting workflow import..."
    print_warning "Make sure your n8n instance is running and accessible"
    read -p "Continue with import? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        source "$VENV_DIR/bin/activate"
        python import_workflows.py
    else
        print_info "Import skipped"
    fi
    
    cd ..
}

# Main menu
show_menu() {
    clear
    print_header "N8N Workflows Automation Setup"
    echo "1) Clone/Update Repository"
    echo "2) Setup Python Environment"
    echo "3) Start Documentation Server"
    echo "4) Import Workflows to n8n"
    echo "5) Full Setup (All Steps)"
    echo "6) Exit"
    echo
    read -p "Select an option (1-6): " choice
    
    case $choice in
        1)
            clone_repo
            ;;
        2)
            setup_venv
            ;;
        3)
            start_server
            ;;
        4)
            import_workflows
            ;;
        5)
            clone_repo
            setup_venv
            echo
            print_success "Setup complete!"
            print_info "You can now:"
            print_info "  - Start the server: ./setup_n8n_workflows.sh (option 3)"
            print_info "  - Import workflows: ./setup_n8n_workflows.sh (option 4)"
            ;;
        6)
            print_info "Exiting..."
            exit 0
            ;;
        *)
            print_error "Invalid option"
            ;;
    esac
}

# Check if script is run with arguments
if [ $# -eq 0 ]; then
    # Interactive mode
    while true; do
        show_menu
        echo
        read -p "Press Enter to continue..."
    done
else
    # Command-line mode
    case "$1" in
        clone)
            clone_repo
            ;;
        setup)
            setup_venv
            ;;
        server|start)
            start_server
            ;;
        import)
            import_workflows
            ;;
        all|full)
            clone_repo
            setup_venv
            print_success "Setup complete! Run './setup_n8n_workflows.sh server' to start the documentation server"
            ;;
        *)
            echo "Usage: $0 [clone|setup|server|import|all]"
            echo ""
            echo "Commands:"
            echo "  clone   - Clone/update the repository"
            echo "  setup   - Setup Python environment"
            echo "  server  - Start documentation server"
            echo "  import  - Import workflows to n8n"
            echo "  all     - Run full setup (clone + setup)"
            echo ""
            echo "Or run without arguments for interactive menu"
            exit 1
            ;;
    esac
fi

