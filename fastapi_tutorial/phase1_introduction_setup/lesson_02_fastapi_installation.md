# Lesson 2: FastAPI Installation on Mac

**Video:** https://www.youtube.com/watch?v=jQmi3PFpZR4  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Install FastAPI and Uvicorn
- Create project directory structure
- Set up virtual environment
- Activate and deactivate virtual environment
- Verify installation
- Understand project setup

---

## 📝 Key Concepts

### Installing FastAPI and Uvicorn

- **FastAPI** is the Python framework for building APIs
- **Uvicorn** is an ASGI server that runs FastAPI applications
- Both need to be installed to get started

### Virtual Environment

- **Virtual environment** isolates project dependencies
- Prevents conflicts with other Python projects
- Best practice for Python development
- Each project has its own environment

### Project Structure

- Create organized project directories
- Keep code organized and maintainable
- Follow Python project best practices

---

## 💻 Step-by-Step Instructions

### Step 1: Install FastAPI and Uvicorn

```bash
# Install both FastAPI and Uvicorn
pip install fastapi uvicorn
```

**Note:** This installs both packages in your current Python environment.

### Step 2: Create Project Directory

```bash
# Create main code directory
mkdir code

# Navigate to code directory
cd code

# Create project directory
mkdir hello_world

# Navigate to project directory
cd hello_world
```

**Project Structure:**
```
code/
└── hello_world/
    └── (your project files here)
```

### Step 3: Create Virtual Environment

```bash
# For Python 3 (Mac/Linux)
python3 -m venv venv

# Alternative (if python3 doesn't work)
python -m venv venv
```

**What this does:**
- Creates a `venv` folder in your project directory
- Contains isolated Python environment
- All packages installed here won't affect system Python

### Step 4: Activate Virtual Environment

```bash
# Mac/Linux
source venv/bin/activate

# Windows
venv\Scripts\activate
```

**After activation:**
- Terminal prompt shows `(venv)`
- All Python commands use virtual environment
- Packages install to venv, not system

### Step 5: Verify Virtual Environment

```bash
# Check which Python is being used
which python

# Should show path to venv/bin/python
# Example: /path/to/hello_world/venv/bin/python
```

**Confirmation:**
- Path should point to `venv/bin/python`
- Confirms you're using virtual environment

### Step 6: Install FastAPI in Virtual Environment

```bash
# Now install FastAPI in the virtual environment
pip install fastapi uvicorn
```

**Important:** Install after activating venv to ensure packages go to venv.

### Step 7: Deactivate Virtual Environment

```bash
# When done working
deactivate
```

**After deactivation:**
- Returns to system Python
- `(venv)` disappears from prompt
- Virtual environment is inactive

---

## 🎯 Practice Exercises

### Exercise 1: Installation
- [ ] Install FastAPI and Uvicorn
- [ ] Verify installation with `pip list`
- [ ] Check FastAPI version
- [ ] Check Uvicorn version

### Exercise 2: Project Setup
- [ ] Create project directory structure
- [ ] Create virtual environment
- [ ] Activate virtual environment
- [ ] Verify virtual environment is active

### Exercise 3: Verification
- [ ] Check Python path points to venv
- [ ] Install FastAPI in venv
- [ ] Verify FastAPI is installed
- [ ] Practice activate/deactivate

---

## 📌 Important Notes

### Virtual Environment Best Practices

1. **Always use virtual environments** - Isolate project dependencies
2. **Activate before installing** - Ensures packages go to venv
3. **Deactivate when done** - Return to system Python
4. **One venv per project** - Don't share venv across projects

### Installation Checklist

- [ ] Python 3.7+ installed
- [ ] pip is up to date
- [ ] Virtual environment created
- [ ] Virtual environment activated
- [ ] FastAPI installed
- [ ] Uvicorn installed
- [ ] Installation verified

### Common Issues

**Issue:** `python3` command not found  
**Solution:** Use `python` instead, or install Python 3

**Issue:** Virtual environment not activating  
**Solution:** Check path, use full path: `source /full/path/to/venv/bin/activate`

**Issue:** Packages installing to system  
**Solution:** Make sure venv is activated before installing

---

## 🔗 Related Topics

- Python virtual environments
- pip package management
- Python project structure
- Environment variables
- Package management

---

## ❓ Common Questions

**Q: Do I need to activate venv every time?**  
A: Yes, activate it each time you work on the project in a new terminal session.

**Q: Can I use the same venv for multiple projects?**  
A: Not recommended. Create a separate venv for each project.

**Q: What if I forget to activate venv?**  
A: Packages will install to system Python. Always check with `which python` first.

**Q: How do I remove a virtual environment?**  
A: Simply delete the `venv` folder. No special uninstall needed.

---

## 📚 Additional Resources

- [Python venv Documentation](https://docs.python.org/3/library/venv.html)
- [pip User Guide](https://pip.pypa.io/en/stable/user_guide/)
- [FastAPI Installation Guide](https://fastapi.tiangolo.com/#installation)

---

**Previous Lesson:** [Lesson 1: What is FastAPI](./lesson_01_what_is_fastapi.md)  
**Next Lesson:** [Lesson 3: FastAPI Creating Hello World First App](../phase2_first_application/lesson_03_hello_world_app.md)

---

## 📝 Video Notes (from transcript)

### Key Points from Video:

1. **Installation Command:**
   ```bash
   pip install fastapi uvicorn
   ```
   - Installs both FastAPI framework and Uvicorn server
   - Can be done in system Python or virtual environment

2. **Project Directory Structure:**
   ```bash
   mkdir code
   cd code
   mkdir hello_world
   cd hello_world
   ```

3. **Virtual Environment Creation:**
   ```bash
   # For Python 3
   python3 -m venv venv
   
   # If python3 doesn't work
   python -m venv venv
   ```

4. **Activating Virtual Environment:**
   ```bash
   # Mac/Linux
   source venv/bin/activate
   
   # Windows (different command)
   ```

5. **Verification:**
   ```bash
   which python
   # Should show: /path/to/venv/bin/python
   ```

6. **Deactivating:**
   ```bash
   deactivate
   ```

### Important Notes from Video:
- Virtual environment ensures dependencies are isolated
- Always activate venv before installing packages
- Check Python path to confirm venv is active
- Deactivate when done working on project

