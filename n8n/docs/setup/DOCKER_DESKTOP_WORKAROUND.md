# Docker Desktop Workaround - Context Switching

## ⚠️ Issue
Docker Desktop keeps recreating its own socket, so symlink approach doesn't work reliably.

## ✅ Solution: Use Context Switching

Instead of merging daemons, use **easy context switching** to access CLI Docker containers.

## 🚀 Quick Solution

### Create a CLI Docker Context

```bash
docker context create cli-docker --docker "host=unix:///var/run/docker.sock"
```

### Use It

```bash
# Switch to CLI Docker
docker context use cli-docker

# See all your containers (including n8n)
docker ps -a

# Switch back to Docker Desktop
docker context use desktop-linux
```

### Or Use Helper Script

```bash
./scripts/quick_docker_switch.sh cli      # Switch to CLI, show containers
./scripts/quick_docker_switch.sh desktop  # Switch to Desktop
```

## 🎯 Best Practice

### For Docker Desktop GUI:
- Docker Desktop GUI will show containers from **current context**
- Switch context first: `docker context use cli-docker`
- Then open Docker Desktop GUI
- You'll see all CLI Docker containers!

### For CLI:
- Use `cli-docker` context for CLI Docker containers
- Use `desktop-linux` for Docker Desktop containers
- Use `default` for system Docker

## 📋 Contexts Available

1. **`default`** - System CLI Docker (your n8n is here)
2. **`desktop-linux`** - Docker Desktop's daemon
3. **`cli-docker`** - Points to CLI Docker (same as default, but explicit)

## 💡 Why This Works Better

- ✅ No socket conflicts
- ✅ No permission issues
- ✅ Docker Desktop doesn't interfere
- ✅ Easy to switch
- ✅ Both tools work independently

## 🔄 Quick Commands

```bash
# See CLI Docker containers
docker context use cli-docker && docker ps -a

# See Docker Desktop containers  
docker context use desktop-linux && docker ps -a

# Check current context
docker context ls
```

---

**Use context switching - it's more reliable! 🚀**

