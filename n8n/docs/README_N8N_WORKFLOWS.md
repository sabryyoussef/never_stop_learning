# N8N Workflows Automation Guide

This guide helps you automate working with the [n8n-community/all-n8n-workflows](https://github.com/n8n-community/all-n8n-workflows) GitHub collection.

## 🚀 Quick Start

### Automated Setup (Recommended)

Use the provided setup script for easy automation:

```bash
# Interactive menu mode
./setup_n8n_workflows.sh

# Or use command-line mode
./setup_n8n_workflows.sh all      # Full setup
./setup_n8n_workflows.sh server   # Start documentation server
./setup_n8n_workflows.sh import   # Import workflows
```

### Manual Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/n8n-community/all-n8n-workflows.git
   cd all-n8n-workflows
   ```

2. **Install Python dependencies:**
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```

3. **Launch the documentation server:**
   ```bash
   python run.py
   ```
   Access the web interface at [http://localhost:8000](http://localhost:8000)

4. **Import workflows into n8n:**
   - **Manual**: Use n8n Editor UI → Menu (☰) → Import workflow
   - **Automated**: Use the Python import script (see below)

## 📚 Features

### Documentation Server
- ⚡ **Sub-100ms response times** with SQLite FTS5 search
- 🔍 **Instant full-text search** across 2,053+ workflows
- 📱 **Responsive design** - works on mobile
- 🌙 **Dark/light themes** with system preference detection
- 📊 **Live statistics** - 365 unique integrations, 29,445 total nodes
- 🎯 **Smart categorization** by trigger type and complexity

### Workflow Collection
- **2,053 workflows** professionally organized
- **365 unique integrations** (Telegram, Slack, Google Drive, etc.)
- **29,445 total nodes** with professional categorization
- **Quality assurance** - All workflows analyzed and categorized

## 🔧 Usage

### Starting the Documentation Server

```bash
cd all-n8n-workflows
source .venv/bin/activate
python run.py
```

**Options:**
- `--host 0.0.0.0` - Make accessible from network
- `--port 3000` - Use custom port
- `--dev` - Development mode with auto-reload
- `--reindex` - Force database reindexing

### Importing Workflows

#### Option 1: Manual Import (Recommended for Testing)
1. Open your n8n Editor UI
2. Click menu (☰) → Import workflow
3. Select any `.json` file from `workflows/` directory
4. **Important**: Update all credentials and webhook URLs before activating

#### Option 2: Automated Bulk Import
```bash
cd all-n8n-workflows
source .venv/bin/activate
python import_workflows.py
```

**Note**: This requires n8n CLI to be installed:
```bash
npm install -g n8n
```

#### Option 3: Docker Import (For n8n Docker Containers)

If you're running n8n in Docker, use the provided helper script:

```bash
# Copy workflow to container
docker cp workflows/your-workflow.json n8n-container:/tmp/

# Import via n8n API (if API is enabled)
# Or use the Docker helper script
./import_to_docker_n8n.sh workflows/your-workflow.json
```

## 🔍 Searching Workflows

### Web Interface
Visit `http://localhost:8000` and use the search interface to:
- Search by keywords (e.g., "telegram", "slack", "automation")
- Filter by trigger type (Manual, Webhook, Scheduled, Complex)
- Filter by complexity (Low, Medium, High)
- Browse by category (Messaging, AI/ML, Database, etc.)

### API Endpoints

```bash
# Search workflows
curl "http://localhost:8000/api/workflows?q=telegram+automation"

# Filter by trigger and complexity
curl "http://localhost:8000/api/workflows?trigger=Webhook&complexity=high"

# Get workflow by filename
curl "http://localhost:8000/api/workflows/2051_Telegram_Webhook_Automation_Webhook.json"

# Download workflow JSON
curl "http://localhost:8000/api/workflows/2051_Telegram_Webhook_Automation_Webhook.json/download"

# Get statistics
curl "http://localhost:8000/api/stats"

# List categories
curl "http://localhost:8000/api/categories"
```

## 📊 Workflow Statistics

### Current Collection Stats
- **Total Workflows**: 2,053 automation workflows
- **Active Workflows**: 215 (10.5% active rate)
- **Total Nodes**: 29,445 (avg 14.3 nodes per workflow)
- **Unique Integrations**: 365 different services and APIs

### Trigger Distribution
- **Complex**: 831 workflows (40.5%) - Multi-trigger systems
- **Webhook**: 519 workflows (25.3%) - API-triggered automations
- **Manual**: 477 workflows (23.2%) - User-initiated workflows
- **Scheduled**: 226 workflows (11.0%) - Time-based executions

### Popular Integrations
- **Communication**: Telegram, Discord, Slack, WhatsApp
- **Cloud Storage**: Google Drive, Google Sheets, Dropbox
- **Databases**: PostgreSQL, MySQL, MongoDB, Airtable
- **AI/ML**: OpenAI, Anthropic, Hugging Face
- **Development**: HTTP Request, Webhook, GraphQL

## 🎯 Categories

The system automatically categorizes workflows into:

- **AI Agent Development**
- **Business Process Automation**
- **Cloud Storage & File Management**
- **Communication & Messaging**
- **Creative Content & Video Automation**
- **Creative Design Automation**
- **CRM & Sales**
- **Data Processing & Analysis**
- **E-commerce & Retail**
- **Financial & Accounting**
- **Marketing & Advertising Automation**
- **Project Management**
- **Social Media Management**
- **Technical Infrastructure & DevOps**
- **Web Scraping & Data Extraction**

## ⚠️ Important Notes

### Security & Privacy
- **Review before use** - All workflows shared as-is for educational purposes
- **Update credentials** - Replace API keys, tokens, and webhooks
- **Test safely** - Verify in development environment first
- **Check permissions** - Ensure proper access rights for integrations

### Compatibility
- **n8n Version** - Compatible with n8n 1.0+ (most workflows)
- **Community Nodes** - Some workflows may require additional node installations
- **API Changes** - External services may have updated their APIs since creation
- **Dependencies** - Verify required integrations before importing

## 🔗 Useful Links

- **Repository**: https://github.com/n8n-community/all-n8n-workflows
- **Official n8n Docs**: https://docs.n8n.io
- **n8n Docker Docs**: https://docs.n8n.io/reference/docker.html
- **n8n Workflows**: https://n8n.io/workflows/
- **n8n Community**: https://community.n8n.io/

## 📝 Additional Resources

### Related Repositories
- [Zie619/n8n-workflows](https://github.com/Zie619/n8n-workflows)
- [Danitilahun/n8n-workflow-templates](https://github.com/Danitilahun/n8n-workflow-templates)
- [enescingoz/awesome-n8n-templates](https://github.com/enescingoz/awesome-n8n-templates)

### Community
- [Reddit r/n8n](https://www.reddit.com/r/n8n/)
- [n8n YouTube Tutorials](https://www.youtube.com/watch?v=MZnHGUPjqsg)

## 🛠 Troubleshooting

### Server Won't Start
```bash
# Check if port is in use
lsof -i :8000

# Use different port
python run.py --port 3000
```

### Import Fails
- Ensure n8n is running and accessible
- Check n8n CLI is installed: `npx n8n --version`
- Verify workflow JSON is valid
- Check n8n logs for detailed error messages

### Database Issues
```bash
# Force reindexing
python run.py --reindex

# Or delete database and restart
rm database/workflows.db
python run.py
```

## 📄 License

This collection includes workflows from various sources. Please review individual workflow licenses and terms of use.

---

**Happy Automating! 🚀**

