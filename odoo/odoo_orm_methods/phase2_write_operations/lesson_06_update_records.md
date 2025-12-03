# Lesson 6: Update Records

**Video:** https://www.youtube.com/watch?v=Cm-DBN_Q-pk  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Master the `write()` method
- Learn to update single records
- Understand bulk updates
- Update related fields
- Handle computed field updates

---

## 📝 Key Concepts

### The `write()` Method

The `write()` method updates existing records in the database.

**Basic Syntax:**
```python
record.write(vals)
records.write(vals)
```

**Parameters:**
- `vals`: Dictionary of field values to update

**Returns:**
- `True` if successful

### Updating Single Records

```python
# Update a single record
partner = self.env['res.partner'].browse(1)
partner.write({
    'name': 'Updated Name',
    'email': 'newemail@example.com'
})
# Returns: True
```

### Bulk Updates

```python
# Update multiple records at once
partners = self.env['res.partner'].search([('active', '=', True)])
partners.write({
    'customer': True,
    'country_id': 1
})
# Updates all active partners
```

### Updating Related Fields

#### Many2one Fields
```python
# Update many2one field
partner.write({
    'country_id': 2  # Change country
})
```

#### One2many Fields
```python
# Update one2many lines
order.write({
    'order_line': [
        (0, 0, {'product_id': 1, 'qty': 10}),  # Add new line
        (1, 10, {'qty': 20}),                  # Update existing line
        (2, 11),                                # Delete line
    ]
})
```

#### Many2many Fields
```python
# Update many2many relations
product.write({
    'tag_ids': [(6, 0, [1, 2, 3])]  # Replace all tags
})
```

---

## 💻 Code Examples

### Basic Write Operations

```python
# Get a record and update it
partner = self.env['res.partner'].browse(1)
partner.write({
    'name': 'Updated Name',
    'email': 'updated@example.com'
})

# Update using search
partner = self.env['res.partner'].search([('email', '=', 'old@example.com')], limit=1)
if partner:
    partner.write({
        'email': 'new@example.com'
    })
```

### Bulk Updates

```python
# Update all active partners
partners = self.env['res.partner'].search([('active', '=', True)])
partners.write({
    'customer': True
})
# All active partners now have customer=True

# Update with condition
partners = self.env['res.partner'].search([
    ('customer', '=', False),
    ('email', '!=', False)
])
partners.write({
    'customer': True
})
```

### Updating Multiple Fields

```python
# Update multiple fields at once
partner.write({
    'name': 'New Name',
    'email': 'newemail@example.com',
    'phone': '1234567890',
    'website': 'https://www.example.com',
    'customer': True,
    'supplier': False
})
```

### Updating Related Fields

```python
# Update many2one
order = self.env['sale.order'].browse(1)
order.write({
    'partner_id': 2  # Change customer
})

# Update one2many (order lines)
order.write({
    'order_line': [
        (0, 0, {
            'product_id': 1,
            'product_uom_qty': 5,
            'price_unit': 50.0
        }),
        (1, 10, {  # Update line with ID 10
            'product_uom_qty': 10
        }),
        (2, 11)  # Delete line with ID 11
    ]
})

# Update many2many
product = self.env['product.product'].browse(1)
product.write({
    'tag_ids': [(6, 0, [1, 2, 3])]  # Replace all tags
})
```

### Field Commands for write()

```python
# One2many commands
'order_line': [
    (0, 0, {...}),  # Create new
    (1, id, {...}), # Update existing
    (2, id),        # Delete
    (3, id),        # Unlink (keep in DB)
    (4, id),        # Link existing
    (5, 0, 0)       # Unlink all
]

# Many2many commands
'tag_ids': [
    (6, 0, [ids]),  # Replace all
    (4, id),        # Add link
    (3, id),        # Remove link
    (5, 0, 0)       # Remove all
]
```

### Conditional Updates

```python
# Update only if condition is met
partner = self.env['res.partner'].browse(1)
if partner.email:
    partner.write({
        'email': partner.email.lower()  # Normalize email
    })

# Update with validation
partner = self.env['res.partner'].browse(1)
vals = {'name': 'New Name'}
if partner.check_access_rights('write', raise_exception=False):
    partner.write(vals)
```

