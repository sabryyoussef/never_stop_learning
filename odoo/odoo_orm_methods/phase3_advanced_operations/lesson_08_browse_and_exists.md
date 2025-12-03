# Lesson 8: Browse and Exists

**Video:** https://www.youtube.com/watch?v=tIaIixa3oAs  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Master the `browse()` method
- Understand when to use browse vs search
- Learn the `exists()` method
- Check record existence before operations
- Handle deleted records safely

---

## 📝 Key Concepts

### The `browse()` Method

The `browse()` method gets records directly by ID(s) without searching the database.

**Basic Syntax:**
```python
record = self.env['model.name'].browse(id)
records = self.env['model.name'].browse([id1, id2, ...])
```

**Parameters:**
- `id`: Single ID (integer)
- `[id1, id2, ...]`: List of IDs

**Returns:**
- Recordset with specified ID(s)

### When to Use browse()

- **Use `browse()`** when you already know the ID(s)
- **Use `browse()`** for direct record access (more efficient than search)
- **Don't use `browse()`** if you need to filter by conditions (use `search()`)

### The `exists()` Method

The `exists()` method checks if records still exist in the database.

**Basic Syntax:**
```python
if record.exists():
    # Record exists
    pass
```

**Returns:**
- Recordset containing only existing records

---

## 💻 Code Examples

### Basic Browse Operations

```python
# Browse single record by ID
patient = self.env['hospital.patient'].browse(51)
# Returns: hospital.patient(51,)

# Access field values
name = patient.name  # Get name field
email = patient.email  # Get email field

# Browse multiple records
patients = self.env['hospital.patient'].browse([51, 72])
# Returns: hospital.patient(51, 72)

# Access fields on multiple records
# patients.name  # Error: Expected singleton

# Solution: Use mapped() or loop
patient_names = patients.mapped('name')
# Returns: ['Papaya', 'Odoo Mates Test']
```

### Using exists() with browse()

```python
# Check if record exists
patient = self.env['hospital.patient'].browse(200)
if patient.exists():
    print(patient.name)
else:
    print("Record does not exist")

# For multiple records
patients = self.env['hospital.patient'].browse([51, 200])
existing = patients.exists()
# Returns only existing records (51,)
```

### Browse Non-Existing Records

```python
# Browse a non-existing ID
patient = self.env['hospital.patient'].browse(200)
# Returns: hospital.patient(200,) - recordset is created

# But accessing fields shows error
try:
    name = patient.name  # Error: Record does not exist
except Exception as e:
    print(f"Error: {e}")

# Safe access with exists()
if patient.exists():
    name = patient.name
else:
    print("Record not found")
```

### Safe Operations with browse() and exists()

```python
# Safe update
patient = self.env['hospital.patient'].browse(1)
if patient.exists():
    patient.write({'name': 'Updated Name'})

# Safe delete
patient = self.env['hospital.patient'].browse(1)
if patient.exists():
    patient.unlink()

# Safe read
patient = self.env['hospital.patient'].browse(1)
if patient.exists():
    data = patient.read(['name', 'email'])
```

### Comparing browse() vs search()

```python
# Method 1: Using browse() (More Efficient)
patient = self.env['hospital.patient'].browse(51)
# Direct access by ID - faster

# Method 2: Using search() (Less Efficient)
patient = self.env['hospital.patient'].search([('id', '=', 51)], limit=1)
# Database query - slower

# Use browse() when you know the ID
# Use search() when you need to filter
```

---

## 🎯 Practice Exercises

### Exercise 1: Basic Browse
- [ ] Browse a record by ID
- [ ] Browse multiple records by IDs
- [ ] Access field values from browsed records

### Exercise 2: Using exists()
- [ ] Check if a record exists before accessing
- [ ] Filter existing records from a recordset
- [ ] Handle non-existing records gracefully

### Exercise 3: Safe Operations
- [ ] Safely update a browsed record
- [ ] Safely delete a browsed record
- [ ] Safely read from a browsed record

### Exercise 4: Performance Comparison
- [ ] Compare browse() vs search() performance
- [ ] Use browse() for known IDs
- [ ] Use search() for filtering

---

## 📌 Important Notes

### When to Use Each Method

**Use `browse()` when:**
- You already know the ID(s)
- You need direct record access
- Performance is important
- You're working with specific records

**Use `search()` when:**
- You need to filter by conditions
- You don't know the ID(s)
- You need to find records by criteria

### Performance Considerations

1. **`browse()` is faster** - Direct access by ID
2. **`search()` queries database** - More overhead
3. **Use `exists()`** - Always check before operations
4. **Handle errors** - Non-existing records raise errors

### Common Patterns

#### Safe Browse Pattern
```python
def safe_browse(self, record_id):
    record = self.env['model'].browse(record_id)
    if record.exists():
        return record
    return self.env['model']  # Return empty recordset
```

#### Browse with Validation
```python
def get_record_safely(self, record_id):
    record = self.env['model'].browse(record_id)
    if not record.exists():
        raise UserError(f"Record {record_id} does not exist")
    return record
```

---

## 🔗 Related Topics

- `search()` method
- `search_read()` method
- Recordset operations
- Error handling

---

## ❓ Common Questions

**Q: What's the difference between `browse()` and `search()`?**  
A: `browse()` gets records by ID directly (faster), while `search()` queries the database with conditions.

**Q: Can I browse a non-existing record?**  
A: Yes, `browse()` creates a recordset, but accessing fields will raise an error. Use `exists()` to check.

**Q: Is `browse()` faster than `search()`?**  
A: Yes, when you know the ID, `browse()` is more efficient as it doesn't query the database.

**Q: How do I check if a browsed record exists?**  
A: Use `exists()` method: `if record.exists(): ...`

---

## 📚 Additional Resources

- Odoo browse() Method Documentation
- exists() Method Reference
- Performance Optimization Guide

---

**Previous Lesson:** [Lesson 7: Delete Operations](../phase2_write_operations/lesson_07_delete_operations.md)  
**Next Lesson:** [Lesson 9: Recordset Operations](./lesson_09_recordset_operations.md)

