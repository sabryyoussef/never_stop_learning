# Lesson 2: Search Methods

**Video:** https://www.youtube.com/watch?v=STKq2owQGII  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Understand the `search()` method and its parameters
- Learn about search domains
- Master search with filters, limit, offset, and ordering
- Understand when to use different search patterns

---

## 📝 Key Concepts

### The `search()` Method

The `search()` method is used to find records in the database based on a domain (search criteria).

**Basic Syntax:**
```python
records = self.env['model.name'].search(domain, limit=None, offset=0, order=None)
```

**Parameters:**
- `domain`: List of tuples defining search conditions
- `limit`: Maximum number of records to return
- `offset`: Number of records to skip (for pagination)
- `order`: Field(s) to sort by

### Search Domains

A domain is a list of conditions that filter records.

**Basic Domain Structure:**
```python
domain = [('field_name', 'operator', 'value')]
```

**Example:**
```python
# Search for active partners
partners = self.env['res.partner'].search([('active', '=', True)])

# Search with multiple conditions (AND by default)
partners = self.env['res.partner'].search([
    ('active', '=', True),
    ('customer', '=', True)
])
```

### Domain Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `=` | Equal | `[('field', '=', 'value')]` |
| `!=` | Not equal | `[('field', '!=', 'value')]` |
| `>` | Greater than | `[('field', '>', 100)]` |
| `>=` | Greater or equal | `[('field', '>=', 100)]` |
| `<` | Less than | `[('field', '<', 100)]` |
| `<=` | Less or equal | `[('field', '<=', 'value')]` |
| `like` | Pattern match | `[('field', 'like', 'pattern%')]` |
| `ilike` | Case-insensitive like | `[('field', 'ilike', 'pattern%')]` |
| `in` | In list | `[('field', 'in', [1, 2, 3])]` |
| `not in` | Not in list | `[('field', 'not in', [1, 2, 3])]` |

### Using Limit and Offset

**Limit:** Restrict the number of results
```python
# Get only first 10 records
records = self.env['res.partner'].search([], limit=10)
```

**Offset:** Skip records (for pagination)
```python
# Skip first 10, get next 10
records = self.env['res.partner'].search([], offset=10, limit=10)
```

**Pagination Example:**
```python
# Page 1: records 0-9
page1 = self.env['res.partner'].search([], offset=0, limit=10)

# Page 2: records 10-19
page2 = self.env['res.partner'].search([], offset=10, limit=10)
```

### Ordering Results

**Order by single field:**
```python
# Ascending order (default)
records = self.env['res.partner'].search([], order='name')

# Descending order
records = self.env['res.partner'].search([], order='name desc')
```

**Order by multiple fields:**
```python
# Order by name, then by date
records = self.env['res.partner'].search([], order='name, date desc')
```

### Combining Conditions (AND, OR, NOT)

**AND (default):**
```python
# All conditions must be true
domain = [
    ('active', '=', True),
    ('customer', '=', True)
]
```

**OR:**
```python
# At least one condition must be true
domain = [
    '|',
    ('field1', '=', 'value1'),
    ('field2', '=', 'value2')
]
```

**NOT:**
```python
# Negate a condition
domain = [
    ('field', '!=', 'value')
]
```

**Complex Combinations:**
```python
# (A AND B) OR (C AND D)
domain = [
    '|',
    '&', ('field1', '=', 'A'), ('field2', '=', 'B'),
    '&', ('field3', '=', 'C'), ('field4', '=', 'D')
]
```

---

## 💻 Code Examples

### Basic Search

```python
# Search all records
all_partners = self.env['res.partner'].search([])

# Search with condition
active_partners = self.env['res.partner'].search([('active', '=', True)])

# Search with multiple conditions
customer_partners = self.env['res.partner'].search([
    ('active', '=', True),
    ('customer', '=', True)
])
```

### Search with Limit

```python
# Get first 5 records
first_five = self.env['res.partner'].search([], limit=5)

# Get last 5 records (need to order first)
last_five = self.env['res.partner'].search([], order='id desc', limit=5)
```

### Search with Pagination

```python
def get_partners_page(page_number, page_size=10):
    offset = (page_number - 1) * page_size
    return self.env['res.partner'].search([], offset=offset, limit=page_size)
```

### Search with Ordering

```python
# Order by name ascending
sorted_by_name = self.env['res.partner'].search([], order='name')

# Order by creation date descending
newest_first = self.env['res.partner'].search([], order='create_date desc')

# Order by multiple fields
sorted_multi = self.env['res.partner'].search([], order='customer desc, name')
```

### Complex Domain Examples

```python
# Active customers or suppliers
domain = [
    '|',
    ('customer', '=', True),
    ('supplier', '=', True),
    ('active', '=', True)
]

# Partners created in last 30 days
from datetime import datetime, timedelta
date_limit = datetime.now() - timedelta(days=30)
domain = [('create_date', '>=', date_limit)]

# Partners with name containing "test"
domain = [('name', 'ilike', 'test')]
```

---

## 🎯 Practice Exercises

### Exercise 1: Basic Search
- [ ] Search for all active partners
- [ ] Search for partners with email containing "@gmail.com"
- [ ] Search for partners created today

### Exercise 2: Search with Limits
- [ ] Get the first 10 partners
- [ ] Get partners 11-20 (pagination)
- [ ] Get the last 5 partners by ID

### Exercise 3: Search with Ordering
- [ ] Order partners by name alphabetically
- [ ] Order partners by creation date (newest first)
- [ ] Order by customer status, then by name

### Exercise 4: Complex Domains
- [ ] Find active customers OR suppliers
- [ ] Find partners with name starting with "A" and active
- [ ] Find partners created in the last week

---

## 📌 Important Notes

- **Empty domain `[]`** returns all records (respecting access rights)
- **Limit `None`** means no limit (returns all matching records)
- **Offset** is useful for pagination but can be slow on large datasets
- **Order** can use field names or expressions like `'name desc'`
- Search respects **access rights** - users only see records they have permission to access
- Use `search_count()` instead of `len(search())` for better performance when you only need the count

### Performance Tips

1. **Use specific domains** - Don't search all records if you can filter
2. **Use limits** - If you only need a few records, use limit
3. **Index fields** - Frequently searched fields should be indexed
4. **Avoid offset on large datasets** - Consider using IDs for pagination instead

---

## 🔗 Related Topics

- `search_count()` - Count records without fetching them
- `search_read()` - Search and read in one operation
- Domain syntax and operators
- Access rights and security

---

## ❓ Common Questions

**Q: What's the difference between `search([])` and `search([('id', '>', 0)])`?**  
A: Both return all records, but `search([])` is more efficient and clearer.

**Q: Can I use SQL in search domains?**  
A: No, domains use Odoo's domain syntax, not SQL. For complex queries, consider using `search_read()` or raw SQL (with caution).

**Q: How do I search for NULL values?**  
A: Use `('field', '=', False)` for NULL values in most field types.

---

## 📚 Additional Resources

- Odoo Domain Syntax Documentation
- Search API Reference
- Performance Optimization Guide

---

**Previous Lesson:** [Lesson 1: Introduction to Odoo ORM](./lesson_01_introduction_to_odoo_orm.md)  
**Next Lesson:** [Lesson 3: Read Operations](./lesson_03_read_operations.md)

