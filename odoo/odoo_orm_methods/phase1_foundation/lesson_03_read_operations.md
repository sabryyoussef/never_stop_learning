# Lesson 3: Read Operations

**Video:** https://www.youtube.com/watch?v=a4KWUtN1nVw  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Understand the `read()` method
- Learn about `read_group()` for aggregations
- Master reading specific fields
- Understand reading related fields
- Learn when to use different read methods

---

## 📝 Key Concepts

### The `read()` Method

The `read()` method retrieves field values from records and returns them as dictionaries.

**Basic Syntax:**
```python
values = record.read(fields=None)
values = records.read(fields=None)
```

**Parameters:**
- `fields`: List of field names to read (None = all fields)

**Returns:**
- List of dictionaries, each containing field values

### Reading All Fields

```python
# Read all fields from a record
record = self.env['res.partner'].browse(1)
data = record.read()
# Returns: [{'id': 1, 'name': 'Partner Name', 'email': '...', ...}]

# Read all fields from multiple records
records = self.env['res.partner'].search([('active', '=', True)])
data = records.read()
# Returns: [{...}, {...}, ...]
```

### Reading Specific Fields

```python
# Read only specific fields
record = self.env['res.partner'].browse(1)
data = record.read(['name', 'email', 'phone'])
# Returns: [{'id': 1, 'name': '...', 'email': '...', 'phone': '...'}]
```

### Reading Related Fields

```python
# Read related fields (many2one, one2many, many2many)
record = self.env['sale.order'].browse(1)
data = record.read(['name', 'partner_id', 'order_line'])
# partner_id will include related partner data
# order_line will include all related order lines
```

### The `read_group()` Method

`read_group()` is used for aggregations and grouping data, similar to SQL GROUP BY.

**Basic Syntax:**
```python
result = self.env['model.name'].read_group(
    domain,
    fields,
    groupby,
    offset=0,
    limit=None,
    orderby=None
)
```

**Parameters:**
- `domain`: Search domain to filter records
- `fields`: Fields to aggregate (with aggregation functions)
- `groupby`: Fields to group by
- `offset`: Skip records
- `limit`: Maximum groups to return
- `orderby`: Order groups

**Aggregation Functions:**
- `:sum` - Sum of numeric values
- `:avg` - Average of numeric values
- `:min` - Minimum value
- `:max` - Maximum value
- `:count` - Count of records

---

## 💻 Code Examples

### Basic Read Operations

```python
# Read all fields from a single record
partner = self.env['res.partner'].browse(1)
partner_data = partner.read()
print(partner_data)
# Output: [{'id': 1, 'name': 'ABC Company', 'email': '...', ...}]

# Read specific fields
partner_data = partner.read(['name', 'email', 'phone'])
print(partner_data)
# Output: [{'id': 1, 'name': 'ABC Company', 'email': 'abc@example.com', 'phone': '1234567890'}]

# Read from recordset
partners = self.env['res.partner'].search([('active', '=', True)])
partners_data = partners.read(['name', 'email'])
print(partners_data)
# Output: [{'id': 1, 'name': '...', 'email': '...'}, {'id': 2, ...}, ...]
```

### Reading Related Fields

```python
# Read many2one field (includes related record data)
order = self.env['sale.order'].browse(1)
order_data = order.read(['name', 'partner_id'])
# partner_id will be: [id, name] or full record data

# Read one2many field
order_data = order.read(['name', 'order_line'])
# order_line will include all related order line records

# Read many2many field
product = self.env['product.product'].browse(1)
product_data = product.read(['name', 'categ_id'])
# categ_id will include category information
```

### Using read_group() for Aggregations

