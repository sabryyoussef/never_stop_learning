# Fix: Create Web Application OAuth Client

## ⚠️ Issue
You created a **"Desktop"** OAuth client, but n8n needs a **"Web application"** client.

Desktop clients don't have "Authorized redirect URIs" - that's why you can't find it!

## ✅ Solution: Create Web Application Client

### Step 1: Create New OAuth Client

1. **Go to Google Cloud Console:**
   - https://console.cloud.google.com/
   - Navigate to: **APIs & Services** → **Credentials**

2. **Create New Client:**
   - Click **"+ CREATE CREDENTIALS"** (top of page)
   - Select **"OAuth client ID"**

3. **Configure Application Type:**
   - **Application type:** Select **"Web application"** (NOT Desktop!)
   - **Name:** `gmail-oauth-client-web` (or any name)

4. **Add Authorized Redirect URI:**
   - Under **"Authorized redirect URIs"**, click **"+ ADD URI"**
   - Enter: `http://localhost:5678/rest/oauth2-credential/callback`
   - Click **"ADD"**

5. **Create:**
   - Click **"CREATE"**
   - You'll see a popup with:
     - **Client ID** (copy this)
     - **Client Secret** (copy this immediately - you won't see it again!)

### Step 2: Update Your Credentials

Update `qbath_client.md` with the new credentials:
- Client ID (from new Web application client)
- Client Secret (from new Web application client)

### Step 3: Use in n8n

Use the new Web application client credentials in n8n (same steps as before).

## 🔄 Alternative: Check if Desktop Client Can Be Modified

If you want to keep the Desktop client:

1. **Check if there's a way to add redirect URIs:**
   - Look for tabs/sections like "Advanced settings"
   - Check if there's a "OAuth 2.0" or "Redirect URIs" section
   - Some Desktop clients might have this option

2. **But it's better to create a Web application client** - it's designed for this use case.

## 📋 Quick Checklist

- [ ] Create new OAuth client
- [ ] Select "Web application" (NOT Desktop)
- [ ] Add redirect URI: `http://localhost:5678/rest/oauth2-credential/callback`
- [ ] Copy new Client ID and Secret
- [ ] Update credentials in n8n
- [ ] Test connection

## 🎯 Why Web Application?

- ✅ Has "Authorized redirect URIs" section
- ✅ Designed for server-to-server OAuth
- ✅ Works perfectly with n8n
- ✅ Standard OAuth 2.0 flow

Desktop clients are for:
- Installed applications
- Different OAuth flow
- No redirect URIs needed

---

**Create a Web application client and you'll see the redirect URI section! 🚀**

