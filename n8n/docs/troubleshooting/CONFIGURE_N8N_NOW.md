# Configure n8n with Your New OAuth Credentials

## ✅ Your New Credentials

- **Client ID:** `1006728684723-tobd67d8bptrb3o6ipbhp70bldt4b7re.apps.googleusercontent.com`
- **Client Secret:** `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`

## 🚀 Next Steps: Configure in n8n

### Step 1: Open n8n

1. Go to: **http://localhost:5678**
2. Make sure n8n is running (check Docker if needed)

### Step 2: Create Gmail OAuth2 Credential

1. **Go to Credentials:**
   - Click **"Credentials"** in the left sidebar
   - Or: Click your profile icon → **"Credentials"**

2. **Add New Credential:**
   - Click **"Add Credential"** or **"+"** button
   - Search for: **"Gmail OAuth2 API"**
   - Click on it

3. **Enter Credentials:**
   - **Credential Name:** `Gmail - vendorah2@gmail.com` (or any name you prefer)
   - **Client ID:** `1006728684723-tobd67d8bptrb3o6ipbhp70bldt4b7re.apps.googleusercontent.com`
   - **Client Secret:** `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`
   - **Scope:** Leave default (or ensure it includes: `https://www.googleapis.com/auth/gmail.modify`)

4. **Authorize:**
   - Click **"Connect my account"** or **"Save"** button
   - You'll see a popup or be redirected to Google
   - **Sign in with:** `vendorah2@gmail.com`
   - **Grant permissions** (allow n8n to access Gmail)
   - You'll be redirected back to n8n
   - The credential should show as "Connected" or "Authorized"

5. **Save:**
   - Click **"Save"** if not already saved

### Step 3: Import Gmail Cleanup Workflow

1. **Go to Workflows:**
   - Click **"Workflows"** in left sidebar
   - Click **"Import from File"** or **"+"** → **"Import from File"**

2. **Select Workflow:**
   - Navigate to: `/home/sabry3/never_stop_learning/n8n/tests/cleanup_old_gmail.json`
   - Or drag and drop the file
   - Click **"Import"**

3. **Configure Gmail Nodes:**
   - Click on **"Get Old Messages"** node
   - Under **"Credential to connect with"**, select your Gmail credential
   - Click on **"Delete Message"** node
   - Under **"Credential to connect with"**, select the same Gmail credential

### Step 4: Configure Settings

1. **Edit "Set Configuration" Node:**
   - **gmailAccount:** `vendorah2@gmail.com` (already set)
   - **deleteBeforeYear:** `2024` (delete emails before 2024)
   - **searchQuery:** `before:2024/1/1` (Gmail search query)

2. **Adjust "Get Old Messages" Node:**
   - **Limit:** Set to `10` for testing (IMPORTANT!)
   - **Search Query:** Uses the query from config node

### Step 5: Test First! ⚠️

**CRITICAL: Always test before deleting!**

1. **Dry Run (No Deletion):**
   - Temporarily **disconnect** the "Delete Message" node
   - Click **"Execute Workflow"** or **"Test workflow"**
   - Check the output of "Filter Messages by Year" node
   - **Verify** these are the emails you want to delete
   - Check dates, subjects, senders

2. **If Correct:**
   - **Reconnect** "Delete Message" node
   - **Run workflow again**
   - Monitor the results

3. **If Not Correct:**
   - Adjust the search query or year threshold
   - Test again

### Step 6: Full Execution (After Testing)

Once you're confident:

1. **Gradually Increase Limit:**
   - Start: 10 emails ✅
   - Then: 50 emails
   - Then: 100 emails
   - Monitor for errors

2. **Process in Batches:**
   - Gmail API has rate limits
   - Process 100-200 emails at a time
   - Add delays if you get rate limit errors

## ✅ Checklist

- [ ] OAuth2 Web application client created
- [ ] Redirect URIs configured correctly
- [ ] Credential added in n8n
- [ ] Authorized with vendorah2@gmail.com
- [ ] Workflow imported
- [ ] Gmail nodes configured
- [ ] Tested with 10 emails (dry run)
- [ ] Verified correct emails
- [ ] Ready to execute!

## 🚨 Important Reminders

- ⚠️ **Email deletion is PERMANENT!**
- ✅ **Always test first**
- ✅ **Backup important emails**
- ✅ **Start with small batches**
- ✅ **Monitor for errors**

## 🔧 Troubleshooting

### "Invalid credentials"
- Double-check Client ID and Secret are correct
- Make sure you copied them completely
- Verify OAuth2 redirect URI is set in Google Cloud Console

### "Permission denied"
- Make sure you granted all required permissions
- Re-authorize the credential if needed
- Check that Gmail API is enabled in Google Cloud Console

### "Redirect URI mismatch"
- Verify redirect URI in Google Cloud Console: `http://localhost:5678/rest/oauth2-credential/callback`
- Make sure it's in "Authorized redirect URIs" (not JavaScript origins)

### "Rate limit exceeded"
- Reduce batch size
- Add delays between requests
- Process in smaller chunks

---

**You're almost ready! Configure in n8n and test! 🚀**

