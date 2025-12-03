# Lesson 4: Search and Read Combined

**Video:** https://www.youtube.com/watch?v=n37RL_j4K3A  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Understand the `search_read()` method
- Learn when to use `search_read()` vs `search()` + `read()`
- Master performance considerations
- Learn field selection in `search_read()`
- Understand the `create()` method (bonus from transcript)

---

## 📝 Key Concepts

### The `search_read()` Method

`search_read()` combines `search()` and `read()` in a single operation, making it more efficient than calling them separately.

**Basic Syntax:**
```python
records = self.env['model.name'].search_read(
    domain,
    fields=None,
    offset=0,
    limit=None,
    order=None
)
```

**Parameters:**
- `domain`: Search domain (same as `search()`)
- `fields`: List of fields to read (None = all fields)
- `offset`: Skip records (pagination)
- `limit`: Maximum records to return
- `order`: Sort order

**Returns:**
- List of dictionaries (same format as `read()`)

### Why Use `search_read()`?

**Performance Benefits:**
- **Single database query** instead of two separate queries
- **More efficient** when you need both search and read
- **Reduced overhead** from multiple method calls

**When to Use:**
- When you need to search AND read fields
- When building APIs or JSON responses
- When you need filtered data as dictionaries

### The `create()` Method

The `create()` method creates new records in the database.

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

---

## 💻 Code Examples

### Basic search_read()

```python
# Search and read in one operation
partners = self.env['res.partner'].search_read(
    [('active', '=', True)],
    fields=['name', 'email', 'phone']
)
# Returns: [{'id': 1, 'name': '...', 'email': '...', 'phone': '...'}, ...]

# With limit
partners = self.env['res.partner'].search_read(
    [('active', '=', True)],
    fields=['name', 'email'],
    limit=10
)

# With ordering
partners = self.env['res.partner'].search_read(
    [('active', '=', True)],
    fields=['name', 'email'],
    order='name'
)
```

### Comparison: search_read() vs search() + read()

```python
# Method 1: Using search_read() (RECOMMENDED - More Efficient)
partners = self.env['res.partner'].search_read(
    [('active', '=', True)],
    fields=['name', 'email']
)
# Single database query

# Method 2: Using search() + read() (Less Efficient)
partner_records = self.env['res.partner'].search([('active', '=', True)])
partners = partner_records.read(['name', 'email'])
# Two database queries - less efficient
```

### search_read() with Pagination

```python
def get_partners_page(page_number, page_size=10):
    offset = (page_number - 1) * page_size
    return self.env['res.partner'].search_read(
        [('active', '=', True)],
        fields=['name', 'email', 'phone'],
        offset=offset,
        limit=page_size
    )
```

### search_read() with Related Fields

```python
# Read related fields in search_read
orders = self.env['sale.order'].search_read(
    [('state', '=', 'sale')],
    fields=['name', 'partner_id', 'amount_total']
)
# partner_id will include related partner data
```

### Using create() Method

```python
# Create a single record
partner = self.env['res.partner'].create({
    'name': 'New Partner',
    'email': 'partner@example.com',
    'phone': '1234567890'
})
# Returns: res.partner(1,)

# Create with multiple fields
partner = self.env['res.partner'].create({
    'name': 'Odoo Methods',
    'email': 'odoomates@gmail.com',
    'phone': '1234567890',
    'customer': True,
    'supplier': False
})

# Create multiple records (bulk create)
partners = self.env['res.partner'].create([
    {'name': 'Partner 1', 'email': 'p1@example.com'},
    {'name': 'Partner 2', 'email': 'p2@example.com'},
    {'name': 'Partner 3', 'email': 'p3@example.com'}
])
# Returns: res.partner(1, 2, 3)
```

### create() with Variables

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

### create() with Related Fields

```python
# Create record with many2one field
order = self.env['sale.order'].create({
    'partner_id': 1,  # Reference to existing partner
    'date_order': fields.Datetime.now(),
})

# Create record with one2many field
order = self.env['sale.order'].create({
    'partner_id': 1,
    'order_line': [(0, 0, {
        'product_id': 1,
        'product_uom_qty': 10,
        'price_unit': 100
    })]
})
```

---

## 🎯 Practice Exercises

### Exercise 1: Using search_read()
- [ ] Search and read active partners with name and email
- [ ] Search and read first 10 partners ordered by name
- [ ] Search and read partners created today with all fields

