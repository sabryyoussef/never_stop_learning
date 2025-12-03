# Direct Delete Old Gmail Messages

## ⚠️ CRITICAL WARNING

**Email deletion is PERMANENT!** Once deleted, emails cannot be recovered!

## 🚀 Quick Setup

### Current Workflow (You're Already There!)

You have:
- ✅ "Get Old Messages" node configured
- ✅ Operation: Get Many
- ✅ Limit: 10
- ✅ Search Query: `before:2024/1/1`

### To Delete Directly:

1. **Make sure "Delete Message" node is connected:**
   - Check that "Get Old Messages" → "Delete Message" is connected
   - If not, connect them

2. **Configure "Delete Message" node:**
   - Click on "Delete Message" node
   - Select your Gmail credential
   - Message ID should be: `={{ $json.id }}` (from previous node)

3. **Execute:**
   - Click "Execute workflow" button
   - **This will delete emails permanently!**

## ⚠️ SAFE APPROACH: Test First

### Step 1: Dry Run (No Deletion)

1. **Disconnect "Delete Message" node:**
   - Click on the connection line
   - Delete the connection (or disable the node)

2. **Execute workflow:**
   - Click "Execute workflow"
   - Check "Get Old Messages" output
   - **Verify** these are the emails you want to delete

3. **If correct:**
   - Reconnect "Delete Message" node
   - Execute again to actually delete

## 🎯 Direct Execution (If You're Confident)

If you're sure about the emails:

1. **Verify settings:**
   - Limit: 10 (start small!)
   - Search Query: `before:2024/1/1`
   - Credential: Set correctly

2. **Execute:**
   - Click "Execute workflow"
   - Monitor the execution
   - Check summary

3. **Gradually increase:**
   - After successful test, increase limit to 50
   - Then 100, 200, etc.

## 📋 Workflow Steps

1. **Get Old Messages:**
   - Searches for emails before 2024
   - Returns up to 10 messages

2. **Delete Message:**
   - Deletes each message permanently
   - ⚠️ **Cannot be undone!**

3. **Summary:**
   - Shows how many messages were deleted

## ⚙️ Adjust Settings

### Change Year:
In "Get Old Messages" node, change search query:
- `before:2023/1/1` - Before 2023
- `before:2022/1/1` - Before 2022

### Change Limit:
- Start: 10 (testing)
- Then: 50, 100, 200
- Or set "Return All" to Yes (gets all matching)

### More Specific Search:
- `before:2024/1/1 is:read` - Only read emails
- `before:2024/1/1 from:example@gmail.com` - From specific sender
- `older_than:2y` - Older than 2 years

## 🚨 Final Checklist

Before executing:
- [ ] Limit set to 10 (for testing)
- [ ] Search query verified: `before:2024/1/1`
- [ ] Credential configured
- [ ] **Tested with dry run** (recommended!)
- [ ] Ready to delete permanently

---

**⚠️ Remember: Deletion is permanent! Test first if possible! 🚀**

