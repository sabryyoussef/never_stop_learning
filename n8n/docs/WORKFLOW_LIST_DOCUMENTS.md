# List All Documents Workflow

This workflow lists all documents from your storage (Google Drive, AWS S3, Dropbox, etc.).

## 📁 Available Workflows

1. **`list_all_documents.json`** - Main workflow for Google Drive (recommended)
2. **`list_documents_alternative_storage.json`** - Multi-storage support (Google Drive, AWS S3, Dropbox)

## 🚀 Quick Start

### Import into n8n

1. **Open n8n**: http://localhost:5678
2. **Import workflow**:
   - Click Menu (☰) → **Import workflow**
   - Select `list_all_documents.json`
   - Click **Import**

### Configure Google Drive Credentials

1. Click on the **"List All Documents"** node
2. Click **"Create New Credential"** or select existing
3. Follow the OAuth flow to connect your Google Drive
4. Grant necessary permissions

### Run the Workflow

1. Click **"Execute Workflow"** button (or use Manual Trigger)
2. The workflow will:
   - List all files from your Google Drive
   - Format file information (name, size, type, date)
   - Sort by modification date (newest first)
   - Create a summary with total count

## 📊 Output Format

The workflow returns:
- **fileId**: Google Drive file ID
- **fileName**: Name of the file
- **fileType**: MIME type (e.g., application/pdf, text/plain)
- **fileSize**: Size in KB
- **modifiedDate**: Last modification date
- **viewLink**: Link to view file in Google Drive
- **downloadLink**: Direct download link (if available)
- **isGoogleDoc**: Boolean indicating if it's a Google Workspace document

## 🔧 Customization

### List Files from Specific Folder

Edit the **"List All Documents"** node:
- Add `folderId` parameter to filter by folder
- Or modify the query: `q: "trashed = false and 'FOLDER_ID' in parents"`

### Filter by File Type

Add a filter node after "Format Document Info":
- Filter by `fileType` field
- Example: Only PDFs: `fileType contains 'pdf'`

### Limit Results

In the **"List All Documents"** node:
- Set `returnAll: false`
- Add `limit: 100` to get first 100 files

## 🌐 Alternative Storage Options

### AWS S3

Use `list_documents_alternative_storage.json`:
1. Configure AWS credentials
2. Set your bucket name
3. The workflow will list all objects in the bucket

### Dropbox

Use `list_documents_alternative_storage.json`:
1. Configure Dropbox credentials
2. Set the path (default: `/`)
3. The workflow will list all files

## 📝 Example Use Cases

1. **Backup Audit**: List all files to check what needs backing up
2. **Storage Cleanup**: Find old or large files
3. **Document Search**: Get list of all documents for processing
4. **Integration**: Use output to sync with other services

## ⚠️ Important Notes

- **Credentials**: Always configure credentials before running
- **Permissions**: Ensure your Google Drive account has proper access
- **Rate Limits**: Google Drive API has rate limits (1000 requests/100 seconds)
- **Large Accounts**: For accounts with thousands of files, consider pagination

## 🔗 Related Workflows

Browse more storage workflows at: http://localhost:8000
- Search: "google drive"
- Search: "aws s3"
- Search: "dropbox"

## 🛠 Troubleshooting

### "No credentials found"
- Create Google Drive OAuth credentials in n8n
- Make sure you've granted necessary permissions

### "Empty results"
- Check if you have files in your Google Drive
- Verify the query filter isn't too restrictive
- Try removing the `q` parameter to list everything

### "Rate limit exceeded"
- Wait a few minutes before retrying
- Consider adding delays between requests
- Use pagination for large accounts

---

**Need help?** Check the n8n documentation: https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.googledrive/

