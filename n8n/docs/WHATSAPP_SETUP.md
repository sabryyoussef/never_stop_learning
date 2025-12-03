# WhatsApp Messages Reader - Setup Guide

## ⚠️ Important Note

**WhatsApp Web (web.whatsapp.com) does NOT have a direct API** that n8n can access. To read WhatsApp messages with n8n, you need to use **WhatsApp Business API**.

## 🔧 Setup Options

### Option 1: WhatsApp Business API (Recommended)

This requires:
1. **Meta Business Account**
2. **WhatsApp Business API** access
3. **Phone Number ID** and **Access Token**

#### Steps:

1. **Create Meta Business Account:**
   - Go to https://business.facebook.com
   - Create a business account

2. **Set up WhatsApp Business API:**
   - Go to https://developers.facebook.com
   - Create a new app
   - Add WhatsApp product
   - Get your credentials:
     - **Phone Number ID**
     - **Access Token**

3. **Configure n8n Workflow:**
   - Open the workflow
   - Edit "Set Config" node
   - Add your Phone Number ID
   - Add your Access Token

4. **Set HTTP Header Auth:**
   - In "Get Last 10 Messages" node
   - Configure credentials:
     - Header Name: `Authorization`
     - Header Value: `Bearer YOUR_ACCESS_TOKEN`

### Option 2: Use WhatsApp Webhook (Alternative)

If you have WhatsApp Business API set up, you can use webhooks to receive messages in real-time.

## 📋 Workflow Configuration

### Step 1: Edit "Set Config" Node
```json
{
  "phoneNumberId": "YOUR_PHONE_NUMBER_ID",
  "accessToken": "YOUR_ACCESS_TOKEN"
}
```

### Step 2: Configure HTTP Request
- URL: `https://graph.facebook.com/v18.0/{phoneNumberId}/messages`
- Method: GET
- Authentication: Header Auth
  - Header: `Authorization`
  - Value: `Bearer {accessToken}`

## 🚀 Alternative: Browser Automation

If you need to read from WhatsApp Web directly, you would need:

1. **Puppeteer/Playwright** via Code node
2. **Browser automation** to:
   - Open WhatsApp Web
   - Log in (requires QR code scan)
   - Extract messages from DOM

**Note:** This is complex and not recommended due to:
- Authentication challenges
- Rate limiting
- Terms of Service concerns

## 📊 Expected Output

Once configured, the workflow will return:

```markdown
# 📱 Last 10 WhatsApp Messages

**Total Messages:** 10

---

## 1. Message from +1234567890

- **From:** +1234567890
- **To:** +0987654321
- **Message:** Hello, this is a test message
- **Type:** text
- **Timestamp:** 11/10/2025, 12:00:00 AM
- **Message ID:** wamid.xxx

---
```

## ⚠️ Limitations

1. **WhatsApp Web API:** Not available - must use Business API
2. **Personal Accounts:** WhatsApp Business API is for business accounts
3. **Authentication:** Requires Meta Business setup
4. **Rate Limits:** API has rate limits

## 🔗 Resources

- [WhatsApp Business API Docs](https://developers.facebook.com/docs/whatsapp)
- [Meta Business Setup](https://business.facebook.com)
- [n8n WhatsApp Node Docs](https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.whatsapp/)

## 💡 Quick Test

If you don't have WhatsApp Business API, you can:
1. Use the workflow structure as a template
2. Set up WhatsApp Business API when ready
3. Or use webhook-based workflows for real-time messages

---

**Note:** Reading messages from personal WhatsApp Web accounts directly is not supported by official APIs. You need WhatsApp Business API for programmatic access.

