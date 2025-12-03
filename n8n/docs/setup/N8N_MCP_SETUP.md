# n8n-MCP Setup Complete! 🎉

## ✅ What is n8n-MCP?

**n8n-MCP** is a Model Context Protocol server that gives AI assistants (like Claude) the ability to:
- 📚 Understand all 541 n8n nodes
- 🔧 Build n8n workflows automatically
- 💡 Use 2,709 workflow templates
- 🤖 Create complex automations with AI assistance

## 🚀 Server Status

The n8n-MCP server is now running!

### Access Modes:

1. **HTTP Mode** (Currently Running)
   - **URL:** http://localhost:3000
   - **Health Check:** http://localhost:3000/health
   - **For:** Remote access, testing, integration

2. **stdio Mode** (For Claude Desktop)
   - Run: `npm start` (in n8n-mcp directory)
   - **For:** Direct Claude Desktop integration

## 📋 What You Can Do Now

### Option 1: Use with Claude Desktop

Configure Claude Desktop to use n8n-MCP:

**Linux config file:** `~/.config/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "n8n-mcp": {
      "command": "node",
      "args": ["/home/sabry3/never_stop_learning/n8n/n8n-mcp/dist/mcp/index.js"],
      "env": {
        "MCP_MODE": "stdio",
        "LOG_LEVEL": "error",
        "DISABLE_CONSOLE_OUTPUT": "true",
        "N8N_API_URL": "http://localhost:5678",
        "N8N_API_KEY": "your-api-key-if-needed"
      }
    }
  }
}
```

**Then restart Claude Desktop** and you can ask Claude to build n8n workflows for you!

### Option 2: Use HTTP API

The server is running on **http://localhost:3000**

You can:
- Test endpoints
- Integrate with other tools
- Use with HTTP-based MCP clients

## 🎯 Capabilities

With n8n-MCP, AI can:

### 📚 Documentation Access
- ✅ Access all 541 n8n nodes
- ✅ Read node properties and documentation
- ✅ Understand node operations
- ✅ View 2,709 workflow templates

### 🔧 Workflow Building
- ✅ Create new workflows
- ✅ Update existing workflows
- ✅ Validate workflows
- ✅ Import/export workflows

### 💡 Smart Features
- ✅ Auto-fix workflow errors
- ✅ Suggest node configurations
- ✅ Use real-world templates
- ✅ Optimize workflow structure

## 🔗 Integration with Your n8n

To connect n8n-MCP with your running n8n instance:

1. **Get n8n API Key:**
   - Open n8n: http://localhost:5678
   - Go to Settings → API
   - Create API key

2. **Update Environment:**
   ```bash
   export N8N_API_URL="http://localhost:5678"
   export N8N_API_KEY="your-api-key"
   ```

3. **Restart n8n-MCP:**
   ```bash
   cd /home/sabry3/never_stop_learning/n8n/n8n-mcp
   npm run start:http
   ```

## 📊 Server Information

- **Location:** `/home/sabry3/never_stop_learning/n8n/n8n-mcp`
- **Version:** 2.22.14
- **Nodes Loaded:** 541/541 (100%)
- **Templates:** 2,709 available
- **Database:** Pre-built and ready

## 🛠️ Useful Commands

```bash
# Start HTTP server
cd /home/sabry3/never_stop_learning/n8n/n8n-mcp
npm run start:http

# Start stdio mode (for Claude Desktop)
npm start

# Rebuild database
npm run rebuild

# Validate setup
npm run validate

# Test nodes
npm run test-nodes
```

## 🎓 How to Use

### With Claude Desktop:

1. **Configure Claude Desktop** (see config above)
2. **Restart Claude Desktop**
3. **Ask Claude:**
   - "Create an n8n workflow to backup files to Google Drive"
   - "Build a workflow to monitor a website"
   - "Make a workflow that posts to Facebook daily"

### Example Prompts:

- "Create an n8n workflow that lists all files in Google Drive"
- "Build a workflow to scrape product prices from a website"
- "Make a workflow that sends daily email summaries"
- "Create a workflow to auto-organize downloaded files"

## 🔗 Resources

- **Repository:** https://github.com/czlonkowski/n8n-mcp
- **Documentation:** https://www.n8n-mcp.com/
- **n8n Docs:** https://docs.n8n.io

## ⚠️ Important Notes

- **Never edit production workflows directly with AI!**
- Always test workflows before deploying
- Make backups of important workflows
- Validate changes before using in production

---

**n8n-MCP is ready to help you build workflows with AI! 🚀**

