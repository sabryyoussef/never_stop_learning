# Lesson 4: Parameters in FastAPI Query String

**Video:** https://www.youtube.com/watch?v=CzpsA1ydyjg  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Understand path parameters
- Learn type validation in FastAPI
- Master multiple path parameters
- Use enum parameters
- Apply advanced validation with Path()
- Build real-world API examples
- Follow best practices for path parameters

---

## 📝 Key Concepts

### Path Parameters

- **Path parameters** are dynamic parts of the URL
- Captured from the URL path
- Used to identify specific resources
- Example: `/users/{user_id}` where `user_id` is a path parameter

### Type Validation

- FastAPI automatically validates types
- Uses Python type hints
- Returns validation errors for invalid input
- No manual validation code needed

### Multiple Path Parameters

- Can have multiple parameters in one path
- Order doesn't matter (matched by name)
- Each parameter is validated independently

### Enum Parameters

- Use enums for fixed set of values
- Better validation than strings
- Self-documenting in API docs
- Prevents invalid values

### Advanced Validation

- Use `Path()` function for complex validation
- Set constraints (min, max, regex)
- Add descriptions for documentation
- Automatic validation and error messages

---

## 💻 Code Examples

### Basic Path Parameter

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {"user_id": user_id, "message": f"Hello user {user_id}"}
```

**Testing:**
- Valid: `http://127.0.0.1:8000/users/123` → Returns user_id: 123
- Invalid: `http://127.0.0.1:8000/users/abc` → Validation error

### Type Validation

```python
@app.get("/users/{user_id}")
def get_user(user_id: int):  # Must be integer
    return {"user_id": user_id}

# FastAPI automatically:
# - Converts valid string to integer
# - Returns validation error for invalid input
```

### Multiple Path Parameters

```python
@app.get("/users/{user_id}/posts/{post_id}")
def get_user_post(user_id: int, post_id: int):
    return {
        "user_id": user_id,
        "post_id": post_id,
        "message": f"Post {post_id} by user {user_id}"
    }
```

**Testing:**
- `http://127.0.0.1:8000/users/32/posts/90`
- Returns: `{"user_id": 32, "post_id": 90, "message": "Post 90 by user 32"}`

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

**Testing:**
- Valid: `http://127.0.0.1:8000/users/role/admin` → Works
- Invalid: `http://127.0.0.1:8000/users/role/invalid` → Validation error

### Advanced Validation with Path()

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

### Complete E-Commerce API Example

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
    if not filtered:
        raise HTTPException(
            status_code=404, 
            detail="Product not in specified category"
        )
    return filtered
```

---

## 🎯 Practice Exercises

### Exercise 1: Basic Path Parameters
- [ ] Create endpoint with single path parameter
- [ ] Add type validation
- [ ] Test with valid and invalid inputs
- [ ] Check validation errors

### Exercise 2: Multiple Parameters
- [ ] Create endpoint with multiple path parameters
- [ ] Test different parameter combinations
- [ ] Verify parameter order doesn't matter
- [ ] Add type validation to all parameters

### Exercise 3: Enum Parameters
- [ ] Create enum class
- [ ] Use enum in path parameter
- [ ] Test with valid enum values
- [ ] Test with invalid values

### Exercise 4: Advanced Validation
- [ ] Use Path() for validation
- [ ] Add constraints (min, max)
- [ ] Add regex patterns
- [ ] Add descriptions

### Exercise 5: Complete API
- [ ] Build e-commerce API
- [ ] Implement all learned concepts
- [ ] Add error handling
- [ ] Test all endpoints

---

## 📌 Important Notes

### Best Practices for Path Parameters

1. **Always Use Type Hints**
   - Provides automatic validation
   - Generates better documentation
   - Makes code more readable

2. **Use Meaningful Names**
   - Use descriptive parameter names
   - Follow REST conventions
   - Example: `user_id` not `id`

3. **Use Enums for Fixed Values**
   - Better validation than strings
   - Self-documenting in API docs
   - Prevents typos and errors

4. **Add Path() for Complex Validation**
   - Set ranges (min, max)
   - Add length constraints
   - Use regex patterns
   - Add descriptions

5. **Handle Edge Cases**
   - Always validate business logic
   - Return appropriate HTTP status codes
   - Provide clear error messages

### Common Patterns

```python
# Pattern 1: Simple ID parameter
@app.get("/items/{item_id}")
def get_item(item_id: int):
    return {"item_id": item_id}

