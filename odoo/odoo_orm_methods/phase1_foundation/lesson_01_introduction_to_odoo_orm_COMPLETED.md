# Lesson 1: Introduction to Odoo ORM ✅

**Video:** https://www.youtube.com/watch?v=8V-uOG8KkKA  
**Status:** ✅ Completed  
**Date Completed:** 2025-01-27  
**Completion Check:** ✅ True

---

## ✅ Completion Status

- [x] **Lesson Completed:** ✅ True
- [x] **Video Watched:** ✅ True
- [x] **Notes Reviewed:** ✅ True
- [x] **Practice Exercises Completed:** ✅ True
- [x] **Key Concepts Understood:** ✅ True

---

## 📚 Learning Objectives

- Understand what ORM (Object-Relational Mapping) is in Odoo
- Learn about the `self.env` object
- Understand Recordset basics
- Learn about Model inheritance and structure

---

## 📝 Key Concepts

### What is ORM in Odoo?

- **ORM (Object-Relational Mapping)** is a programming technique that converts data between incompatible type systems
- In Odoo, ORM allows you to interact with database records using Python objects instead of SQL queries
- Odoo's ORM provides a high-level API for database operations

### Understanding `self.env`

- `self.env` is the environment object that provides access to all models
- It's the entry point for accessing any model in Odoo
- Syntax: `self.env['model.name']`

**Example:**
```python
# Access a model through self.env
partners = self.env['res.partner']
```

### Recordset Basics

- A **recordset** is a collection of records from a model
- Recordsets are lazy - they don't fetch data until needed
- Recordsets can contain zero, one, or many records
- Operations on recordsets return new recordsets (immutable)

**Example:**
```python
# Get all partners
partners = self.env['res.partner'].search([])
# This returns a recordset
```

### Model Structure

- Models in Odoo inherit from `models.Model`
- Models define database tables
- Fields define table columns
- Methods define business logic

---

## 💻 Code Examples

### Basic Model Access

```python
# Access a model
model = self.env['res.partner']

# Search for records
records = model.search([])

# Access a specific record
record = self.env['res.partner'].browse(1)
```

### Understanding Recordsets

```python
# Empty recordset
empty = self.env['res.partner'].browse([])

# Single record recordset
single = self.env['res.partner'].browse(1)

# Multiple records recordset
multiple = self.env['res.partner'].search([('active', '=', True)])
```

---

## 🎯 Practice Exercises

### Exercise 1: Access Models
- [x] Access the `res.partner` model using `self.env`
- [x] Access the `sale.order` model
- [x] Print the model class name

### Exercise 2: Create Simple Recordsets
- [x] Create an empty recordset
- [x] Search for all active partners
- [x] Count the number of records in a recordset

### Exercise 3: Understand Model Structure
- [x] Inspect a model's fields
- [x] Check model's table name
- [x] List model's methods

**All Exercises Completed:** ✅ True

---

## 📌 Important Notes

- `self.env` is available in all model methods
- Recordsets are lazy - they don't execute queries until needed
- Always use `self.env` to access models, never import them directly
- Recordsets are immutable - operations return new recordsets

---

## 🔗 Related Topics

- Model Definition
- Field Types
- Inheritance
- Environment Context

---

## ❓ Questions & Answers

**Q: What is the difference between `self.env` and direct model import?**  
A: `self.env` provides proper context, security, and database access. Direct imports bypass Odoo's security and context system.

**Q: Can I modify a recordset directly?**  
A: No, recordsets are immutable. Operations return new recordsets.

---

## 📚 Additional Resources

- Odoo ORM Documentation
- Odoo Model Reference
- Recordset API Documentation

---

**Next Lesson:** [Lesson 2: Search Methods](./lesson_02_search_methods.md)

