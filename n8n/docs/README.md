# n8n Workflow Tests

This folder contains test workflows for learning and testing n8n automation.

## 📁 Available Workflows

### 1. `list_folders_markdown.json`
**Purpose:** List all Google Drive folders and generate a markdown file

**Features:**
- Lists all folders from Google Drive
- Formats folder information
- Generates markdown document
- Saves to file with timestamp

**Nodes:**
- Manual Trigger
- Google Drive (Get All Folders)
- Set (Format Folder Info)
- Code (Generate Markdown)
- Write File

**Output:** Markdown file with folder list

---

### 2. `list_folders_simple.json`
**Purpose:** Simple folder listing in markdown table format (no file write)

**Features:**
- Lists all folders from Google Drive
- Generates markdown table
- Shows in workflow output (no file saved)

**Nodes:**
- Manual Trigger
- Google Drive (Get All Folders)
- Code (Generate Markdown Table)

**Output:** Markdown table in workflow execution results

---

## 🚀 How to Use

### Import Workflow
1. Open n8n: http://localhost:5678
2. Click Menu (☰) → **Import workflow**
3. Select one of the workflow JSON files
4. Click **Import**

### Configure Credentials
1. Click on the **"Get All Folders"** node
2. Click **"Create New Credential"** or select existing
3. Follow OAuth flow to connect Google Drive
4. Grant necessary permissions

### Execute Workflow
1. Click **"Execute Workflow"** button
2. Check the output for your folder list

---

## 📊 Expected Output

### Markdown Format Example:
```markdown
# 📁 Google Drive Folders

**Total:** 5 folders

| # | Folder Name | Folder ID | Modified Date |
|---|-------------|-----------|---------------|
| 1 | Documents | `abc123...` | 2025-11-10 |
| 2 | Photos | `def456...` | 2025-11-09 |
| 3 | Projects | `ghi789...` | 2025-11-08 |
```

---

## 🧪 Testing

### Test Script
Run the test script to validate workflows:
```bash
cd /home/sabry3/never_stop_learning/n8n/tests
../test_workflow.sh list_folders_simple.json
```

### Manual Testing
1. Import workflow into n8n
2. Configure Google Drive credentials
3. Execute workflow
4. Verify markdown output

---

## 📝 Learning Notes

### Key Concepts:
1. **Google Drive Query:** Uses `q` parameter to filter folders
   - `mimeType = 'application/vnd.google-apps.folder'` - Only folders
   - `trashed = false` - Exclude deleted items

2. **Code Node:** JavaScript to generate markdown
   - Access input data with `$input.all()`
   - Return array with `json` property

3. **Markdown Format:**
   - Headers: `# Title`
   - Tables: `| Column | Column |`
   - Links: `[Text](URL)`
   - Code: `` `code` ``

---

## 🔧 Customization

### Filter Specific Folders
Edit the Google Drive node query:
```javascript
// Only folders in specific parent
"q": "mimeType = 'application/vnd.google-apps.folder' and 'PARENT_ID' in parents"

// Folders modified in last 7 days
"q": "mimeType = 'application/vnd.google-apps.folder' and modifiedTime > '2025-11-03T00:00:00'"
```

### Change Output Format
Edit the Code node to customize markdown:
- Add more fields
- Change table structure
- Add formatting (bold, italic, etc.)

---

## ⚠️ Requirements

- n8n running (http://localhost:5678)
- Google Drive OAuth credentials configured
- Access to Google Drive account

---

## 📚 Next Steps

1. Try both workflows and compare outputs
2. Modify the markdown format to your preference
3. Add filters to show specific folders
4. Create your own workflow variations

---

**Happy Learning! 🚀**

