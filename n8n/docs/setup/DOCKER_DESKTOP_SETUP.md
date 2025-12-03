# Docker Desktop Setup - Avoid Conflicts

## 🎯 Goal
Install Docker Desktop on Linux without conflicting with existing Docker CLI installation.

## ⚠️ Important Notes

### Docker Desktop vs Docker CLI:
- **Docker CLI:** Command-line Docker (what you have now)
- **Docker Desktop:** GUI application with its own Docker daemon
- **Conflict:** Both try to use Docker socket at `/var/run/docker.sock`

## 📋 Installation Steps

### Step 1: Check Current Docker Installation

```bash
# Check if Docker is running
docker ps

# Check Docker version
docker --version

# Check Docker service
systemctl status docker
```

### Step 2: Install Docker Desktop

#### Option A: Download from Official Site (Recommended)

1. **Download Docker Desktop:**
   ```bash
   cd ~/Downloads
   wget https://desktop.docker.com/linux/main/amd64/docker-desktop-*.deb
   ```

2. **Install:**
   ```bash
   sudo apt install ./docker-desktop-*.deb
   ```

#### Option B: Using Package Manager

```bash
# Add Docker Desktop repository (if available)
# Or download .deb file from docker.com
```

### Step 3: Configure to Avoid Conflicts

#### Method 1: Use Different Docker Context (Recommended)

Docker Desktop uses its own context. Configure it:

1. **Check current context:**
   ```bash
   docker context ls
   ```

2. **Docker Desktop creates:** `desktop-linux` context
3. **Switch between contexts:**
   ```bash
   # Use Docker Desktop
   docker context use desktop-linux
   
   # Use CLI Docker
   docker context use default
   ```

#### Method 2: Stop CLI Docker Service

If you want to use only Docker Desktop:

```bash
# Stop CLI Docker service
sudo systemctl stop docker
sudo systemctl disable docker

# Docker Desktop will manage its own daemon
```

#### Method 3: Use Different Socket (Advanced)

Configure Docker Desktop to use different socket:

1. **Edit Docker Desktop settings:**
   - Open Docker Desktop
   - Settings → Docker Engine
   - Add custom socket path

2. **Or configure CLI Docker:**
   ```bash
   # Edit /etc/docker/daemon.json
   sudo nano /etc/docker/daemon.json
   ```

### Step 4: Start Docker Desktop

```bash
# Start Docker Desktop
systemctl --user start docker-desktop

# Or launch from applications menu
```

## 🔧 Configuration

### Docker Desktop Settings

1. **Open Docker Desktop**
2. **Settings → General:**
   - ✅ Start Docker Desktop when you log in (optional)
   - ✅ Use the WSL 2 based engine (if using WSL)

3. **Settings → Resources:**
   - Adjust CPU/Memory allocation
   - Set disk image location

4. **Settings → Docker Engine:**
   - Configure daemon.json if needed

### Create Alias for Easy Switching

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Docker context switching aliases
alias docker-desktop='docker context use desktop-linux'
alias docker-cli='docker context use default'
alias docker-context='docker context ls'
```

Then:
```bash
source ~/.bashrc
```

## 🎯 Recommended Setup

### For Development (Best Practice):

1. **Keep both installed:**
   - CLI Docker for scripts/automation
   - Docker Desktop for GUI/development

2. **Use contexts to switch:**
   ```bash
   # Check current context
   docker context ls
   
   # Switch to Docker Desktop
   docker context use desktop-linux
   
   # Switch back to CLI
   docker context use default
   ```

3. **Create helper script:**
   ```bash
   # ~/bin/docker-switch
   #!/bin/bash
   if [ "$1" == "desktop" ]; then
       docker context use desktop-linux
       echo "✅ Switched to Docker Desktop"
   elif [ "$1" == "cli" ]; then
       docker context use default
       echo "✅ Switched to CLI Docker"
   else
       docker context ls
   fi
   ```

## ⚠️ Troubleshooting

### Issue: "Cannot connect to Docker daemon"

**Solution:**
```bash
# Check which Docker is running
docker context ls

# Switch to correct context
docker context use desktop-linux  # or default
```

### Issue: Port conflicts

**Solution:**
- Docker Desktop uses different ports
- Check Docker Desktop settings
- Stop CLI Docker: `sudo systemctl stop docker`

### Issue: Permission denied

**Solution:**
```bash
# Add user to docker group (for CLI)
sudo usermod -aG docker $USER
newgrp docker
```

## 📋 Quick Reference

### Check Status:
```bash
# Docker contexts
docker context ls

# Docker Desktop status
systemctl --user status docker-desktop

# CLI Docker status
systemctl status docker
```

### Switch Contexts:
```bash
docker context use desktop-linux  # Docker Desktop
docker context use default         # CLI Docker
```

### Start/Stop:
```bash
# Docker Desktop
systemctl --user start docker-desktop
systemctl --user stop docker-desktop

# CLI Docker
sudo systemctl start docker
sudo systemctl stop docker
```

## 🎯 For n8n Specifically

Since you're using n8n in Docker:

1. **Use Docker Desktop context:**
   ```bash
   docker context use desktop-linux
   ```

2. **Start n8n:**
   ```bash
   docker start n8n
   # or use scripts/start_n8n.sh
   ```

3. **Both will work** - just make sure you're using the correct context!

---

**Install Docker Desktop and configure contexts to avoid conflicts! 🚀**

