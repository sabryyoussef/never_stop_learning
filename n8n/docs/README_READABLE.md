# Readable Output Tests

All test workflows now include **readable output fields** that make results easy to read!

## 📊 Output Fields

Each workflow now includes:

### 1. `readableOutput` or `readableReport`
- **Plain text format** with emojis
- **Easy to read** in n8n output
- **Formatted with lines** and sections

### 2. `markdownOutput` or `markdownReport`
- **Markdown format** for documentation
- **Can be copied** to markdown files
- **Formatted tables** and lists

## 🎯 Available Tests

### `simple_test.json`
**Output includes:**
- `readableOutput` - Plain text with emojis
- `markdownOutput` - Markdown formatted report

**Example readable output:**
```
✅ Test Successful!

📝 Message: Hello from n8n!
📅 Timestamp: 2025-11-10T15:30:00.000Z
🔢 Test Number: 42
```

### `simple_test_with_http.json`
**Output includes:**
- `readableOutput` - Markdown formatted HTTP results
- `summary` - Short summary text

**Example readable output:**
```
# 📊 HTTP Test Results

## ✅ Request Successful

**Title:** Sample Slide Show
**Author:** Yours Truly
**Date:** 2025-11-10T15:30:00.000Z
```

### `simple_test_readable.json` ⭐ NEW
**Most readable format:**
- `readableReport` - Formatted text report with borders
- `markdownReport` - Complete markdown report with table

**Example readable output:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   📋 TEST REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Status: Success
📝 Test Name: Simple n8n Test
📅 Executed: 2025-11-10 15:30:00
```

## 🚀 How to View Readable Output

1. **Import workflow** into n8n
2. **Execute workflow**
3. **Click on the Set node** (last node)
4. **Look for these fields:**
   - `readableOutput` or `readableReport`
   - `markdownOutput` or `markdownReport`
5. **Copy the value** to see formatted output

## 💡 Tips

### View in n8n:
- Click the node output
- Look for the readable fields
- Copy the text to see formatting

### Use in Documentation:
- Copy `markdownOutput` field
- Paste into `.md` file
- View as formatted markdown

### Customize:
- Edit the Set node
- Modify the `readableOutput` value
- Add your own formatting

## 📝 Formatting Examples

### Plain Text with Emojis:
```
✅ Status: Success
📝 Message: Hello
📅 Date: 2025-11-10
```

### Markdown Format:
```markdown
# Title
## Section
- List item
- Another item
```

### Text with Borders:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   HEADER
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

**All tests now have readable output! 🎉**

