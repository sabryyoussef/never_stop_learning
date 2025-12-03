# Quick Setup: Add n8n-MCP to Cursor

## 🚀 Fastest Method (3 Steps)

### Step 1: Open Cursor Settings
- Press `Ctrl+,` (or `Cmd+,` on Mac)
- Or: File → Preferences → Settings

### Step 2: Find MCP Servers
- Search for "MCP" in the settings search bar
- Or navigate to: Features → MCP Servers

### Step 3: Add n8n-MCP Server

Click "Add Server" and configure:

**Server Name:** `n8n-mcp`

**Command:** `node`

**Arguments:**
```
/home/sabry3/never_stop_learning/n8n/n8n-mcp/dist/mcp/index.js
```

**Environment Variables:**
```
MCP_MODE=stdio
LOG_LEVEL=error
DISABLE_CONSOLE_OUTPUT=true
N8N_API_URL=http://localhost:5678
N8N_API_KEY=
```

### Step 4: Restart Cursor
Close and reopen Cursor for changes to take effect.

## ✅ Done!

Now you can ask Cursor to build n8n workflows:
- "Create an n8n workflow to list files in Google Drive"
- "Build a workflow that scrapes product prices"
- "Make a workflow to auto-organize downloaded files"

---

**Alternative: Using npx (Simpler)**

If the above doesn't work, use npx instead:

**Command:** `npx`
**Arguments:** `n8n-mcp`

Same environment variables as above.

