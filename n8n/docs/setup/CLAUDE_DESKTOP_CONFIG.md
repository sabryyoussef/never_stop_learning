# Claude Desktop Configuration for n8n-MCP

## 📋 Quick Setup

n8n-MCP is installed and ready! Now configure Claude Desktop to use it.

## 🔧 Configuration Steps

### Step 1: Find Claude Desktop Config File

**Linux:** `~/.config/Claude/claude_desktop_config.json`

If the file doesn't exist, create it:

```bash
mkdir -p ~/.config/Claude
touch ~/.config/Claude/claude_desktop_config.json
```

### Step 2: Add n8n-MCP Configuration

Edit the config file and add:

```json
{
  "mcpServers": {
    "n8n-mcp": {
      "command": "node",
      "args": [
        "/home/sabry3/never_stop_learning/n8n/n8n-mcp/dist/mcp/index.js"
      ],
      "env": {
        "MCP_MODE": "stdio",
        "LOG_LEVEL": "error",
        "DISABLE_CONSOLE_OUTPUT": "true",
        "N8N_API_URL": "http://localhost:5678",
        "N8N_API_KEY": ""
      }
    }
  }
}
```

### Step 3: Optional - Add n8n API Integration

If you want Claude to manage workflows in your n8n instance:

1. **Get n8n API Key:**
   - Open http://localhost:5678
   - Go to Settings → API
   - Create API key
   - Copy the key

2. **Update config:**
   ```json
   "N8N_API_URL": "http://localhost:5678",
   "N8N_API_KEY": "your-actual-api-key-here"
   ```

### Step 4: Restart Claude Desktop

**Important:** You must restart Claude Desktop for changes to take effect!

## 🎯 What You Can Do Now

After restarting Claude Desktop, you can ask Claude:

### Example Prompts:

1. **"Create an n8n workflow to list all files in Google Drive"**
2. **"Build a workflow that scrapes product prices from a website"**
3. **"Make a workflow to auto-organize downloaded files"**
4. **"Create a workflow that posts to Facebook daily"**
5. **"Build a workflow to monitor a website for changes"**

### Claude Will:
- ✅ Understand all 541 n8n nodes
- ✅ Use 2,709 workflow templates
- ✅ Create complete, working workflows
- ✅ Validate and fix errors
- ✅ Optimize workflow structure

## 📊 n8n-MCP Capabilities

- **541 n8n nodes** - Full documentation
- **2,709 templates** - Real-world examples
- **271 AI tools** - Advanced automation
- **100% node coverage** - Every node documented

## 🔗 Resources

- **n8n-MCP Repo:** https://github.com/czlonkowski/n8n-mcp
- **Documentation:** https://www.n8n-mcp.com/
- **Your n8n:** http://localhost:5678

## ⚠️ Important Notes

- **Never edit production workflows directly!**
- Always test workflows before deploying
- Make backups of important workflows
- Validate changes before using in production

---

**Ready to build workflows with AI! 🚀**

