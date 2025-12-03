# FastAPI Quick Reference Guide

A quick reference for FastAPI concepts covered in the playlist.

---

## 📖 Table of Contents

1. [Installation](#installation)
2. [Basic Application](#basic-application)
3. [Path Parameters](#path-parameters)
4. [Query Parameters](#query-parameters)
5. [Validation](#validation)
6. [Common Patterns](#common-patterns)

---

## 🔧 Installation

### Install FastAPI and Uvicorn
```bash
pip install fastapi uvicorn
```

### Create Virtual Environment
```bash
# Mac/Linux
python3 -m venv venv
source venv/bin/activate

# Windows
python -m venv venv
venv\Scripts\activate
```

### Verify Installation
```bash
which python  # Should point to venv
python --version
```

---

## 🚀 Basic Application

### Hello World
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello World"}

@app.get("/items/{item_id}")
def read_item(item_id: int):
    return {"item_id": item_id}
```

### Run Application
```bash
uvicorn main:app --reload
```

### Access Documentation
- Swagger UI: http://127.0.0.1:8000/docs
- ReDoc: http://127.0.0.1:8000/redoc

---

## 🛣️ Path Parameters

### Basic Path Parameter
```python
@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {"user_id": user_id, "message": f"Hello user {user_id}"}
```

### Multiple Path Parameters
```python
@app.get("/users/{user_id}/posts/{post_id}")
def get_user_post(user_id: int, post_id: int):
    return {"user_id": user_id, "post_id": post_id}
```

### Path Parameter with Enum
```python
from enum import Enum

class UserRole(str, Enum):
    admin = "admin"
    user = "user"
    client = "client"

@app.get("/users/role/{role}")
def get_users_by_role(role: UserRole):
    return {"role": role, "message": f"All {role} users"}
```

### Advanced Validation with Path()
```python
from fastapi import Path

@app.get("/products/{product_id}")
def get_product(
    product_id: int = Path(..., gt=0, description="Product ID must be greater than 0")
):
    return {"product_id": product_id}
```

---

## 🔍 Query Parameters

### Basic Query Parameter
```python
@app.get("/items/")
def read_items(skip: int = 0, limit: int = 10):
    return {"skip": skip, "limit": limit}
```

### Optional Query Parameters
```python
from typing import Optional

@app.get("/items/")
def read_items(q: Optional[str] = None):
    if q:
        return {"q": q}
    return {"message": "No query parameter"}
```

### Query Parameters with Validation
```python
from fastapi import Query

@app.get("/items/")
def read_items(
    q: Optional[str] = Query(None, min_length=3, max_length=50),
    skip: int = Query(0, ge=0),
    limit: int = Query(10, ge=1, le=100)
):
    return {"q": q, "skip": skip, "limit": limit}
```

---

## ✅ Validation

### Type Validation
```python
# FastAPI automatically validates types
@app.get("/items/{item_id}")
def get_item(item_id: int):  # Must be integer
    return {"item_id": item_id}
```

### Path Validation
```python
from fastapi import Path

@app.get("/products/{product_id}")
def get_product(
    product_id: int = Path(..., gt=0, le=1000)
):
    return {"product_id": product_id}
```

### Query Validation
```python
from fastapi import Query

@app.get("/search/")
def search(
    q: str = Query(..., min_length=1, max_length=50),
    page: int = Query(1, ge=1)
):
    return {"q": q, "page": page}
```

---

## 🎯 Common Patterns

### E-Commerce API Example
```python
from fastapi import FastAPI, HTTPException, Path
from enum import Enum
from typing import Optional

app = FastAPI()

class Category(str, Enum):
    electronics = "electronics"
    books = "books"
    home = "home"

# Static database
products_db = {
    1: {"name": "Laptop", "category": "electronics", "price": 999.99},
    2: {"name": "Book", "category": "books", "price": 19.99},
    3: {"name": "Table", "category": "home", "price": 299.99}
}

@app.get("/")
def read_root():
    return {"message": "Welcome to our e-commerce API"}

@app.get("/products/{product_id}")
def get_product(product_id: int = Path(..., gt=0)):
    if product_id not in products_db:
        raise HTTPException(status_code=404, detail="Product not found")
    return products_db[product_id]

@app.get("/products/category/{category}")
def get_products_by_category(category: Category):
    filtered = {
        pid: product 
        for pid, product in products_db.items() 
        if product["category"] == category.value
    }
    return filtered
```

### Error Handling
```python
from fastapi import HTTPException

@app.get("/items/{item_id}")
def get_item(item_id: int):
    if item_id not in items_db:
        raise HTTPException(status_code=404, detail="Item not found")
    return items_db[item_id]
```

---

## 📊 HTTP Methods

```python
@app.get("/items/")      # GET request
@app.post("/items/")      # POST request
@app.put("/items/{id}")   # PUT request
@app.delete("/items/{id}") # DELETE request
```

---

## 🔗 Response Models

```python
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    price: float
    description: Optional[str] = None

@app.post("/items/", response_model=Item)
def create_item(item: Item):
    return item
```

---

## ⚡ Performance Tips

1. **Use async/await** for I/O operations
2. **Type hints** provide automatic validation
3. **Pydantic models** for data validation
4. **Dependency injection** for reusable code

---

## 🎓 Best Practices

1. **Always use type hints** - Automatic validation
2. **Use meaningful names** - Follow REST conventions
3. **Use enums** - For fixed values
4. **Add descriptions** - Better documentation
5. **Handle errors** - Return appropriate status codes
6. **Validate input** - Use Path() and Query()

---

**Last Updated:** 2025-01-27

