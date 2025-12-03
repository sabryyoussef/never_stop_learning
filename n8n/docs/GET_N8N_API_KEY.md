# How to Get n8n API Key

## 🎯 Step-by-Step Guide

### Step 1: Access n8n
1. Open your browser
2. Go to: **http://localhost:5678**
3. Log in to n8n (if required)

### Step 2: Navigate to API Settings
1. Click on your **profile icon** (top right)
2. Select **Settings**
3. Click on **API** in the left sidebar

### Step 3: Create API Key
1. Click **"Create API Key"** button
2. Give it a name (e.g., "Cursor MCP")
3. Copy the generated API key
   - ⚠️ **Important:** Copy it immediately - you won't be able to see it again!

### Step 4: Add to mcp.json
The API key will look something like:
```
n8n_api_abc123def456...
```

Add it to your `mcp.json` file in the `N8N_API_KEY` field.

## 🔒 Security Note

- Keep your API key secret
- Don't commit it to public repositories
- You can regenerate it anytime if needed

## ✅ After Adding the Key

1. Save the `mcp.json` file
2. Restart Cursor
3. n8n-MCP will now be able to manage workflows in your n8n instance!

