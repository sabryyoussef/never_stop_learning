# How to Post to Facebook with n8n

## ✅ Yes! You Can Post to Facebook with n8n

n8n has built-in **Facebook Graph API** integration that lets you:
- ✅ Post text messages
- ✅ Post with images
- ✅ Post with links
- ✅ Schedule posts
- ✅ Post to Facebook Pages
- ✅ Post to Facebook Groups (with permissions)

## 🚀 Quick Setup

### Step 1: Get Facebook App Credentials

1. **Go to Facebook Developers:**
   - Visit: https://developers.facebook.com
   - Create a new app (or use existing)

2. **Get Access Token:**
   - Go to Graph API Explorer
   - Generate Page Access Token
   - Copy the token

3. **Get Page ID:**
   - Go to your Facebook Page
   - Check page settings → Page Info
   - Copy the Page ID

### Step 2: Configure n8n

1. **Import Workflow:**
   - Import `post_to_facebook.json`

2. **Add Facebook Credentials:**
   - Click on "Post to Facebook Page" node
   - Click "Create New Credential"
   - Select "Facebook Graph API"
   - Enter your Access Token

3. **Set Page ID:**
   - In "Post to Facebook Page" node
   - Replace `YOUR_PAGE_ID` with your actual Page ID

### Step 3: Test It!

1. Click "Execute Workflow"
2. Check your Facebook Page
3. Your post should appear!

## 📋 Workflow Features

### Current Workflow Includes:
- **Manual Trigger** - Test anytime
- **Set Post Content** - Edit your message
- **Post to Facebook** - Publishes to your page
- **Format Result** - Shows success message

## 🔧 Post Types You Can Create

### 1. Text Post
```json
{
  "message": "Your post text here"
}
```

### 2. Post with Link
```json
{
  "message": "Check this out!",
  "link": "https://example.com"
}
```

### 3. Post with Image
- Use `edge: "photos"` instead of `"feed"`
- Add image as binary data

### 4. Scheduled Post
- Use `scheduled_publish_time` parameter
- Set future timestamp

## 💡 Advanced Examples

### Post with Image
```javascript
// In Facebook Graph API node:
edge: "photos"
node: "YOUR_PAGE_ID"
message: "Your caption"
binaryPropertyName: "data"  // Image from previous node
```

### Post to Multiple Pages
- Duplicate the Facebook node
- Use different Page IDs
- Connect to same content

### Auto-Post from RSS Feed
```
RSS Trigger → Format Content → Post to Facebook
```

### Schedule Daily Posts
```
Schedule Trigger (Daily) → Get Content → Post to Facebook
```

## ⚠️ Important Notes

### Permissions Required:
- **Page Access Token** (not User Access Token)
- **pages_manage_posts** permission
- **pages_read_engagement** (for insights)

### Limitations:
- **Rate Limits:** Facebook has rate limits
- **Page Required:** Can't post to personal profile (only Pages)
- **Token Expiry:** Long-lived tokens last ~60 days

### Best Practices:
- ✅ Use Page Access Tokens (not User tokens)
- ✅ Handle errors gracefully
- ✅ Don't spam (respect rate limits)
- ✅ Test with small posts first

## 🔗 Resources

- **Facebook Graph API Docs:** https://developers.facebook.com/docs/graph-api
- **n8n Facebook Node:** https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.facebookgraphapi/
- **Facebook App Setup:** https://developers.facebook.com/apps

## 🎯 Use Cases

### Personal Use:
- Auto-post daily updates
- Share blog posts automatically
- Post quotes or reminders
- Share photos from events

### Business Use:
- Schedule marketing posts
- Auto-share product updates
- Cross-post from other platforms
- Share company news

## 📝 Example Workflows

### 1. Simple Text Post
```
Manual Trigger → Set Message → Post to Facebook
```

### 2. Auto-Post from Website
```
HTTP Request (Get Content) → Format → Post to Facebook
```

### 3. Scheduled Daily Post
```
Schedule (Daily 9 AM) → Get Content → Post to Facebook
```

### 4. Post with Image
```
Manual Trigger → Get Image → Post Photo to Facebook
```

---

**Ready to automate your Facebook posts! 🚀**

