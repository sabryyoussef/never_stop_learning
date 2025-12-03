# Lesson 13: Name Get and Name Search

**Video:** https://www.youtube.com/watch?v=S5FWeUTtmmE  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Master the `name_get()` method
- Learn the `name_search()` method
- Customize display names
- Implement name_search for autocomplete
- Handle multi-language names

---

## 📝 Key Concepts

### The `name_get()` Method

The `name_get()` method returns the display name for records.

**Basic Syntax:**
```python
names = records.name_get()
```

**Returns:**
- List of tuples: `[(id, name), ...]`

### The `name_search()` Method

The `name_search()` method searches records by name (for autocomplete).

**Basic Syntax:**
```python
results = self.env['model'].name_search(name='', args=None, operator='ilike', limit=100)
```

**Parameters:**
- `name`: Search term
- `args`: Additional domain
- `operator`: Search operator
- `limit`: Maximum results

**Returns:**
- List of tuples: `[(id, name), ...]`

### The `name_create()` Method

The `name_create()` method creates a record from just a name.

**Basic Syntax:**
```python
result = self.env['model'].name_create(name)
```

**Returns:**
- Tuple: `(id, name_get_result)`

---

## 💻 Code Examples

### Using name_get()

```python
# Get display names
partners = self.env['res.partner'].search([])
names = partners.name_get()
# Returns: [(1, 'Partner 1'), (2, 'Partner 2'), ...]

# Custom name_get() in model
@api.depends('reference', 'name')
def name_get(self):
    result = []
    for record in self:
        name = f"[{record.reference}] {record.name}"
        result.append((record.id, name))
    return result
```

### Using name_search()

```python
# Search by name
results = self.env['res.partner'].name_search('test')
# Returns: [(id, 'Test Partner'), ...]

# With additional domain
results = self.env['res.partner'].name_search(
    'test',
    args=[('customer', '=', True)],
    limit=10
)

# Custom name_search() in model
@api.model
def name_search(self, name='', args=None, operator='ilike', limit=100):
    args = args or []
    domain = [
        '|',
        ('name', operator, name),
        ('reference', operator, name)
    ]
    return self.search(domain + args, limit=limit).name_get()
```

### Using name_create()

```python
# Create from name
result = self.env['res.partner'].name_create('New Partner')
# Returns: (id, 'New Partner')

# Custom name_create() in model
@api.model
def name_create(self, name):
    return self.create({
        'name': name,
        'operation_name': name  # Custom field
    }).name_get()[0]
```

### Practical Examples

```python
# Display name with reference
@api.depends('reference', 'name')
def name_get(self):
    result = []
    for record in self:
        if record.reference:
            name = f"[{record.reference}] {record.name}"
        else:
            name = record.name
        result.append((record.id, name))
    return result

# Search by multiple fields
@api.model
def name_search(self, name='', args=None, operator='ilike', limit=100):
    args = args or []
    domain = [
        '|', '|',
        ('name', operator, name),
        ('reference', operator, name),
        ('email', operator, name)
    ]
    return self.search(domain + args, limit=limit).name_get()
```

---

## 🎯 Practice Exercises

### Exercise 1: Using name_get()
- [ ] Get display names for records
- [ ] Customize name_get() to show multiple fields
- [ ] Handle cases with missing fields
- [ ] Format display names

### Exercise 2: Using name_search()
- [ ] Implement name_search() for autocomplete
- [ ] Search by multiple fields
- [ ] Add additional domain filters
- [ ] Limit search results

### Exercise 3: Using name_create()
- [ ] Create records from name only
- [ ] Customize name_create() behavior
- [ ] Handle fields without 'name' field
- [ ] Set default values in name_create()

---

## 📌 Important Notes

### name_get() Best Practices

1. **Use @api.depends** - Specify field dependencies
2. **Handle missing values** - Check if fields exist
3. **Format consistently** - Use consistent name format
4. **Performance** - Keep it simple for performance

### name_search() Best Practices

1. **Search multiple fields** - Use OR conditions
2. **Add domain filters** - Use args parameter
3. **Limit results** - Use limit parameter
4. **Use appropriate operator** - 'ilike' for case-insensitive

### name_create() Best Practices

1. **Handle missing 'name' field** - Use rec_name or custom field
2. **Set defaults** - Use context for defaults
3. **Return correct format** - Return (id, name_get_result)

---

## 🔗 Related Topics

- `rec_name` attribute
- `_rec_name` property
- Many2one fields
- Autocomplete fields

---

## ❓ Common Questions

**Q: When do I need to override name_get()?**  
A: When you want to show multiple fields in the display name, or customize the format.

**Q: How do I search by multiple fields?**  
A: Override name_search() and use OR conditions in the domain.

**Q: What if my model doesn't have a 'name' field?**  
A: Set `_rec_name` to another field, or override name_create() to handle it.

---

## 📚 Additional Resources

- Odoo name_get() Documentation
- name_search() Method Reference
- rec_name Attribute Guide

---

**Previous Lesson:** [Lesson 12: Copy and Duplicate](./lesson_12_copy_and_duplicate.md)  
**Next Lesson:** [Lesson 14: Ensure One and Other Utilities](./lesson_14_ensure_one_and_utilities.md)

