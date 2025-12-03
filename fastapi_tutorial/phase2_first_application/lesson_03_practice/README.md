# Lesson 3 Practice: FastAPI Hello World Application

**Lesson:** [Lesson 3: FastAPI Creating Hello World First App](../lesson_03_hello_world_app.md)  
**Status:** 🔄 In Progress  
**Date Started:** 2025-01-27

---

## 🎯 Practice Project Overview

This practice project implements a FastAPI Hello World application to reinforce the concepts learned in Lesson 3.

**Project Location:** `~/dev/fastapi/odoo_integration`  
**Full Path:** `/home/sabry3/dev/fastapi/odoo_integration`

---

## 📁 Project Structure

```
odoo_integration/
├── venv/              # Virtual environment
├── main.py            # FastAPI application (to be created)
├── requirements.txt   # Dependencies (to be created)
└── README.md          # Project documentation (to be created)
```

---

## ✅ Setup Completed

- [x] Created project directory
- [x] Created Python virtual environment
- [x] Activated virtual environment
- [x] Upgraded pip to latest version
- [x] Installed FastAPI
- [x] Installed Uvicorn (with standard extras)
- [x] Installed httpx (for testing)
- [x] Installed python-dotenv (for environment variables)

---

## 📦 Installed Packages

```bash
fastapi==0.123.1
uvicorn[standard]==0.38.0
httpx==0.28.1
python-dotenv==1.2.1
```

---

## 🚀 Next Steps

### Step 1: Create main.py
Create a basic FastAPI application with a Hello World endpoint.

### Step 2: Create requirements.txt
Document all project dependencies.

### Step 3: Run the Application
Start the FastAPI server using Uvicorn.

### Step 4: Test the Application
- Access the root endpoint
- Test Swagger documentation
- Try different endpoints

---

## 💻 Practice Exercises

### Exercise 1: Basic Hello World
- [ ] Create `main.py` with FastAPI instance
- [ ] Add root endpoint (`/`)
- [ ] Return `{"message": "Hello World"}`
- [ ] Run with `uvicorn main:app --reload`
- [ ] Test in browser at `http://127.0.0.1:8000`

### Exercise 2: Additional Endpoints
- [ ] Add `/about` endpoint
- [ ] Add `/health` endpoint
- [ ] Add dynamic endpoint with path parameter
- [ ] Test all endpoints

### Exercise 3: Explore Swagger UI
- [ ] Access Swagger at `http://127.0.0.1:8000/docs`
- [ ] Test endpoints from Swagger interface
- [ ] Explore API documentation
- [ ] Try "Try it out" feature

---

## 📝 Notes

- Virtual environment is activated and ready
- All dependencies are installed
- Ready to start coding!

---

## 🔗 Related Resources

- [Lesson 3: FastAPI Creating Hello World First App](../lesson_03_hello_world_app.md)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Uvicorn Documentation](https://www.uvicorn.org/)