---

## 🎯 Practice Exercises

### Exercise 1: Basic Update
- [ ] Update a partner's name and email
- [ ] Update a partner's phone number
- [ ] Update multiple fields in one write() call

### Exercise 2: Bulk Updates
- [ ] Update all active partners to be customers
- [ ] Update partners based on a condition
- [ ] Update multiple records with different values

### Exercise 3: Update Related Fields
- [ ] Update a sale order's partner
- [ ] Add a new order line to an existing order
- [ ] Update an existing order line
- [ ] Remove an order line

### Exercise 4: Advanced Updates
- [ ] Update records with validation
- [ ] Update computed fields (if applicable)
- [ ] Handle update errors gracefully

---

## 📌 Important Notes

### When to Use write()

- **Use `write()`** to update existing records
- **Use `create()`** to create new records
- **Bulk updates** are more efficient than individual updates
- **Field validation** happens automatically

### Performance Considerations

1. **Bulk updates** - Update multiple records in one call
2. **Minimize writes** - Don't write the same value twice
3. **Use search efficiently** - Only search for records you need to update
4. **Avoid loops** - Don't write in loops, use bulk operations

### Common Patterns

#### Update or Create
```python
partner = self.env['res.partner'].search([('email', '=', 'test@example.com')], limit=1)
if partner:
    partner.write({'name': 'Updated Name'})
else:
    self.env['res.partner'].create({
        'name': 'New Partner',
        'email': 'test@example.com'
    })
```

#### Safe Update
```python
# Check if record exists and has access
partner = self.env['res.partner'].browse(1)
if partner.exists() and partner.check_access_rights('write', raise_exception=False):
    partner.write({'name': 'Updated Name'})
```

#### Conditional Update
```python
# Only update if value is different
partner = self.env['res.partner'].browse(1)
if partner.name != 'New Name':
    partner.write({'name': 'New Name'})
```

### Computed Fields

- **Computed fields** are recalculated automatically when dependencies change
- **Don't write to computed fields** directly (unless `store=True` and `readonly=False`)
- **Dependencies** are tracked automatically

### Validation and Errors

- **Validation errors** are raised if data is invalid
- **Access rights** are checked automatically
- **Handle exceptions** when updating records

---

## 🔗 Related Topics

- `create()` method
- `unlink()` method
- Field types and relationships
- Model constraints
- Computed fields

---

## ❓ Common Questions

**Q: Can I update multiple records at once?**  
A: Yes, call `write()` on a recordset with multiple records to update them all.

**Q: What happens if I write to a computed field?**  
A: It depends on the field definition. Most computed fields are readonly and will raise an error.

**Q: How do I update one2many fields?**  
A: Use field commands like `(0, 0, {...})` to add, `(1, id, {...})` to update, `(2, id)` to delete.

**Q: Is write() faster than create()?**  
A: They serve different purposes. `write()` updates existing records, `create()` creates new ones.

**Q: Can I write to related fields?**  
A: Yes, you can write to many2one, one2many, and many2many fields using appropriate commands.

---

## 📚 Additional Resources

- Odoo write() Method Documentation
- Field Commands Reference
- Computed Fields Guide
- Performance Optimization

---

**Previous Lesson:** [Lesson 5: Create Records](./lesson_05_create_records.md)  
**Next Lesson:** [Lesson 7: Delete Operations](./lesson_07_delete_operations.md)

---

## 📝 Video Notes (from transcript)

### Key Points from Video:

1. **Basic write() usage:**
   ```python
   record.write({'field': 'value'})
   ```

2. **Example from video:**
   ```python
   # Browse a record
   patient = self.env['hospital.patient'].browse(3)
   
   # Update name
   patient.write({'name': 'Updated Name'})
   # Returns: True
   
   # Update email
   patient.write({'email': 'dummy@example.com'})
   ```

3. **Multiple fields:**
   ```python
   patient.write({
       'name': 'ORM',
       'email': 'odoomates@gmail.com'
   })
   ```

4. **Important points:**
   - `write()` returns `True` on success
   - Pass field values as dictionary
   - Can update multiple fields at once
   - Use technical field names