```python
# Group sales orders by partner and sum amounts
result = self.env['sale.order'].read_group(
    [('state', '=', 'sale')],  # Domain: only confirmed orders
    ['amount_total:sum'],        # Field to aggregate
    ['partner_id']              # Group by partner
)
# Returns: [{'partner_id': (id, name), 'amount_total': sum, '__count': count}, ...]

# Group by date
result = self.env['sale.order'].read_group(
    [('state', '=', 'sale')],
    ['amount_total:sum'],
    ['date_order:day']  # Group by day
)

# Multiple aggregations
result = self.env['sale.order'].read_group(
    [('state', '=', 'sale')],
    ['amount_total:sum', 'amount_total:avg', 'amount_total:max'],
    ['partner_id']
)

# Group by multiple fields
result = self.env['sale.order'].read_group(
    [('state', '=', 'sale')],
    ['amount_total:sum'],
    ['partner_id', 'state']
)
```

### Advanced read_group() Examples

```python
# Count orders by state
result = self.env['sale.order'].read_group(
    [],
    [],
    ['state']
)
# Returns count of orders in each state

# Average order value by partner
result = self.env['sale.order'].read_group(
    [('state', '=', 'sale')],
    ['amount_total:avg'],
    ['partner_id']
)

# Monthly sales summary
result = self.env['sale.order'].read_group(
    [('state', '=', 'sale')],
    ['amount_total:sum'],
    ['date_order:month']
)
```

---

## 🎯 Practice Exercises

### Exercise 1: Basic Read
- [ ] Read all fields from a partner record
- [ ] Read only name and email from a partner
- [ ] Read name, email, and phone from multiple partners

### Exercise 2: Read Related Fields
- [ ] Read a sale order with its partner information
- [ ] Read a sale order with its order lines
- [ ] Read a product with its category information

### Exercise 3: Using read_group()
- [ ] Count partners by country
- [ ] Sum order amounts by partner
- [ ] Calculate average order value by month
- [ ] Group products by category and count them

### Exercise 4: Complex Aggregations
- [ ] Find total sales by partner and state
- [ ] Calculate monthly sales with min, max, and average
- [ ] Group orders by partner and show count and total amount

---

## 📌 Important Notes

### When to Use `read()`

- **Use `read()`** when you need field values as dictionaries
- **Use `read()`** when working with APIs or JSON responses
- **Use `read()`** when you need related field data in a structured format
- **Don't use `read()`** if you just need to access field values (use dot notation instead)

### When to Use `read_group()`

- **Use `read_group()`** for reports and analytics
- **Use `read_group()`** for aggregations (sum, avg, count, etc.)
- **Use `read_group()`** for grouping data
- **Much more efficient** than reading all records and grouping in Python

### Performance Considerations

1. **Specify fields** - Only read fields you need
2. **Use `read_group()`** - More efficient than reading all and grouping
3. **Avoid reading large recordsets** - Use limits or filters
4. **Related fields** - Reading related fields can be expensive

### Field Access Comparison

```python
# Direct field access (faster, simpler)
partner = self.env['res.partner'].browse(1)
name = partner.name  # Direct access

# Using read() (slower, but returns dict)
data = partner.read(['name'])
name = data[0]['name']  # Dictionary access

# Use direct access when possible
# Use read() when you need dictionary format
```

---

## 🔗 Related Topics

- `search_read()` - Combine search and read
- Field types and relationships
- Performance optimization
- API integration

---

## ❓ Common Questions

**Q: What's the difference between `record.field` and `record.read(['field'])[0]['field']`?**  
A: Direct access (`record.field`) is faster and simpler. Use `read()` when you need dictionary format or multiple fields efficiently.

**Q: Can I read computed fields?**  
A: Yes, computed fields are included in `read()` results, but they're calculated on-the-fly.

**Q: How do I read fields from related records?**  
A: Related fields are automatically included when you read a field that references another model.

**Q: Is `read_group()` faster than reading all and grouping in Python?**  
A: Yes, `read_group()` is much more efficient as it groups at the database level.

---

## 📚 Additional Resources

- Odoo Read API Documentation
- read_group() Reference
- Field Types and Relationships
- Performance Best Practices

---

**Previous Lesson:** [Lesson 2: Search Methods](./lesson_02_search_methods.md)  
**Next Lesson:** [Lesson 4: Search and Read Combined](./lesson_04_search_and_read_combined.md)

