# Use HTTP Request Workflow (No Node Update Needed)

## ✅ Solution: HTTP Request Workflow

Since your Gmail node can't be updated, I created an alternative workflow that uses **HTTP Request** nodes to call Gmail API directly.

## 🚀 Import New Workflow

1. **In n8n:**
   - Go to **Workflows** → **Import from File**
   - Select: `/home/sabry3/never_stop_learning/n8n/tests/cleanup_old_gmail_http.json`
   - Click **Import**

## 🔧 Configure HTTP Request Nodes

The workflow has 3 HTTP Request nodes that need your Gmail credential:

1. **"Get Old Messages (HTTP)"** node:
   - Click on it
   - Under **"Authentication"**, select **"Gmail OAuth2 API"**
   - Select your Gmail credential

2. **"Get Message Details"** node:
   - Same: Select Gmail OAuth2 API credential

3. **"Delete Message (HTTP)"** node:
   - Same: Select Gmail OAuth2 API credential

## 📋 How It Works

1. **Set Configuration** - Sets search parameters
2. **Get Old Messages (HTTP)** - Calls Gmail API to get message IDs
3. **Extract Message IDs** - Extracts IDs from response
4. **Get Message Details** - Gets full details for each message
5. **Filter Messages by Year** - Filters by date
6. **Delete Message (HTTP)** - Deletes each message
7. **Create Summary** - Shows results

## ⚠️ Test First!

1. **Disconnect "Delete Message (HTTP)" node** (temporarily)
2. **Click "Execute workflow"**
3. **Check "Filter Messages by Year" output**
4. **Verify** the emails are correct
5. **If correct:** Reconnect delete node and run again

## ✅ Advantages

- ✅ Works with any n8n version
- ✅ No node update needed
- ✅ Direct Gmail API calls
- ✅ More control over the process

---

**Import the HTTP workflow and configure the credentials! 🚀**

