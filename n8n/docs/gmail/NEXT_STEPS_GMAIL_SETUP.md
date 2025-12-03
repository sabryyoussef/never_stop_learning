# Next Steps: Configure Gmail OAuth2 in n8n

## ✅ You Have:
- **Client ID:** `1006728684723-qg7ttc01tditsljvl0bjggdgtlgbgmfq.apps.googleusercontent.com`
- **Client Secret:** `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`

## 🚀 Next Steps:

### Step 1: Configure OAuth2 in n8n

1. **Open n8n:**
   - Go to: http://localhost:5678

2. **Go to Credentials:**
   - Click on **"Credentials"** in the left sidebar
   - Or: Click your profile → **"Credentials"**

3. **Create New Credential:**
   - Click **"Add Credential"** or **"+"** button
   - Search for **"Gmail OAuth2 API"**
   - Select it

4. **Enter Your Credentials:**
   - **Credential Name:** `Gmail - vendorah2@gmail.com` (or any name)
   - **Client ID:** `1006728684723-qg7ttc01tditsljvl0bjggdgtlgbgmfq.apps.googleusercontent.com`
   - **Client Secret:** `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`
   - **Scope:** Leave default (or add: `https://www.googleapis.com/auth/gmail.modify`)

5. **Authorize:**
   - Click **"Connect my account"** or **"Authorize"**
   - You'll be redirected to Google
   - Sign in with: **vendorah2@gmail.com**
   - Grant permissions
   - You'll be redirected back to n8n

6. **Save:**
   - Click **"Save"** or **"Create"**

### Step 2: Import the Workflow

1. **Import Workflow:**
   - Click **"Workflows"** in left sidebar
   - Click **"Import from File"** or **"+"** → **"Import from File"**
   - Select: `/home/sabry3/never_stop_learning/n8n/tests/cleanup_old_gmail.json`

2. **Configure Gmail Nodes:**
   - Click on **"Get Old Messages"** node
   - Under **"Credential to connect with"**, select your Gmail credential
   - Do the same for **"Delete Message"** node

### Step 3: Configure Settings

1. **Edit "Set Configuration" Node:**
   - **gmailAccount:** `vendorah2@gmail.com` (already set)
   - **deleteBeforeYear:** `2024` (delete emails before 2024)
   - **searchQuery:** `before:2024/1/1` (Gmail search query)

2. **Adjust "Get Old Messages" Node:**
   - **Limit:** Start with `10` for testing
   - **Search Query:** Uses the query from config

### Step 4: Test First! ⚠️

**IMPORTANT: Test with a small batch first!**

1. **Set Limit to 10:**
   - In "Get Old Messages" node, set `limit: 10`

2. **Disconnect Delete Node (Dry Run):**
   - Temporarily disconnect "Delete Message" node
   - Run workflow
   - Check "Filter Messages by Year" output
   - Verify these are the emails you want to delete

3. **If Correct:**
   - Reconnect "Delete Message" node
   - Run workflow again
   - Monitor results

### Step 5: Full Execution

Once you're confident:

1. **Increase Limit:**
   - Gradually increase: 50 → 100 → 500
   - Monitor for errors

2. **Process in Batches:**
   - Gmail API has rate limits
   - Process 100-200 emails at a time
   - Add delays if needed

## 🔧 OAuth2 Redirect URI

**Important:** Make sure your OAuth2 credentials have this redirect URI:
```
http://localhost:5678/rest/oauth2-credential/callback
```

If you need to add it:
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. APIs & Services → Credentials
3. Edit your OAuth 2.0 Client
4. Add Authorized redirect URI: `http://localhost:5678/rest/oauth2-credential/callback`
5. Save

## 📋 Quick Checklist

- [ ] OAuth2 credentials created in Google Cloud Console
- [ ] Gmail API enabled
- [ ] Redirect URI configured
- [ ] Credential added in n8n
- [ ] Authorized with vendorah2@gmail.com
- [ ] Workflow imported
- [ ] Gmail nodes configured with credential
- [ ] Tested with 10 emails (dry run)
- [ ] Verified correct emails will be deleted
- [ ] Ready to execute!

## 🚨 Safety Reminders

- ⚠️ **Email deletion is PERMANENT!**
- ✅ **Always test first**
- ✅ **Backup important emails**
- ✅ **Start with small batches**
- ✅ **Monitor for errors**

## 🎯 What the Workflow Does

1. **Searches** for emails before 2024
2. **Filters** them by date
3. **Deletes** each email permanently
4. **Shows** summary of deleted emails

## 📚 Troubleshooting

### "Invalid credentials"
- Check Client ID and Secret are correct
- Verify OAuth2 redirect URI is set
- Re-authorize the credential

### "Permission denied"
- Make sure you granted all required permissions
- Re-authorize if needed

### "Rate limit exceeded"
- Reduce batch size
- Add delays between requests
- Process in smaller chunks

---

**Ready to clean up old emails! 🚀**

