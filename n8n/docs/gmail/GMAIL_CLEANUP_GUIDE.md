# Gmail Cleanup Workflow Guide

## 🎯 Goal
Login to Gmail account `vendorah2@gmail.com` and delete old email messages from previous years.

## ⚠️ Important Warnings

1. **Permanent Deletion**: This workflow permanently deletes emails - they cannot be recovered!
2. **Test First**: Always test with a small batch before deleting many emails
3. **Backup**: Consider exporting important emails before deletion
4. **Gmail Limits**: Gmail API has rate limits (250 quota units per second)

## 🚀 Two Approaches

### Option 1: **Gmail API (Recommended)** ✅
- More reliable
- Faster
- Better error handling
- Requires OAuth2 setup

### Option 2: **Browser Automation** (Using Chrome Profile)
- Uses existing Chrome session
- More complex
- Slower
- May trigger security checks

## 📋 Setup: Gmail API Method (Recommended)

### Step 1: Enable Gmail API

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or select existing)
3. Enable **Gmail API**
4. Create **OAuth 2.0 credentials**

### Step 2: Configure in n8n

1. **Import workflow:** `cleanup_old_gmail.json`
2. **Add Gmail credentials:**
   - Click on "Get Old Messages" node
   - Click "Create New Credential"
   - Select "Gmail OAuth2 API"
   - Enter your OAuth2 credentials
   - Authorize with `vendorah2@gmail.com`

### Step 3: Configure Settings

In "Set Configuration" node, you can adjust:
- `deleteBeforeYear`: Year threshold (e.g., "2024" = delete emails before 2024)
- `searchQuery`: Gmail search query (e.g., "before:2024/1/1")

### Step 4: Test First!

**Before deleting, test the workflow:**

1. **Modify "Get Old Messages" node:**
   - Set `limit: 10` (test with 10 emails first)
   - Check the results

2. **Review filtered messages:**
   - Check "Filter Messages by Year" output
   - Verify the emails are correct

3. **Dry run (no deletion):**
   - Disconnect "Delete Message" node temporarily
   - Run workflow to see what would be deleted

### Step 5: Execute

Once you're confident:
1. Reconnect "Delete Message" node
2. Execute workflow
3. Monitor the results

## 🔧 Browser Automation Method (Alternative)

If you prefer using your existing Chrome profile:

### Using Puppeteer/Playwright

This requires a more complex workflow with:
- Browser automation node
- Chrome profile path
- Gmail login automation
- Email selection and deletion

**Note:** This is more complex and may trigger Gmail security checks.

## 📊 Workflow Features

### Current Workflow Includes:

1. **Set Configuration**
   - Gmail account: `vendorah2@gmail.com`
   - Year threshold: `2024` (delete before 2024)
   - Search query: `before:2024/1/1`

2. **Get Old Messages**
   - Uses Gmail API
   - Searches for old messages
   - Returns up to 100 messages (adjustable)

3. **Filter Messages by Year**
   - Filters messages by date
   - Extracts message details
   - Creates deletion list

4. **Delete Message**
   - Deletes each filtered message
   - ⚠️ **Permanent deletion!**

5. **Create Summary**
   - Shows deletion summary
   - Reports how many messages deleted

## 🛡️ Safety Features

### Before Running:

1. **Test Mode:**
   - Set limit to 10 messages
   - Review results
   - Verify correct emails

2. **Backup:**
   - Export important emails first
   - Use Gmail's "Takeout" feature

3. **Gradual Deletion:**
   - Delete in batches (100 at a time)
   - Monitor for issues
   - Adjust as needed

## 📝 Gmail Search Queries

You can customize the search query:

- `before:2024/1/1` - Before January 1, 2024
- `before:2023/12/31` - Before end of 2023
- `older_than:2y` - Older than 2 years
- `before:2024/1/1 is:read` - Only read emails
- `before:2024/1/1 from:example@gmail.com` - From specific sender

## ⚙️ Configuration Options

### Adjust Year Threshold:
```json
"deleteBeforeYear": "2023"  // Delete before 2023
```

### Adjust Search Query:
```json
"searchQuery": "before:2023/1/1 is:read"  // Only read emails
```

### Adjust Batch Size:
In "Get Old Messages" node:
- `limit: 100` - Process 100 at a time
- `returnAll: true` - Get all matching (use with caution!)

## 🔄 Workflow Execution

### Recommended Process:

1. **First Run (Test):**
   - Limit: 10 messages
   - Review output
   - Verify correct emails

2. **Second Run (Small Batch):**
   - Limit: 50 messages
   - Monitor results
   - Check for errors

3. **Full Run:**
   - Increase limit gradually
   - Monitor rate limits
   - Process in batches

## 🚨 Troubleshooting

### "Authentication Error"
- Check OAuth2 credentials
- Re-authorize Gmail account
- Verify API is enabled

### "Rate Limit Exceeded"
- Reduce batch size
- Add delays between requests
- Process in smaller chunks

### "No Messages Found"
- Check search query
- Verify date format
- Check if emails exist

## 📚 Resources

- **Gmail API Docs:** https://developers.google.com/gmail/api
- **Gmail Search Operators:** https://support.google.com/mail/answer/7190
- **n8n Gmail Node:** https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.gmail/

---

**⚠️ Remember: Email deletion is permanent! Test first, then proceed carefully.**

