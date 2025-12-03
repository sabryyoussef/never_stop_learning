# Docker Contexts Explained

## ⚠️ Important: Contexts Are Separate!

**No, switching contexts does NOT show all Docker resources on your machine.**

Each Docker context connects to a **different Docker daemon**, and they have **separate**:
- Containers
- Images
- Volumes
- Networks
- Everything!

## 🔍 How Docker Contexts Work

### Context 1: `default` (CLI Docker)
- Connects to: System Docker daemon (`docker.service`)
- Location: `/var/run/docker.sock`
- Managed by: systemd
- Your n8n container is here!

### Context 2: `desktop-linux` (Docker Desktop)
- Connects to: Docker Desktop's daemon
- Location: Docker Desktop's internal daemon
- Managed by: Docker Desktop GUI
- Separate from CLI Docker

## 📋 What This Means

### When you switch contexts:

```bash
# Switch to CLI Docker
docker context use default
docker ps -a
# Shows: n8n container (and others in CLI Docker)

# Switch to Docker Desktop
docker context use desktop-linux
docker ps -a
# Shows: Only containers in Docker Desktop (probably empty)
```

### Your n8n container:
- **Location:** CLI Docker (`default` context)
- **To see it:** Use `default` context
- **In Docker Desktop:** Won't see it unless you switch contexts

## 🎯 Best Practice

### For Your n8n Container:

**Keep using CLI Docker context:**
```bash
docker context use default
docker ps -a  # See your n8n container
docker start n8n
```

**Or use Docker Desktop:**
- Switch context to `desktop-linux`
- But your n8n container won't be there
- You'd need to recreate it in Docker Desktop

## 🔄 Switching Between Contexts

### Check current context:
```bash
docker context ls
```

### Switch to CLI Docker:
```bash
docker context use default
```

### Switch to Docker Desktop:
```bash
docker context use desktop-linux
```

### Use helper script:
```bash
./scripts/docker_switch_context.sh default  # CLI Docker
./scripts/docker_switch_context.sh desktop   # Docker Desktop
```

## 📊 View Resources in Each Context

### Script to compare both contexts:

```bash
#!/bin/bash
echo "=== CLI Docker (default) ==="
docker context use default
docker ps -a
docker images

echo ""
echo "=== Docker Desktop ==="
docker context use desktop-linux
docker ps -a
docker images
```

## 💡 Recommendations

### Option 1: Use CLI Docker for n8n (Current Setup)
- ✅ Your n8n container is already here
- ✅ Works with your scripts
- ✅ No changes needed

### Option 2: Migrate to Docker Desktop
- Create n8n container in Docker Desktop
- Use Docker Desktop GUI
- Switch context to `desktop-linux`

### Option 3: Use Both
- CLI Docker for n8n (current setup)
- Docker Desktop for other projects
- Switch contexts as needed

## ⚠️ Important Notes

1. **Containers are NOT shared** between contexts
2. **Images are NOT shared** (but can be pulled in both)
3. **Volumes are NOT shared**
4. **Networks are NOT shared**

## 🎯 For Your Current Setup

**Your n8n container is in CLI Docker (`default` context).**

To work with it:
```bash
# Make sure you're on default context
docker context use default

# See your containers
docker ps -a

# Start n8n
docker start n8n
```

**Docker Desktop won't see your n8n container** unless you:
1. Export it from CLI Docker
2. Import it into Docker Desktop
3. Or recreate it in Docker Desktop

---

**Contexts are separate - choose one for your n8n container! 🚀**