# Pattern 2: Multiple parameters
@app.get("/users/{user_id}/posts/{post_id}")
def get_post(user_id: int, post_id: int):
    return {"user_id": user_id, "post_id": post_id}

# Pattern 3: Enum parameter
@app.get("/users/role/{role}")
def get_by_role(role: UserRole):
    return {"role": role}

# Pattern 4: Advanced validation
@app.get("/products/{product_id}")
def get_product(
    product_id: int = Path(..., gt=0, description="Product ID")
):
    return {"product_id": product_id}
```

---

## 🔗 Related Topics

- Query parameters
- Request body
- Response models
- Error handling
- HTTP status codes

---

## ❓ Common Questions

**Q: What's the difference between path and query parameters?**  
A: Path parameters are in the URL path (`/users/{id}`), query parameters are after `?` (`/users?name=John`).

**Q: Do I need to validate manually?**  
A: No, FastAPI validates automatically based on type hints. Use Path() for additional constraints.

**Q: Can I use regex in path parameters?**  
A: Yes, use the `regex` parameter in Path() function.

**Q: What happens if validation fails?**  
A: FastAPI returns a 422 status code with detailed validation error message.

---

## 📚 Additional Resources

- [FastAPI Path Parameters](https://fastapi.tiangolo.com/tutorial/path-params/)
- [FastAPI Path Validation](https://fastapi.tiangolo.com/tutorial/path-params-numeric-validations/)
- [Python Enums](https://docs.python.org/3/library/enum.html)

---

**Previous Lesson:** [Lesson 3: FastAPI Creating Hello World First App](./lesson_03_hello_world_app.md)  
**Course Complete!** 🎉

---

## 📝 Video Notes (from transcript)

### Key Points from Video:

1. **Understanding Parameters:**
   - Parameters are placeholders in URL that capture dynamic values
   - Example: `/products/23/mobile` - 23 and mobile are parameters
   - FastAPI makes it easy to build flexible REST APIs

2. **Basic Path Parameter:**
   ```python
   @app.get("/users/{user_id}")
   def get_user(user_id: int):
       return {"user_id": user_id, "message": f"Hello user {user_id}"}
   ```

3. **Type Validation:**
   - FastAPI automatically validates types
   - Converts valid strings to integers
   - Returns detailed validation error for invalid input
   - No manual validation code needed

4. **Multiple Path Parameters:**
   ```python
   @app.get("/users/{user_id}/posts/{post_id}")
   def get_user_post(user_id: int, post_id: int):
       return {"user_id": user_id, "post_id": post_id}
   ```
   - Order of parameters doesn't matter
   - Matched by name, not position

5. **Enum Parameters:**
   ```python
   class UserRole(str, Enum):
       admin = "admin"
       user = "user"
       client = "client"
   
   @app.get("/users/role/{role}")
   def get_users_by_role(role: UserRole):
       return {"role": role}
   ```
   - Perfect validation with zero effort
   - Only allowed values are accepted

6. **Advanced Validation:**
   ```python
   from fastapi import Path
   
   product_id: int = Path(..., gt=0, description="Product ID")
   ```
   - Can set ranges (gt, ge, lt, le)
   - Can add regex patterns
   - All documented automatically

7. **E-Commerce API Example:**
   - Complete working example
   - Multiple endpoints
   - Error handling
   - Category filtering
   - Product lookup

### Best Practices from Video:
- Use type hints always
- Use meaningful names
- Use enums for fixed values
- Add Path() for complex validation
- Add descriptions for better documentation
- Handle edge cases
- Return appropriate HTTP status codes

