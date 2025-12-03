# Create Odoo 16, 17, 18, 19 in Docker Desktop

## 🎯 Goal
Create Odoo containers in Docker Desktop, keeping n8n in default (CLI Docker) context.

## ✅ Current Status
- ✅ Dead containers removed from default context
- ✅ n8n remains in default context
- ✅ Ready to create Odoo in Docker Desktop

## 🚀 Quick Setup

### Option 1: Using Docker Compose (Recommended)

1. **Switch to Docker Desktop context:**
   ```bash
   docker context use desktop-linux
   ```

2. **Start Odoo stack:**
   ```bash
   cd /home/sabry3/never_stop_learning/n8n
   docker-compose -f docker-compose-odoo.yml up -d
   ```

3. **Access Odoo:**
   - Odoo 16: http://localhost:80616
   - Odoo 17: http://localhost:80617
   - Odoo 18: http://localhost:80618
   - Odoo 19: http://localhost:80619

### Option 2: Using Script

```bash
./scripts/create_odoo_docker_desktop.sh
```

### Option 3: Manual Creation

```bash
# Switch to Docker Desktop
docker context use desktop-linux

# Create PostgreSQL database
docker run -d --name odoo-db \
  -e POSTGRES_DB=postgres \
  -e POSTGRES_USER=odoo \
  -e POSTGRES_PASSWORD=odoo \
  postgres:15

# Create Odoo containers
for version in 16 17 18 19; do
  docker run -d --name odoo-$version \
    --link odoo-db:db \
    -p 806$version:8069 \
    -e HOST=db \
    odoo:$version
done
```

## 📋 What Gets Created

### In Docker Desktop Context:
- ✅ PostgreSQL database container
- ✅ Odoo 16 container
- ✅ Odoo 17 container
- ✅ Odoo 18 container
- ✅ Odoo 19 container

### In Default Context:
- ✅ n8n container (unchanged)

## 🔍 Verify

### Check Docker Desktop containers:
```bash
docker context use desktop-linux
docker ps -a
```

### Check default context (n8n):
```bash
docker context use default
docker ps -a
```

## 🌐 Access URLs

After creation:
- **Odoo 16:** http://localhost:80616
- **Odoo 17:** http://localhost:80617
- **Odoo 18:** http://localhost:80618
- **Odoo 19:** http://localhost:80619
- **n8n:** http://localhost:5678 (default context)

## 🛑 Stop/Start

### Stop all Odoo:
```bash
docker context use desktop-linux
docker-compose -f docker-compose-odoo.yml stop
```

### Start all Odoo:
```bash
docker context use desktop-linux
docker-compose -f docker-compose-odoo.yml start
```

### Stop individual:
```bash
docker context use desktop-linux
docker stop odoo-16  # or odoo-17, odoo-18, odoo-19
```

## 🗑️ Remove

### Remove all Odoo:
```bash
docker context use desktop-linux
docker-compose -f docker-compose-odoo.yml down
```

### Remove individual:
```bash
docker context use desktop-linux
docker rm -f odoo-16  # or odoo-17, odoo-18, odoo-19
```

---

**Create Odoo containers in Docker Desktop! 🚀**

