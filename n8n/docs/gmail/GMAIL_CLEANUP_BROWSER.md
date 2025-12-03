# Gmail Cleanup with Browser Automation

## ⚠️ Important Note

**Browser automation for Gmail is complex and not recommended!**

### Why Gmail API is Better:
- ✅ More reliable
- ✅ Faster
- ✅ Better error handling
- ✅ No security checks
- ✅ Rate limit management

### Why Browser Automation is Difficult:
- ❌ Gmail has anti-bot protection
- ❌ Requires handling 2FA/captcha
- ❌ Slower (page loads, interactions)
- ❌ More fragile (UI changes break it)
- ❌ Chrome profile management complexity

## 🎯 Recommended Approach

**Use the Gmail API workflow instead:** `cleanup_old_gmail.json`

See: `GMAIL_CLEANUP_GUIDE.md` for setup instructions.

## 🔧 If You Still Want Browser Automation

### Requirements:
1. **Playwright or Puppeteer** installed
2. **Chrome profile** path
3. **Gmail login** automation
4. **Email selection** logic
5. **Deletion** automation

### Chrome Profile Path:
```bash
# Find your Chrome profile
ls ~/.config/google-chrome/
# Or
ls ~/.config/chromium/
```

### Basic Steps (Conceptual):
1. Launch Chrome with profile
2. Navigate to gmail.com
3. Check if logged in
4. If not, handle login
5. Search for old emails
6. Select emails
7. Delete them
8. Confirm deletion

### Example Playwright Code:
```javascript
const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launchPersistentContext(
    '/home/sabry3/.config/google-chrome',
    {
      headless: false,
      args: ['--disable-blink-features=AutomationControlled']
    }
  );
  
  const page = await browser.newPage();
  await page.goto('https://mail.google.com');
  
  // Wait for login or handle it
  // Search for emails
  // Select and delete
  // ...
  
  await browser.close();
})();
```

## 🚨 Security Considerations

- Gmail may detect automation
- May require manual intervention
- Could trigger security alerts
- May need to handle 2FA

## ✅ Recommendation

**Use Gmail API workflow** (`cleanup_old_gmail.json`) - it's much more reliable!

---

**For browser automation, consider using specialized tools like:**
- Selenium
- Playwright
- Puppeteer
- Or use n8n's HTTP Request node with Gmail API

