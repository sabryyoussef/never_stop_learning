# Quick Start Guide - Folder Listing Workflows

## 🎯 What You Have

Three workflows to list your Google Drive folders in markdown format:

### 1. **`list_folders_basic.json`** ⭐ RECOMMENDED FOR LEARNING
- **Simplest** - Uses only Set nodes (no Code node)
- **Best for beginners** - Easy to understand
- **Output:** Formatted folder info with markdown links

### 2. **`list_folders_simple.json`**
- Uses Code node to generate markdown table
- Shows output in workflow execution
- **Output:** Markdown table format

### 3. **`list_folders_markdown.json`**
- Most complete - generates and saves markdown file
- Includes file writing
- **Output:** Saved markdown file with timestamp

---

## 🚀 Quick Start (5 Minutes)

### Step 1: Import Workflow
1. Open n8n: **http://localhost:5678**
2. Click **Menu (☰)** → **Import workflow**
3. Select: `list_folders_basic.json`
4. Click **Import**

### Step 2: Configure Google Drive
1. Click on **"Get All Folders"** node
2. Click **"Create New Credential"**
3. Follow OAuth flow
4. Grant permissions

### Step 3: Test It!
1. Click **"Execute Workflow"** button
2. See your folders listed!

---

## 📊 What You'll See

After execution, you'll see output like:

```json
{
  "folderName": "Documents",
  "folderId": "abc123...",
  "createdDate": "2025-01-15T10:30:00.000Z",
  "modifiedDate": "2025-11-10T14:20:00.000Z",
  "folderLink": "https://drive.google.com/drive/folders/abc123...",
  "markdownLine": "- **Documents** (ID: `abc123...`) - [Open](https://drive.google.com/drive/folders/abc123...)"
}
```

---

## 🎓 Learning Points

### What Each Node Does:

1. **Manual Trigger** - Starts the workflow
2. **Google Drive** - Fetches folders using query:
   - `mimeType = 'application/vnd.google-apps.folder'` - Only folders
   - `trashed = false` - Exclude deleted
3. **Set Node** - Formats data into readable format

### Key Concepts:

- **Query Syntax:** Google Drive uses `q` parameter for filtering
- **MIME Types:** Folders have type `application/vnd.google-apps.folder`
- **Markdown Links:** Format: `[Text](URL)`

---

## 🔧 Try This

### Exercise 1: Modify the Query
Edit the Google Drive node to show only folders modified today:
```javascript
"q": "mimeType = 'application/vnd.google-apps.folder' and modifiedTime > '2025-11-10T00:00:00'"
```

### Exercise 2: Add More Fields
In the Set node, add:
- Folder size
- Owner name
- Shared status

### Exercise 3: Create Your Own
Make a workflow that:
- Lists files (not folders)
- Filters by file type (PDFs only)
- Generates a report

---

## 📁 Files Created

```
tests/
├── list_folders_basic.json      ⭐ Start here!
├── list_folders_simple.json
├── list_folders_markdown.json
├── README.md                    (Detailed docs)
├── QUICK_START.md              (This file)
└── test_example.md             (Example output)
```

---

## ❓ Troubleshooting

**"No credentials found"**
→ Create Google Drive OAuth credentials in n8n

**"Empty results"**
→ Check if you have folders in Google Drive
→ Verify query syntax

**"Node not installed"**
→ Use `list_folders_basic.json` (uses only core nodes)

---

## 🎉 Next Steps

1. ✅ Import and test `list_folders_basic.json`
2. ✅ Understand how it works
3. ✅ Try modifying it
4. ✅ Create your own workflow!

**Happy Learning! 🚀**

