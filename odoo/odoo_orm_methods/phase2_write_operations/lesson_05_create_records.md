# Lesson 5: Create Records

**Video:** https://www.youtube.com/watch?v=qgcGpdGCxeA  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Master the `create()` method
- Learn to create single records
- Understand bulk creation (multiple records)
- Handle default values
- Create records with related fields

---

## 📝 Key Concepts

### The `create()` Method

The `create()` method creates new records in the database and returns the created record(s) as a recordset.

**Basic Syntax:**
```python
record = self.env['model.name'].create(vals)
records = self.env['model.name'].create([vals1, vals2, ...])
```

**Parameters:**
- `vals`: Dictionary of field values (single record)
- `[vals1, vals2, ...]`: List of dictionaries (multiple records)

**Returns:**
- Created record(s) as recordset

### Creating Single Records

```python
# Create a single record
partner = self.env['res.partner'].create({
    'name': 'New Partner',
    'email': 'partner@example.com',
    'phone': '1234567890'
})
# Returns: res.partner(1,)
```

### Creating Multiple Records (Bulk Create)

```python
# Create multiple records in one operation
partners = self.env['res.partner'].create([
    {'name': 'Partner 1', 'email': 'p1@example.com'},
    {'name': 'Partner 2', 'email': 'p2@example.com'},
    {'name': 'Partner 3', 'email': 'p3@example.com'}
])
# Returns: res.partner(1, 2, 3)
```

### Using Variables for Values

```python
# Define values as variable
vals = {
    'name': 'Odoo Methods',
    'email': 'odoomates@gmail.com',
    'phone': '1234567890'
}

# Create record
partner = self.env['res.partner'].create(vals)
```

### Default Values

```python
# Use context for default values
partner = self.env['res.partner'].with_context(
    default_customer=True,
    default_country_id=1
).create({
    'name': 'New Customer'
})
```

### Creating Records with Related Fields

#### Many2one Fields
```python
# Create record with many2one reference
order = self.env['sale.order'].create({
    'partner_id': 1,  # Reference to existing partner
    'date_order': fields.Datetime.now(),
})
```

#### One2many Fields
```python
# Create record with one2many lines
order = self.env['sale.order'].create({
    'partner_id': 1,
    'order_line': [(0, 0, {
        'product_id': 1,
        'product_uom_qty': 10,
        'price_unit': 100
    })]
})
```

#### Many2many Fields
```python
# Create record with many2many relations
product = self.env['product.product'].create({
    'name': 'New Product',
    'categ_id': 1,
    'tag_ids': [(6, 0, [1, 2, 3])]  # Link to existing tags
})
```

---

## 💻 Code Examples

### Basic Create Operations

```python
# Create a single partner
partner = self.env['res.partner'].create({
    'name': 'ABC Company',
    'email': 'abc@example.com',
    'phone': '1234567890'
})
print(partner.id)  # Print the created record ID

# Create with multiple fields
partner = self.env['res.partner'].create({
    'name': 'Odoo Methods',
    'email': 'odoomates@gmail.com',
    'phone': '1234567890',
    'customer': True,
    'supplier': False,
    'website': 'https://www.odoomates.tech'
})
```

### Bulk Create

```python
# Create multiple partners at once
partners = self.env['res.partner'].create([
    {
        'name': 'Partner 1',
        'email': 'partner1@example.com',
        'customer': True
    },
    {
        'name': 'Partner 2',
        'email': 'partner2@example.com',
        'supplier': True
    },
    {
        'name': 'Partner 3',
        'email': 'partner3@example.com',
        'customer': True,
        'supplier': True
    }
])
# All three records created in one database operation
```

### Create with Defaults

```python
# Set default values using context
partner = self.env['res.partner'].with_context(
    default_customer=True,
    default_country_id=self.env.ref('base.us').id
).create({
    'name': 'US Customer'
})
# customer will be True, country_id will be US
```

### Create with Related Records

```python
# Create sale order with order lines
order = self.env['sale.order'].create({
    'partner_id': 1,
    'date_order': fields.Datetime.now(),
    'order_line': [
        (0, 0, {
            'product_id': 1,
            'product_uom_qty': 5,
            'price_unit': 50.0
        }),
        (0, 0, {
            'product_id': 2,
            'product_uom_qty': 10,
            'price_unit': 100.0
        })
    ]
})
```

