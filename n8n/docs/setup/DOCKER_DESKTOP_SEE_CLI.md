# Make Docker Desktop See CLI Docker Containers

## 🎯 Goal
Make Docker Desktop GUI show your CLI Docker containers (like n8n).

## ⚠️ Important Warning

**This makes Docker Desktop use CLI Docker's daemon directly.**
- ✅ You'll see all CLI Docker containers in Docker Desktop GUI
- ⚠️ Both tools use the same Docker daemon (may conflict)
- ⚠️ Be careful with simultaneous operations

## 🚀 Quick Setup

### Option 1: Symlink Method (Recommended)

Run this script:
```bash
./scripts/configure_docker_desktop_for_cli.sh
```

**What it does:**
1. Stops Docker Desktop
2. Creates symlink: `~/.docker/desktop/docker.sock` → `/var/run/docker.sock`
3. Restarts Docker Desktop
4. Now Docker Desktop uses CLI Docker's daemon!

**After running:**
- Open Docker Desktop GUI
- You'll see your n8n container and all CLI Docker containers!
- Both Docker Desktop and CLI Docker see the same containers

### Option 2: Easy Context Switching

Use the quick switcher script:
```bash
./scripts/quick_docker_switch.sh cli      # Switch to CLI, show containers
./scripts/quick_docker_switch.sh desktop  # Switch to Desktop, show containers
./scripts/quick_docker_switch.sh show     # Show current context containers
```

## 🔄 Revert to Separate Daemons

If you want Docker Desktop to use its own daemon again:
```bash
./scripts/revert_docker_desktop_config.sh
```

## 📋 Manual Method

If you prefer to do it manually:

1. **Stop Docker Desktop:**
   ```bash
   systemctl --user stop docker-desktop
   ```

2. **Backup original socket:**
   ```bash
   sudo mv ~/.docker/desktop/docker.sock ~/.docker/desktop/docker.sock.backup
   ```

3. **Create symlink:**
   ```bash
   sudo ln -sf /var/run/docker.sock ~/.docker/desktop/docker.sock
   ```

4. **Fix permissions:**
   ```bash
   sudo chown $USER:$USER ~/.docker/desktop/docker.sock
   ```

5. **Start Docker Desktop:**
   ```bash
   systemctl --user start docker-desktop
   ```

## ✅ After Configuration

1. **Open Docker Desktop GUI**
2. **You should see:**
   - Your n8n container
   - All other CLI Docker containers
   - All images, volumes, networks from CLI Docker

3. **You can now:**
   - Manage containers from Docker Desktop GUI
   - Use CLI Docker commands
   - Both see the same containers!

## ⚠️ Important Notes

### Conflicts to Watch For:
- Don't start/stop the same container from both tools simultaneously
- Be careful with volume operations
- Network operations may conflict

### Best Practice:
- Use Docker Desktop GUI for visual management
- Use CLI for scripts/automation
- Just be aware both are using the same daemon

## 🔍 Verify It Works

1. **Check symlink:**
   ```bash
   ls -la ~/.docker/desktop/docker.sock
   # Should show: ... -> /var/run/docker.sock
   ```

2. **Open Docker Desktop GUI**
3. **Check Containers tab**
4. **You should see n8n and other containers!**

## 🎯 Alternative: Use Context Switching

If you don't want to merge daemons, use easy context switching:

```bash
# Quick switch to CLI Docker
./scripts/quick_docker_switch.sh cli

# Quick switch to Docker Desktop  
./scripts/quick_docker_switch.sh desktop
```

This keeps them separate but makes switching easy.

---

**Choose: Merge daemons (see all in Desktop) or Easy switching (keep separate)! 🚀**

