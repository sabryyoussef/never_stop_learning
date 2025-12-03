# Phase 2 Video Notes - Extracted from Transcripts

This file contains key points extracted directly from the YouTube video transcripts.

---

## Lesson 3 Video: FastAPI Creating Hello World First App

**Video ID:** ezIBL1gROX8  
**Title:** FastAPI Creating Hello World First App | By Weblearns

### Key Points:

#### 1. Creating the Application

**Basic Structure:**
```python
from fastapi import FastAPI

# Create FastAPI instance
app = FastAPI()

# Define root endpoint
@app.get("/")
def read_root():
    return {"message": "Hello World"}
```

**Key Components:**
- Import FastAPI class
- Create instance called `app`
- Use decorator `@app.get("/")` to define route
- Function returns response data

#### 2. Running the Application

**Command:**
```bash
uvicorn main:app --reload
```

**Breakdown:**
- `main` - Name of Python file (main.py)
- `app` - FastAPI instance name
- `--reload` - Auto-reload on code changes (development mode)

**Server:**
- Runs on port 8000 by default
- Access at: `http://127.0.0.1:8000`

#### 3. Accessing the API

**Root Endpoint:**
- URL: `http://127.0.0.1:8000/`
- Returns: `{"message": "Hello World"}`

**Swagger Documentation:**
- URL: `http://127.0.0.1:8000/docs`
- Interactive API documentation
- Test endpoints directly
- See request/response schemas

#### 4. Key Concepts

**FastAPI Instance:**
- `app = FastAPI()` creates the application instance
- Used with decorators to define routes
- Can be any valid Python variable name

**Route Decorators:**
- `@app.get("/")` - Maps to root URL
- Function name can be anything
- Function returns response data

**Automatic Features:**
- FastAPI handles routing
- Automatic validation
- Automatic documentation
- You focus on business logic

---

## Lesson 4 Video: Parameters in FastAPI Query String

**Video ID:** CzpsA1ydyjg  
**Title:** Parameters in FastAPI Query String | By Weblearns

### Key Points:

#### 1. Understanding Parameters

**What are Parameters:**
- Dynamic parts of the URL
- Placeholders that capture values
- Example: `/products/23/mobile` - 23 and mobile are parameters
- Make APIs flexible and dynamic

#### 2. Basic Path Parameter

**Simple Example:**
```python
@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {"user_id": user_id, "message": f"Hello user {user_id}"}
```

**How it Works:**
- Curly braces `{user_id}` in path capture value
- FastAPI automatically passes to function parameter
- Type hint `int` provides validation

#### 3. Type Validation

**Automatic Validation:**
```python
@app.get("/users/{user_id}")
def get_user(user_id: int):  # Must be integer
    return {"user_id": user_id}
```

**Behavior:**
- FastAPI converts valid string to integer
- Returns detailed validation error for invalid input
- No manual validation code needed
- Example: "123" → 123 (valid), "abc" → error (invalid)

#### 4. Multiple Path Parameters

**Example:**
```python
@app.get("/users/{user_id}/posts/{post_id}")
def get_user_post(user_id: int, post_id: int):
    return {"user_id": user_id, "post_id": post_id}
```

**Key Points:**
- Order of parameters doesn't matter
- Matched by name, not position
- Each parameter validated independently
- Test: `/users/32/posts/90` → Returns both IDs

#### 5. Enum Parameters

**Implementation:**
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

**Benefits:**
- Only allowed values accepted
- Perfect validation with zero effort
- Self-documenting in API docs
- Prevents typos and errors

**Testing:**
- Valid: `/users/role/admin` → Works
- Invalid: `/users/role/invalid` → Validation error

#### 6. Advanced Validation with Path()

**Example:**
```python
from fastapi import Path

@app.get("/products/{product_id}")
def get_product(
    product_id: int = Path(
        ...,
        gt=0,
        description="Product ID must be greater than 0"
    )
):
    return {"product_id": product_id}
```

**Validation Options:**
- `gt=0` - Greater than 0
- `ge=1` - Greater than or equal to 1
- `lt=100` - Less than 100
- `le=100` - Less than or equal to 100
- `regex="pattern"` - Regular expression pattern
- `description` - Description for documentation

#### 7. E-Commerce API Example

**Complete Example:**
```python
from fastapi import FastAPI, HTTPException, Path
from enum import Enum

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
    if not filtered:
        raise HTTPException(
            status_code=404, 
            detail="Product not in specified category"
        )
    return filtered
```

**Features:**
- Multiple endpoints
- Error handling with HTTPException
- Category filtering
- Product lookup
- Validation on all parameters

#### 8. Best Practices

**From Video:**
1. **Use Type Hints Always**
   - Automatic validation
   - Better documentation
   - More readable code

2. **Use Meaningful Names**
   - Descriptive parameter names
   - Follow REST conventions
   - Example: `user_id` not `id`

3. **Use Enums for Fixed Values**
   - Better validation than strings
   - Self-documenting
   - Prevents errors

4. **Add Path() for Complex Validation**
   - Set ranges (min, max)
   - Add length constraints
   - Use regex patterns
   - Add descriptions

5. **Handle Edge Cases**
   - Always validate business logic
   - Return appropriate HTTP status codes
   - Provide clear error messages

---

## Summary

### Hello World (Lesson 3):
- Create FastAPI instance
- Define routes with decorators
- Run with Uvicorn
- Access Swagger documentation
- Simple, clean, and powerful

### Path Parameters (Lesson 4):
- Basic path parameters
- Type validation
- Multiple parameters
- Enum parameters
- Advanced validation with Path()
- Real-world e-commerce example
- Best practices

---

**Note:** These notes are extracted from actual video transcripts. The videos provide hands-on examples and real-world API implementations.

