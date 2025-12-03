# Quick Fix: Import Correct Workflow

## ⚠️ Issue
You imported the **wrong workflow**! You have:
- ❌ "Cleanup Old Gmail (Browser Automation)" - This is just a concept, doesn't work!

You need:
- ✅ "Cleanup Old Gmail" - The actual Gmail API workflow

## ✅ Solution: Import Correct Workflow

### Step 1: Delete Current Workflow (Optional)

1. In n8n, click the workflow name at the top
2. Click "Delete" or trash icon
3. Confirm deletion

**OR** just import the new one - you can have multiple workflows.

### Step 2: Import Correct Workflow

1. **Click "Workflows"** in left sidebar
2. **Click "+"** or **"Import from File"**
3. **Select this file:**
   ```
   /home/sabry3/never_stop_learning/n8n/tests/cleanup_old_gmail.json
   ```
4. **Click "Import"**

### Step 3: Verify Correct Workflow

The correct workflow should have these nodes:
- ✅ "Set Configuration"
- ✅ "Get Old Messages" (Gmail node)
- ✅ "Filter Messages by Year" (Code node)
- ✅ "Delete Message" (Gmail node)
- ✅ "Create Summary"

**NOT** "Browser Automation Concept" - that's the wrong one!

### Step 4: Configure Gmail Nodes

1. **Click "Get Old Messages" node:**
   - Under "Credential to connect with", select your Gmail credential
   - Set "Limit" to `10` (for testing!)

2. **Click "Delete Message" node:**
   - Under "Credential to connect with", select your Gmail credential

### Step 5: Test First!

1. **Disconnect "Delete Message" node** (temporarily)
2. **Click "Execute workflow"** button
3. **Check "Filter Messages by Year" output**
4. **Verify** the emails are correct
5. **If correct:** Reconnect delete node and run again

---

**Import the correct workflow and you're ready to go! 🚀**

