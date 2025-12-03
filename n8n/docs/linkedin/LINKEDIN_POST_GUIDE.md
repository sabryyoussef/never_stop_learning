# LinkedIn Posting Guide

## 🎯 Quick Setup

### Step 1: Get LinkedIn API Credentials

1. **Go to LinkedIn Developers:**
   - Visit: https://www.linkedin.com/developers/
   - Create a new app (or use existing)

2. **Get OAuth Credentials:**
   - Go to "Auth" tab
   - Copy **Client ID** and **Client Secret**
   - Add redirect URI: `http://localhost:5678/rest/oauth2-credential/callback`

3. **Request Permissions:**
   - Request: `w_member_social` (to post as person)
   - Or: `w_organization_social` (to post as organization)

### Step 2: Configure in n8n

1. **Go to Credentials:**
   - Open n8n: http://localhost:5678
   - Go to **Credentials** → **Add Credential**
   - Search for: **"LinkedIn OAuth2 API"**

2. **Enter Credentials:**
   - **Credential Name:** `LinkedIn account` (or any name)
   - **Client ID:** Your LinkedIn Client ID
   - **Client Secret:** Your LinkedIn Client Secret
   - **Scope:** `w_member_social` (for personal posts)

3. **Authorize:**
   - Click **"Connect my account"**
   - Sign in to LinkedIn
   - Grant permissions
   - You'll be redirected back to n8n

4. **Save:**
   - Click **"Save"**

### Step 3: Import Workflow

1. **Import Workflow:**
   - Go to **Workflows** → **Import from File**
   - Select: `workflows/test_linkedin_post.json`

2. **Configure LinkedIn Node:**
   - Click on **"Post to LinkedIn"** node
   - Under **"Credential to connect with"**, select your LinkedIn credential
   - **Post As:** Select "person" (or "organization" if posting as company)

3. **Edit Post Text (Optional):**
   - Click on **"Set Post Content"** node
   - Edit the `postText` field if you want different text

### Step 4: Test!

1. **Click "Execute workflow"**
2. **Check your LinkedIn profile**
3. **Your test post should appear!**

## 📋 Workflow Features

### Current Workflow:
- **Set Post Content** - Defines the post text
- **Post to LinkedIn** - Publishes to LinkedIn
- **Format Result** - Shows success message

### Post Text:
The default test post says:
```
🧪 Testing LinkedIn integration with n8n!

This is a test post to confirm everything is working correctly.

✅ Automated with n8n workflow automation
📅 Posted: [timestamp]
```

## 🔧 Customize Post

### Edit Post Text:
In "Set Post Content" node, change `postText`:
```json
"postText": "Your custom post text here"
```

### Post as Organization:
In "Post to LinkedIn" node:
- Change **"Post As"** to "organization"
- Select your organization
- You'll need `w_organization_social` permission

### Add Media:
- Use **"Additional Fields"** in LinkedIn node
- Add image URL or other media

## ⚠️ Important Notes

### Permissions Required:
- **Personal Posts:** `w_member_social`
- **Organization Posts:** `w_organization_social`

### Rate Limits:
- LinkedIn has rate limits
- Don't post too frequently
- Respect LinkedIn's policies

### Best Practices:
- ✅ Test with one post first
- ✅ Don't spam
- ✅ Follow LinkedIn's terms
- ✅ Use meaningful content

## 🎯 What You Can Do

### Basic Posting:
- Post text updates
- Post with images
- Post as person or organization

### Advanced:
- Schedule posts
- Auto-post from other sources
- Cross-post from other platforms
- Post analytics

## 🔗 Resources

- **LinkedIn API Docs:** https://docs.microsoft.com/en-us/linkedin/
- **n8n LinkedIn Node:** https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.linkedin/
- **LinkedIn Developers:** https://www.linkedin.com/developers/

---

**Configure credentials and test your LinkedIn post! 🚀**

