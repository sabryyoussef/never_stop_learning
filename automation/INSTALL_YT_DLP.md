# Installing yt-dlp for YouTube MCP

## 🎯 Why Needed?

The `@kazuph/mcp-youtube` server requires `yt-dlp` to download YouTube transcripts.

## 📦 Installation Options

### Option 1: Using apt (Recommended for Ubuntu)
```bash
sudo apt update
sudo apt install yt-dlp
```

### Option 2: Using pipx (No sudo needed)
```bash
# Install pipx if not installed
python3 -m pip install --user pipx
python3 -m pipx ensurepath

# Install yt-dlp
pipx install yt-dlp
```

### Option 3: Using snap
```bash
sudo snap install yt-dlp
```

### Option 4: Download binary directly
```bash
# Download to local bin directory
mkdir -p ~/.local/bin
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o ~/.local/bin/yt-dlp
chmod +x ~/.local/bin/yt-dlp

# Add to PATH if needed
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## ✅ Verify Installation

```bash
yt-dlp --version
```

Should show something like: `2023.11.16`

## 🔄 After Installation

1. **No need to restart Cursor!** The MCP will automatically use yt-dlp
2. **Test it:** Ask me to extract a YouTube transcript
3. **It will work!**

## 🎬 Then You Can Use

Just ask me:
```
"Extract the transcript from https://www.youtube.com/watch?v=LTwg0kqdK4I"
```

And the MCP will work!

