# LinkedIn Job Search Workflow - Odoo Developers

## 🎯 Overview

This workflow searches LinkedIn for Odoo Developer jobs and returns formatted results.

## 🚀 Quick Start

### Step 1: Import Workflow

1. **In n8n:**
   - Go to **Workflows** → **Import from File**
   - Select: `workflows/search_linkedin_jobs_odoo.json`
   - Click **Import**

### Step 2: Customize Search (Optional)

1. **Click "Set Search Parameters" node:**
   - **searchQuery:** Change to "Odoo Developer" (or any job title)
   - **location:** Change to "Remote", "New York", "London", etc.
   - **maxResults:** Number of jobs to return (default: 25)

### Step 3: Execute

1. **Click "Execute workflow"**
2. **Check the output:**
   - See formatted job listings
   - Markdown table with all jobs
   - Links to each job posting

## 📋 How It Works

### Workflow Steps:

1. **Set Search Parameters** - Defines search query and filters
2. **Fetch LinkedIn Jobs Page** - Gets HTML from LinkedIn jobs search
3. **Parse Jobs from HTML** - Extracts job data from HTML
4. **Format Output** - Creates readable markdown output

### Search Parameters:

- **searchQuery:** "Odoo Developer" (job title to search)
- **keywords:** "Odoo,Python,ERP,OpenERP" (related keywords)
- **location:** "Remote" (job location)
- **maxResults:** 25 (number of jobs to return)

## 🔧 Customization

### Change Search Query:

In "Set Search Parameters" node:
```json
"searchQuery": "Odoo Developer"
```

Change to:
- "Python Developer"
- "ERP Developer"
- "Odoo Consultant"
- Any job title

### Change Location:

```json
"location": "Remote"
```

Change to:
- "New York, NY"
- "London, UK"
- "Remote"
- "San Francisco, CA"
- Any location

### Change Number of Results:

```json
"maxResults": "25"
```

Change to any number (10, 50, 100, etc.)

## 📊 Output Format

The workflow returns:

1. **Job List:**
   - Job title
   - Company name
   - Location
   - Job URL
   - Date posted

2. **Markdown Output:**
   - Formatted list with all job details
   - Easy to read and share

3. **Table Output:**
   - Quick overview table
   - Easy to scan

## ⚠️ Important Notes

### LinkedIn Limitations:

- **No Official API:** LinkedIn doesn't have a public job search API
- **Web Scraping:** This workflow uses web scraping
- **Rate Limits:** Don't run too frequently
- **HTML Changes:** LinkedIn may change their HTML structure

### Best Practices:

- ✅ Run once per day (not too frequently)
- ✅ Respect LinkedIn's terms of service
- ✅ Use for personal job searching
- ✅ Don't scrape aggressively

## 🔄 Alternative: Use LinkedIn API (If Available)

If you have LinkedIn API access:

1. **Use LinkedIn API node** instead of HTTP Request
2. **More reliable** than web scraping
3. **Better data structure**

## 🎯 Use Cases

### Personal Job Search:
- Find Odoo Developer jobs
- Get daily job listings
- Track new opportunities

### Automation:
- Schedule daily job search
- Get email notifications
- Save to spreadsheet

### Research:
- Market research
- Salary research
- Company research

## 📖 Example Output

```
# 💼 Odoo Developer Jobs on LinkedIn

**Search Query:** Odoo Developer
**Jobs Found:** 25
**Date:** 2025-11-10T07:20:00.000Z

---

## 1. Senior Odoo Developer

**Company:** Tech Corp
**Location:** Remote
**Posted:** Recent

**Link:** [View Job](https://www.linkedin.com/jobs/view/...)

---
```

## 🔗 Resources

- **LinkedIn Jobs:** https://www.linkedin.com/jobs/
- **Odoo Jobs:** Search "Odoo Developer" on LinkedIn
- **n8n HTTP Request:** https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.httprequest/

---

**Import the workflow and start searching for Odoo Developer jobs! 🚀**

