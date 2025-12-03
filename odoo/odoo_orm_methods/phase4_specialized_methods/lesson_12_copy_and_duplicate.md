# Lesson 12: Copy and Duplicate

**Video:** https://www.youtube.com/watch?v=9rHKtoKz_yw  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Master the `copy()` method
- Learn the `copy_data()` method
- Understand duplicating records
- Handle related records in copy operations
- Customize copy behavior

---

## 📝 Key Concepts

### The `copy()` Method

The `copy()` method creates a duplicate of a record.

**Basic Syntax:**
```python
new_record = record.copy(default=None)
```

**Parameters:**
- `default`: Dictionary of field values to override in the copy

**Returns:**
- New record (duplicate)

### The `copy_data()` Method

The `copy_data()` method returns a dictionary with field values ready for create().

**Basic Syntax:**
```python
data = record.copy_data(default=None)
```

**Returns:**
- Dictionary of field values

---

## 💻 Code Examples

### Basic Copy Operations

```python
# Copy a single record
original = self.env['res.partner'].browse(1)
copy = original.copy()
# Creates a duplicate with same field values

# Copy with default values
copy = original.copy({
    'name': 'Copy of ' + original.name,
    'email': 'copy@example.com'
})

# Copy multiple records
partners = self.env['res.partner'].search([('active', '=', True)])
copies = partners.copy()
# Creates duplicates of all active partners
```

### Using copy_data()

```python
# Get copy data
original = self.env['res.partner'].browse(1)
data = original.copy_data()
# Returns dictionary of field values

# Modify and create
data['name'] = 'Modified Copy'
new_partner = self.env['res.partner'].create(data)
```

### Handling Related Records

```python
# Copy sale order (handles order lines)
order = self.env['sale.order'].browse(1)
new_order = order.copy({
    'name': 'Copy of ' + order.name
})
# Order lines are copied automatically

# Copy with modified related records
new_order = order.copy({
    'order_line': [(0, 0, {
        'product_id': 2,
        'product_uom_qty': 5
    })]
})
```

### Custom Copy Logic

```python
# Override copy method in model
@api.returns('self', lambda value: value.id)
def copy(self, default=None):
    default = default or {}
    default['name'] = self.name + ' (Copy)'
    return super().copy(default)
```

---

## 🎯 Practice Exercises

### Exercise 1: Basic Copy
- [ ] Copy a single record
- [ ] Copy with modified values
- [ ] Copy multiple records
- [ ] Verify copied records

### Exercise 2: Using copy_data()
- [ ] Get copy data from a record
- [ ] Modify copy data
- [ ] Create new record from copy data
- [ ] Compare copy() vs copy_data()

### Exercise 3: Related Records
- [ ] Copy records with one2many relations
- [ ] Copy records with many2many relations
- [ ] Handle related records in copy
- [ ] Customize copy behavior

---

## 📌 Important Notes

### Copy Behavior

- **Related records** are copied automatically (one2many, many2many)
- **Many2one fields** reference the same record (not copied)
- **Computed fields** are recalculated
- **Default values** can override copied values

### Best Practices

1. **Use defaults** - Modify values during copy
2. **Handle related records** - Understand what gets copied
3. **Customize when needed** - Override copy() method
4. **Test thoroughly** - Verify all fields are copied correctly

---

## 🔗 Related Topics

- `create()` method
- `write()` method
- Related fields
- Model inheritance

---

## ❓ Common Questions

**Q: What gets copied in a copy operation?**  
A: All field values and related records (one2many, many2many). Many2one fields reference the same records.

**Q: Can I modify values during copy?**  
A: Yes, use the `default` parameter to override field values.

**Q: How do I copy related records?**  
A: Related records are copied automatically. Use field commands to modify them.

---

## 📚 Additional Resources

- Odoo copy() Method Documentation
- copy_data() Method Reference
- Related Fields Guide

---

**Previous Lesson:** [Lesson 11: Advanced Search Patterns](../phase3_advanced_operations/lesson_11_advanced_search_patterns.md)  
**Next Lesson:** [Lesson 13: Name Get and Name Search](./lesson_13_name_get_and_name_search.md)

