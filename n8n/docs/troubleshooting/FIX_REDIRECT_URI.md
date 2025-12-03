# Fix: Redirect URI Configuration

## ⚠️ Error Message
```
Invalid origin: URIs must not contain a path or end with '/'.
```

## 🔍 Issue
You're entering the redirect URI in the wrong field! Google Cloud Console has **two different fields**:

### Field 1: "Authorized JavaScript origins" 
- **Format:** Just the origin (no path)
- **Example:** `http://localhost:5678`
- **Purpose:** Where JavaScript can make requests from

### Field 2: "Authorized redirect URIs"
- **Format:** Full URI with path
- **Example:** `http://localhost:5678/rest/oauth2-credential/callback`
- **Purpose:** Where OAuth redirects go

## ✅ Correct Configuration

### Step 1: Find Both Fields

When creating/editing your **Web application** OAuth client, you should see:

1. **"Authorized JavaScript origins"** section
   - Click **"+ ADD URI"**
   - Enter: `http://localhost:5678` (NO path, NO trailing slash)

2. **"Authorized redirect URIs"** section (separate section below)
   - Click **"+ ADD URI"**
   - Enter: `http://localhost:5678/rest/oauth2-credential/callback` (WITH path)

### Step 2: Add Both

**Authorized JavaScript origins:**
```
http://localhost:5678
```

**Authorized redirect URIs:**
```
http://localhost:5678/rest/oauth2-credential/callback
```

## 📋 Complete Setup

1. **Authorized JavaScript origins:**
   - `http://localhost:5678` ✅

2. **Authorized redirect URIs:**
   - `http://localhost:5678/rest/oauth2-credential/callback` ✅

## 🎯 Quick Fix

If you only see one field and it's giving the error:
- That's the "JavaScript origins" field
- Look for a **separate section** below it for "Authorized redirect URIs"
- Or scroll down - they're in different sections

## 🔍 Visual Guide

The page should look like:

```
┌─────────────────────────────────────┐
│ Authorized JavaScript origins       │
│ + ADD URI                            │
│   http://localhost:5678              │ ← No path here!
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Authorized redirect URIs            │
│ + ADD URI                            │
│   http://localhost:5678/rest/...    │ ← Full path here!
└─────────────────────────────────────┘
```

## ⚠️ Important Notes

- **JavaScript origins:** No path, no trailing slash
- **Redirect URIs:** Full path including `/rest/oauth2-credential/callback`
- Both are required for n8n to work properly

---

**Add both fields correctly and the error will disappear! 🚀**

