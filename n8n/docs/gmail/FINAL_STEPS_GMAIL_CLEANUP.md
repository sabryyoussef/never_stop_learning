# Final Steps: Run Gmail Cleanup Workflow

## ✅ Connection Successful!

Your Gmail OAuth2 credential is now connected. Let's set up and run the cleanup workflow.

## 🚀 Next Steps

### Step 1: Import the Workflow

1. **Go to Workflows:**
   - Click **"Workflows"** in the left sidebar
   - Click **"Import from File"** or **"+"** → **"Import from File"**

2. **Select Workflow File:**
   - Navigate to: `/home/sabry3/never_stop_learning/n8n/tests/cleanup_old_gmail.json`
   - Or drag and drop the file into n8n
   - Click **"Import"**

3. **Workflow Should Appear:**
   - You'll see the workflow with nodes:
     - Set Configuration
     - Get Old Messages
     - Filter Messages by Year
     - Delete Message
     - Create Summary

### Step 2: Configure Gmail Nodes

1. **Configure "Get Old Messages" Node:**
   - Click on the **"Get Old Messages"** node
   - Under **"Credential to connect with"**, select your Gmail credential
   - Set **"Limit"** to `10` (for testing!)
   - Leave other settings as default

2. **Configure "Delete Message" Node:**
   - Click on the **"Delete Message"** node
   - Under **"Credential to connect with"**, select the same Gmail credential

### Step 3: Configure Settings (Optional)

1. **Edit "Set Configuration" Node:**
   - **gmailAccount:** `vendorah2@gmail.com` (already set)
   - **deleteBeforeYear:** `2024` (delete emails before 2024)
   - **searchQuery:** `before:2024/1/1` (Gmail search query)
   
   You can adjust:
   - Change year to `2023` if you want to delete before 2023
   - Modify search query for different filters

### Step 4: Test First! ⚠️ CRITICAL

**ALWAYS TEST BEFORE DELETING!**

1. **Dry Run (No Deletion):**
   - **Disconnect** the "Delete Message" node temporarily
   - Click **"Execute Workflow"** or **"Test workflow"** button
   - Wait for execution to complete

2. **Review Results:**
   - Click on **"Filter Messages by Year"** node output
   - Check the emails that will be deleted:
     - Dates (should be before 2024)
     - Subjects
     - Senders
   - **Verify** these are the emails you want to delete

3. **If Correct:**
   - **Reconnect** "Delete Message" node
   - **Run workflow again** to actually delete
   - Monitor the results

4. **If Not Correct:**
   - Adjust the search query or year threshold
   - Test again

### Step 5: Full Execution (After Testing)

Once you're confident:

1. **Gradually Increase Limit:**
   - Start: 10 emails ✅ (tested)
   - Then: 50 emails
   - Then: 100 emails
   - Monitor for errors

2. **Process in Batches:**
   - Gmail API has rate limits
   - Process 100-200 emails at a time
   - If you get rate limit errors, reduce batch size

3. **Monitor Progress:**
   - Check execution logs
   - Verify emails are being deleted
   - Check for any errors

## 📊 Workflow Overview

The workflow will:
1. **Search** for emails matching your query (before 2024)
2. **Filter** them by date to ensure they're old
3. **Delete** each email permanently
4. **Show** summary of deleted emails

## 🎯 Gmail Search Query Examples

You can customize the search query in "Set Configuration" node:

- `before:2024/1/1` - Before January 1, 2024
- `before:2023/12/31` - Before end of 2023
- `before:2024/1/1 is:read` - Only read emails
- `before:2024/1/1 from:example@gmail.com` - From specific sender
- `older_than:2y` - Older than 2 years

## ⚠️ Important Reminders

- ⚠️ **Email deletion is PERMANENT!**
- ✅ **Always test first**
- ✅ **Backup important emails** (use Gmail Takeout if needed)
- ✅ **Start with small batches**
- ✅ **Monitor for errors**

## 🔧 Troubleshooting

### "No messages found"
- Check search query is correct
- Verify emails exist with that criteria
- Try a broader search (e.g., `before:2025/1/1`)

### "Rate limit exceeded"
- Reduce batch size (limit to 50 or 100)
- Add delays between requests
- Process in smaller chunks

### "Permission denied"
- Re-authorize Gmail credential
- Check that Gmail API is enabled
- Verify OAuth scopes include Gmail modify

## ✅ Final Checklist

- [ ] Workflow imported
- [ ] Gmail nodes configured with credential
- [ ] Limit set to 10 for testing
- [ ] Tested with dry run (delete node disconnected)
- [ ] Verified correct emails will be deleted
- [ ] Ready to execute!

---

**Test first, then execute! Good luck! 🚀**

