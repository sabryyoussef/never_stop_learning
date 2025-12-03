# YouTube Transcript MCP Setup for Cursor

## ✅ Installed MCP Server

**Package:** `@kimtaeyoon83/mcp-server-youtube-transcript`  
**Version:** 0.1.1  
**License:** MIT  
**Repository:** https://github.com/kimtaeyoon83/mcp-server-youtube-transcript

## 📦 Configuration

Added to `/home/sabry3/.cursor/mcp.json`:

```json
{
  "youtube-transcript": {
    "command": "npx",
    "args": [
      "-y",
      "@kimtaeyoon83/mcp-server-youtube-transcript"
    ]
  }
}
```

## 🚀 How to Use

### After Restarting Cursor:

#### Method 1: Direct Request
Ask Cursor AI:
```
"Extract the transcript from https://www.youtube.com/watch?v=VIDEO_ID"
```

#### Method 2: Save to File
Ask Cursor AI:
```
"Get the transcript from this video and save it to a markdown file:
https://www.youtube.com/watch?v=VIDEO_ID"
```

#### Method 3: Specific Language
Ask Cursor AI:
```
"Extract the English transcript from https://www.youtube.com/watch?v=VIDEO_ID"
```

## 🎯 Example Use Cases for Your Learning Path

### Extract Raghav Pal's Playwright Tutorials
```
"Extract transcript from Raghav Pal's Playwright Tutorial 4:
https://www.youtube.com/watch?v=wuWLpsRwB5o
and save it to phase3_playwright/lessons/video-04-transcript.md"
```

### Extract Cypress Tutorial
```
"Get the transcript from this Cypress tutorial and format it with timestamps:
https://www.youtube.com/watch?v=CYPRESS_VIDEO_ID"
```

### Batch Extract for All Phase Videos
```
"Extract transcripts from these videos and save them:
1. Video 1: URL
2. Video 2: URL
3. Video 3: URL"
```

## 🔧 Features

- ✅ **Direct YouTube transcript download** - No AI needed
- ✅ **Multiple language support** - Get transcripts in any available language
- ✅ **Auto-generated captions** - Works with auto-generated subtitles
- ✅ **Simple interface** - Just provide the video URL
- ✅ **No API keys required** - Completely free to use
- ✅ **Fast extraction** - Gets transcripts in seconds

## 📝 Supported Video Types

- ✅ YouTube videos with captions
- ✅ Videos with auto-generated subtitles
- ✅ Multi-language videos
- ✅ Educational tutorials (like your learning videos!)
- ✅ Long-form content

## 🔄 Restart Required

**IMPORTANT:** You must restart Cursor for the MCP server to become active!

### Steps:
1. **Close Cursor completely**
2. **Reopen Cursor**
3. **Test the MCP:**
   - Ask: "List available MCP servers"
   - Should see `youtube-transcript` in the list

## 🎓 Perfect for Your Automation Learning Path

Use this to automatically extract transcripts from:

### Phase 1: Testing Mindset
- 5-Step Process video
- How to Start Learning Automation

### Phase 2: API Testing
- Postman Tutorial 1
- Postman Tutorial 3

### Phase 3: Playwright (Primary)
- What is Playwright
- Install Playwright
- Record and Run First Test ✅ (Video you just tried!)
- Locators and Assertions
- Hooks & Groups

### Phase 4: Cypress
- Cypress Complete Beginners Masterclass

### Phase 5: Selenium
- Selenium 4 Introduction & Setup

### Phase 6: Jenkins
- Jenkins Introduction
- Install Jenkins
- Create First Job

### Phase 7: Performance
- JMeter Full Course

## 💡 Tips for Best Results

1. **Always provide the full YouTube URL**
2. **Specify the output format** (markdown, plain text, etc.)
3. **Request timestamps** if you want time-coded transcripts
4. **Mention the language** if video has multiple subtitle options
5. **Ask for formatting** (bullet points, sections, etc.)

## 🐛 Troubleshooting

### MCP Not Available After Restart
- Check Cursor logs: Settings → Advanced → View Logs
- Verify JSON syntax: `jq '.' ~/.cursor/mcp.json`
- Try reinstalling: `npx -y @kimtaeyoon83/mcp-server-youtube-transcript`

### Video Has No Transcript
- Check if video has captions on YouTube
- Try videos from educational channels (they usually have captions)
- Auto-generated captions work too!

### Slow Response
- First use might be slower (downloads package)
- Subsequent uses should be fast
- Large videos might take longer

## 📊 Alternative MCP Servers (If Needed)

If this one doesn't work, here are backups:

1. **@sinco-lab/mcp-youtube-transcript** - More features, slightly complex
2. **jackhp/mcp-youtube-transcribe** - Falls back to Whisper AI
3. **nattyraz/youtube-mcp** - LLM-optimized output
4. **demon24ru/video-transcribe-mcp** - Multi-platform support

## 🎉 Benefits for Your Learning

- 📝 **Automatic note-taking** - Get full transcripts instantly
- 🔍 **Searchable content** - Find specific topics quickly
- 📚 **Reference material** - Keep transcripts for future review
- ✍️ **Better notes** - Combine transcripts with your observations
- ⏱️ **Time-saving** - No manual typing needed
- 🎯 **Focus on learning** - Not on note-taking

## 📅 Setup Date

**Installed:** 2025-11-06  
**Last Updated:** 2025-11-06  
**Status:** ✅ Ready to use after Cursor restart

---

**Next Step:** Restart Cursor and try extracting your first transcript! 🚀

**Test Command:**
```
"Extract the transcript from https://www.youtube.com/watch?v=wuWLpsRwB5o"
```