### Field Commands for Related Fields

```python
# One2many: (0, 0, {values}) - Create new record
'order_line': [(0, 0, {'product_id': 1, 'qty': 10})]

# One2many: (1, id, {values}) - Update existing record
'order_line': [(1, 10, {'qty': 20})]

# One2many: (2, id) - Delete and unlink record
'order_line': [(2, 10)]

# One2many: (3, id) - Unlink record (keep in database)
'order_line': [(3, 10)]

# One2many: (4, id) - Link existing record
'order_line': [(4, 10)]

# One2many: (5, 0, 0) - Unlink all records
'order_line': [(5, 0, 0)]

# Many2many: (6, 0, [ids]) - Replace all links
'tag_ids': [(6, 0, [1, 2, 3])]

# Many2many: (4, id) - Add link
'tag_ids': [(4, 1)]

# Many2many: (3, id) - Remove link
'tag_ids': [(3, 1)]

# Many2many: (5, 0, 0) - Remove all links
'tag_ids': [(5, 0, 0)]
```

---

## 🎯 Practice Exercises

### Exercise 1: Basic Create
- [ ] Create a new partner with name, email, and phone
- [ ] Create a partner using a variable for values
- [ ] Print the ID of the created record

### Exercise 2: Bulk Create
- [ ] Create 5 partners in one operation
- [ ] Create partners with different customer/supplier flags
- [ ] Verify all records were created

### Exercise 3: Create with Defaults
- [ ] Create a partner with default country
- [ ] Create a partner with default customer flag
- [ ] Use context to set multiple defaults

### Exercise 4: Create with Related Fields
- [ ] Create a sale order with a partner
- [ ] Create a sale order with order lines
- [ ] Create a product with categories and tags

---

## 📌 Important Notes

### Field Validation

- **Required fields** must be provided
- **Field types** must match (string, integer, date, etc.)
- **Validation errors** are raised if data is invalid
- **Default values** are applied automatically if not specified

### Performance Considerations

1. **Bulk create is faster** - Create multiple records in one call
2. **Use field commands correctly** - Proper syntax for related fields
3. **Validate data first** - Check data before creating to avoid errors
4. **Handle exceptions** - Wrap create() in try-except for error handling

### Common Patterns

#### Get or Create
```python
partner = self.env['res.partner'].search([('email', '=', 'test@example.com')], limit=1)
if not partner:
    partner = self.env['res.partner'].create({
        'name': 'Test Partner',
        'email': 'test@example.com'
    })
```

#### Create with Validation
```python
try:
    partner = self.env['res.partner'].create({
        'name': 'New Partner',
        'email': 'invalid-email'  # This might raise validation error
    })
except Exception as e:
    # Handle error
    print(f"Error creating partner: {e}")
```

### Field Technical Names

- Always use **technical field names**, not display names
- Check field technical name in debug mode (hover over field in UI)
- Common fields: `name`, `email`, `phone`, `customer`, `supplier`, etc.

---

## 🔗 Related Topics

- `write()` method (updating records)
- `unlink()` method (deleting records)
- Field types and relationships
- Model constraints and validations

---

## ❓ Common Questions

**Q: What happens if I create a record with invalid data?**  
A: Odoo will raise a validation error. Always validate data or handle exceptions.

**Q: Can I create records with computed fields?**  
A: Computed fields are calculated automatically. You typically don't set them directly in `create()`.

**Q: How do I create records with one2many or many2many fields?**  
A: Use special commands like `(0, 0, {...})` for one2many and `[(6, 0, [ids])]` for many2many.

**Q: Is bulk create more efficient?**  
A: Yes, creating multiple records in one call is much more efficient than creating them one by one.

**Q: Can I set default values in create()?**  
A: Yes, use `with_context(default_field='value')` or set defaults in the model definition.

---

## 📚 Additional Resources

- Odoo create() Method Documentation
- Field Commands Reference
- Model Constraints
- Validation Best Practices

---

**Previous Lesson:** [Lesson 4: Search and Read Combined](../phase1_foundation/lesson_04_search_and_read_combined.md)  
**Next Lesson:** [Lesson 6: Update Records](./lesson_06_update_records.md)