### Exercise 2: Performance Comparison
- [ ] Compare `search_read()` vs `search()` + `read()` performance
- [ ] Measure execution time for both methods
- [ ] Use `search_read()` to optimize a slow query

### Exercise 3: Using create()
- [ ] Create a new partner with name, email, and phone
- [ ] Create multiple partners in one operation
- [ ] Create a sale order with related partner

### Exercise 4: Combined Operations
- [ ] Search for partners, then create a new partner
- [ ] Read partner data, modify it, and create a new one
- [ ] Use search_read() to get data, then create related records

---

## 📌 Important Notes

### Performance Considerations

1. **Use `search_read()`** when you need both search and read
   - More efficient than separate calls
   - Single database query

2. **Specify fields** in `search_read()`
   - Only fetch fields you need
   - Reduces data transfer

3. **Use limits** when possible
   - Don't fetch all records if you don't need them
   - Better for pagination

4. **Bulk create** is more efficient
   - Create multiple records in one call
   - Reduces database round trips

### When to Use Each Method

**Use `search_read()` when:**
- You need to search AND read fields
- Building APIs or JSON responses
- You need filtered data as dictionaries

**Use `search()` + `read()` when:**
- You need to perform operations between search and read
- You need the recordset for other operations
- You're doing complex processing

**Use `create()` when:**
- Creating new records programmatically
- Importing data
- Setting up test data

### create() Best Practices

1. **Validate data** before creating
2. **Use bulk create** for multiple records
3. **Handle errors** appropriately
4. **Set required fields** correctly
5. **Use proper field types** (dates, numbers, etc.)

### Common create() Patterns

```python
# Get or create pattern
partner = self.env['res.partner'].search([('email', '=', 'test@example.com')], limit=1)
if not partner:
    partner = self.env['res.partner'].create({
        'name': 'Test Partner',
        'email': 'test@example.com'
    })

# Create with defaults
partner = self.env['res.partner'].with_context(default_customer=True).create({
    'name': 'New Customer'
})
```

---

## 🔗 Related Topics

- `search()` method
- `read()` method
- `write()` method (updating records)
- `unlink()` method (deleting records)
- Performance optimization

---

## ❓ Common Questions

**Q: Is `search_read()` always faster than `search()` + `read()`?**  
A: Yes, `search_read()` is generally faster because it's a single database query instead of two.

**Q: Can I use `search_read()` for all read operations?**  
A: Not always. If you already have a recordset, use `read()` directly. Use `search_read()` when you need to search first.

**Q: What happens if I create a record with invalid data?**  
A: Odoo will raise a validation error. Always validate data or handle exceptions.

**Q: Can I create records with computed fields?**  
A: Computed fields are calculated automatically. You typically don't set them directly in `create()`.

**Q: How do I create records with one2many or many2many fields?**  
A: Use special commands like `(0, 0, {...})` for one2many and `[(6, 0, [ids])]` for many2many.

---

## 📚 Additional Resources

- Odoo search_read() Documentation
- create() Method Reference
- Field Commands (one2many, many2many)
- Performance Optimization Guide

---

**Previous Lesson:** [Lesson 3: Read Operations](./lesson_03_read_operations.md)  
**Next Phase:** [Phase 2: Write Operations](../phase2_write_operations/)

---

## 📝 Transcript Notes (from video)

### Key Points from Video:

1. **Using Playground for Testing:**
   - Odoo 15 has a playground feature in Technical menu
   - Can write and execute code directly
   - Results shown immediately

2. **create() Method Basics:**
   - Initialize model: `self.env['model.name']`
   - Call create: `.create({})`
   - Pass values as dictionary
   - Returns created record with ID

3. **Example from Video:**
   ```python
   self.env['hospital.patient'].create({
       'name': 'ORM Methods'
   })
   # Returns: hospital.patient(71,)
   ```

4. **Multiple Fields:**
   ```python
   self.env['hospital.patient'].create({
       'name': 'Odoo Methods',
       'email': 'odoomates@gmail.com',
       'phone': '1234567890'
   })
   ```

5. **Using Variables:**
   ```python
   vals = {
       'name': 'Odoo Methods',
       'email': 'odoomates@gmail.com',
       'phone': '1234567890'
   }
   self.env['hospital.patient'].create(vals)
   ```

