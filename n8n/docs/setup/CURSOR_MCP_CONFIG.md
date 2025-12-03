# Cursor MCP Configuration for n8n-MCP

## 🎯 Quick Setup Guide

### Option 1: Using Cursor Settings UI (Recommended)

1. **Open Cursor IDE**
2. **Go to Settings:**
   - Press `Ctrl+,` (or `Cmd+,` on Mac)
   - Or: File → Preferences → Settings
3. **Navigate to MCP Servers:**
   - Search for "MCP" in settings
   - Or go to: Features → MCP Servers
4. **Add New Server:**
   - Click "Add Server" or "+"
   - Name: `n8n-mcp`
5. **Configure Server:**
   - **Command:** `node`
   - **Arguments:** 
     ```json
     ["/home/sabry3/never_stop_learning/n8n/n8n-mcp/dist/mcp/index.js"]
     ```
   - **Environment Variables:**
     ```json
     {
       "MCP_MODE": "stdio",
       "LOG_LEVEL": "error",
       "DISABLE_CONSOLE_OUTPUT": "true",
       "N8N_API_URL": "http://localhost:5678",
       "N8N_API_KEY": ""
     }
     ```
6. **Save and Restart Cursor**

### Option 2: Using Config File (If Available)

If Cursor uses a config file, it's typically at:
- `~/.config/Cursor/User/settings.json`
- Or `~/.cursor/mcp.json`

Add this configuration:

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

### Option 3: Using npx (Simpler, but downloads each time)

If you prefer using npx (no local path needed):

```json
{
  "mcpServers": {
    "n8n-mcp": {
      "command": "npx",
      "args": ["n8n-mcp"],
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

## 🔧 Optional: Add n8n API Integration

If you want Cursor to manage workflows in your n8n instance:

1. **Get n8n API Key:**
   - Open http://localhost:5678
   - Go to Settings → API
   - Create API key
   - Copy the key

2. **Update Environment Variable:**
   ```json
   "N8N_API_KEY": "your-actual-api-key-here"
   ```

## ✅ Verify Installation

After configuring and restarting Cursor:

1. **Check MCP Status:**
   - Look for MCP indicators in Cursor
   - Check if n8n-MCP appears in MCP servers list

2. **Test with AI:**
   - Ask Cursor: "Create an n8n workflow to list files in Google Drive"
   - Cursor should now understand n8n nodes and create workflows

## 🎯 What You Can Do Now

After setup, you can ask Cursor to:

- ✅ "Create an n8n workflow to backup files to Google Drive"
- ✅ "Build a workflow that scrapes product prices"
- ✅ "Make a workflow to auto-organize downloaded files"
- ✅ "Create a workflow that posts to Facebook daily"
- ✅ "Build a workflow to monitor a website for changes"

## 📊 n8n-MCP Capabilities

- **541 n8n nodes** - Full documentation
- **2,709 templates** - Real-world examples
- **271 AI tools** - Advanced automation
- **100% node coverage** - Every node documented

## 🔗 Resources

- **n8n-MCP Repo:** https://github.com/czlonkowski/n8n-mcp
- **Documentation:** https://www.n8n-mcp.com/
- **Your n8n:** http://localhost:5678

## ⚠️ Troubleshooting

### Server Not Starting
- Check that Node.js is installed: `node --version`
- Verify the path to n8n-mcp is correct
- Check Cursor's MCP logs for errors

### Can't Find MCP Settings
- Update Cursor to the latest version
- MCP support may require Cursor Pro/Team
- Check Cursor's documentation for MCP setup

### Connection Issues
- Ensure n8n is running: http://localhost:5678
- Verify N8N_API_URL is correct
- Check firewall settings

---

**Ready to build workflows with AI in Cursor! 🚀**

