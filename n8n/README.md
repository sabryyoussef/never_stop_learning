# n8n Workspace - Organized & Ready! 🚀

## 📁 Directory Structure

```
n8n/
├── workflows/          # All n8n workflow JSON files (21 workflows)
├── docs/               # Documentation organized by category
│   ├── setup/          # Setup guides (MCP, Cursor, etc.)
│   ├── gmail/          # Gmail-related guides
│   ├── facebook/       # Facebook posting guides
│   ├── learning/       # Learning workflows & guides
│   └── troubleshooting/# Fix guides & troubleshooting
├── scripts/            # Helper scripts (4 scripts)
├── config/             # Configuration files
├── tests/              # Test files and examples
├── all-n8n-workflows/  # Cloned n8n workflows repository
└── n8n-mcp/           # n8n-MCP server
```

## 🚀 Quick Start

### For Learning (No Configuration!):
```bash
# Import and run - that's it!
workflows/simple_big_output.json      # Get 100 posts
workflows/simple_news_scraper.json    # Get 50+ news articles
```

### For Gmail Cleanup:
1. See: `docs/gmail/GMAIL_CLEANUP_GUIDE.md`
2. Import: `workflows/cleanup_old_gmail.json`
3. Configure OAuth credentials

### For Facebook Posting:
1. See: `docs/facebook/FACEBOOK_POSTING_GUIDE.md`
2. Import: `workflows/post_to_facebook.json`
3. Configure Facebook API

## 📚 Documentation by Category

### Setup Guides (`docs/setup/`)
- `N8N_MCP_SETUP.md` - n8n-MCP server setup
- `CURSOR_MCP_CONFIG.md` - Cursor MCP configuration
- `CLAUDE_DESKTOP_CONFIG.md` - Claude Desktop setup
- `HOW_N8N_HELPS_UBUNTU.md` - n8n benefits for Ubuntu

### Gmail Guides (`docs/gmail/`)
- `GMAIL_CLEANUP_GUIDE.md` - Complete Gmail cleanup guide
- `FIX_OAUTH_VERIFICATION.md` - OAuth verification fixes
- `FIX_OAUTH_CLIENT.md` - OAuth client setup
- `FIX_REDIRECT_URI.md` - Redirect URI configuration

### Learning Guides (`docs/learning/`)
- `SIMPLE_LEARNING_WORKFLOWS.md` - Simple workflows for learning
- `SIMPLE_TEST_GUIDE.md` - Test workflow guide
- `README_READABLE.md` - Readable output guide

### Troubleshooting (`docs/troubleshooting/`)
- `FIX_GET_MESSAGES_NODE.md` - Gmail node fixes
- `UPDATE_GMAIL_NODE.md` - Node update guide
- `CONFIGURE_GET_ALL.md` - Get All configuration

## 📂 Workflows (`workflows/`)

### Learning Workflows (No Config Needed):
- `simple_big_output.json` ⭐ - Get 100 posts (RECOMMENDED)
- `simple_news_scraper.json` - Get 50+ news articles
- `simple_test.json` - Basic test workflow

### Gmail Workflows:
- `cleanup_old_gmail.json` - Gmail cleanup (Gmail API)
- `cleanup_old_gmail_http.json` - Gmail cleanup (HTTP)
- `delete_old_gmail_simple.json` - Simple Gmail delete

### Social Media:
- `post_to_facebook.json` - Post to Facebook

### Web Scraping:
- `scrape_vetution_products.json` - Scrape Vetution website

### Storage:
- `list_all_documents.json` - List Google Drive documents
- `list_folders_basic.json` - List folders

## 🔧 Scripts (`scripts/`)

- `start_n8n_mcp.sh` - Start n8n-MCP server
- `import_to_docker_n8n.sh` - Import workflows to Docker
- `setup_n8n_workflows.sh` - Setup automation
- `test_workflow.sh` - Validate workflows

## ⚙️ Configuration (`config/`)

- `cursor_mcp_config.json` - Cursor MCP configuration
- `claude_desktop_config_example.json` - Claude Desktop example
- `qbath_client.md` - OAuth credentials (keep private!)

## 🎯 Most Used Workflows

1. **Learning:** `workflows/simple_big_output.json`
2. **Gmail Cleanup:** `workflows/cleanup_old_gmail.json`
3. **Facebook Posting:** `workflows/post_to_facebook.json`
4. **Web Scraping:** `workflows/scrape_vetution_products.json`

## 🔗 Quick Links

- **n8n:** http://localhost:5678
- **n8n-MCP:** Configured in `~/.cursor/mcp.json`
- **Docker n8n:** Container `n8n`

## 📖 Resources

- **n8n Docs:** https://docs.n8n.io
- **n8n-MCP:** https://github.com/czlonkowski/n8n-mcp
- **Workflow Templates:** `all-n8n-workflows/workflows/`

---

**Workspace organized and ready to use! 🎉**
