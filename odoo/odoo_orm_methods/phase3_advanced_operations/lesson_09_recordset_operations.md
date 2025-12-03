# Lesson 9: Recordset Operations

**Video:** https://www.youtube.com/watch?v=0qg-6rlo3oU  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Master the `mapped()` method
- Learn the `filtered()` method
- Understand the `sorted()` method
- Chain multiple operations
- Transform and manipulate recordsets efficiently

---

## 📝 Key Concepts

### The `mapped()` Method

The `mapped()` method extracts field values or applies a function to each record in a recordset.

**Basic Syntax:**
```python
values = records.mapped('field_name')
values = records.mapped(lambda r: r.field_name)
```

**Returns:**
- List of values (not a recordset)

### The `filtered()` Method

The `filtered()` method filters recordsets based on a condition.

**Basic Syntax:**
```python
filtered = records.filtered('field_name')
filtered = records.filtered(lambda r: condition)
```

**Returns:**
- New recordset with filtered records

### The `sorted()` Method

The `sorted()` method sorts recordsets based on a field or function.

**Basic Syntax:**
```python
sorted = records.sorted('field_name')
sorted = records.sorted(key=lambda r: r.field_name, reverse=False)
```

**Returns:**
- New recordset with sorted records

### Chaining Operations

You can chain multiple recordset operations together.

```python
result = records.filtered('active').sorted('name').mapped('email')
```

---

## 💻 Code Examples

### Using mapped()

```python
# Get all partners
partners = self.env['res.partner'].search([])

# Get list of partner names
partner_names = partners.mapped('name')
# Returns: ['Azure Interior', 'Brandon', 'Swingman', ...]

# Get list of phone numbers
partner_phones = partners.mapped('phone')
# Returns: ['+1 234 567 8910', '+1 234 567 8911', ...]

# Get list of emails
partner_emails = partners.mapped('email')
# Returns: ['azure@example.com', 'brandon@example.com', ...]

# Get related records
partner_ids = partners.mapped('partner_id')
# Returns list of related partner recordsets

# Apply custom function
amounts = partners.mapped(lambda r: r.amount * 2)
# Returns list of calculated values
```

### Using filtered()

```python
# Filter only customers
customers = partners.filtered('customer')
# Returns only partners where customer=True

# Filter non-customers
non_customers = partners.filtered(lambda r: not r.customer)
# Returns partners where customer=False or not set

# Filter with custom condition
high_value = partners.filtered(lambda r: r.amount > 1000)
# Returns partners with amount > 1000

# Filter active records
active = partners.filtered('active')
# Returns only active partners
```

### Using sorted()

```python
# Sort by field name (ascending)
sorted_partners = partners.sorted('name')
# Returns partners sorted by name A-Z

# Sort by create date (ascending)
sorted_by_date = partners.sorted(lambda r: r.create_date)
# Returns partners sorted by creation date

# Sort by write date (descending)
sorted_by_write = partners.sorted(lambda r: r.write_date, reverse=True)
# Returns partners with most recently updated first

# Sort by multiple criteria
sorted_multi = partners.sorted(key=lambda r: (r.customer, r.name))
# Sort by customer status, then by name
```

### Chaining Operations

```python
# Chain multiple operations
result = partners.filtered('customer').sorted('name').mapped('email')
# 1. Filter customers
# 2. Sort by name
# 3. Get email addresses

# Complex chain
customer_emails = (
    self.env['res.partner']
    .search([])
    .filtered('customer')
    .filtered('active')
    .sorted('name')
    .mapped('email')
)
```

### Practical Examples

```python
# Get customer names sorted alphabetically
customer_names = (
    self.env['res.partner']
    .search([])
    .filtered('customer')
    .sorted('name')
    .mapped('name')
)

# Get high-value active customers
high_value_customers = (
    self.env['res.partner']
    .search([])
    .filtered('customer')
    .filtered('active')
    .filtered(lambda r: r.amount_total > 10000)
    .sorted('amount_total', reverse=True)
)

# Get email list of recent customers
recent_customer_emails = (
    self.env['res.partner']
    .search([('customer', '=', True)])
    .filtered(lambda r: r.create_date > '2024-01-01')
    .sorted('create_date', reverse=True)
    .mapped('email')
)
```

---

## 🎯 Practice Exercises

### Exercise 1: Using mapped()
- [ ] Get list of all partner names
- [ ] Get list of partner emails
- [ ] Get list of related records using mapped()
- [ ] Apply custom function with mapped()

### Exercise 2: Using filtered()
- [ ] Filter only active partners
- [ ] Filter customers only
- [ ] Filter with custom condition
- [ ] Chain multiple filters

### Exercise 3: Using sorted()
- [ ] Sort partners by name
- [ ] Sort by creation date (newest first)
- [ ] Sort by multiple criteria
- [ ] Sort in descending order

### Exercise 4: Chaining Operations
- [ ] Chain filter, sort, and map operations
- [ ] Create complex recordset transformations
- [ ] Optimize recordset operations

---

## 📌 Important Notes

### Return Types

- **`mapped()`** returns a **list** (not a recordset)
- **`filtered()`** returns a **recordset**
- **`sorted()`** returns a **recordset**
- All operations return **new objects** (immutable)

### Performance Considerations

1. **Chain operations** - More efficient than multiple separate calls
2. **Filter early** - Reduce recordset size before other operations
3. **Use mapped()** - More efficient than loops for field extraction
4. **Avoid nested loops** - Use recordset operations instead

### Common Patterns

#### Extract and Process
```python
# Get emails of active customers
emails = (
    partners
    .filtered('customer')
    .filtered('active')
    .mapped('email')
)
```

#### Filter and Sort
```python
# Get top 10 customers by amount
top_customers = (
    partners
    .filtered('customer')
    .sorted('amount_total', reverse=True)
    [:10]  # Limit to 10
)
```

#### Transform Recordsets
```python
# Get partner IDs from related records
partner_ids = orders.mapped('partner_id').ids
```

---

## 🔗 Related Topics

- `search()` method
- `read()` method
- Recordset basics
- Performance optimization

---

## ❓ Common Questions

**Q: What's the difference between `mapped()` and accessing fields directly?**  
A: `mapped()` works on multiple records and returns a list. Direct access works on single records.

**Q: Can I chain unlimited operations?**  
A: Yes, but be mindful of performance. Filter early to reduce recordset size.

**Q: Does `mapped()` return a recordset?**  
A: No, `mapped()` returns a list. Use `filtered()` or `sorted()` if you need a recordset.

**Q: Are these operations efficient?**  
A: Yes, they're optimized for performance. More efficient than Python loops.

---

## 📚 Additional Resources

- Odoo Recordset Operations Documentation
- Performance Best Practices
- Python List Comprehensions

---

**Previous Lesson:** [Lesson 8: Browse and Exists](./lesson_08_browse_and_exists.md)  
**Next Lesson:** [Lesson 10: Context and Environment](./lesson_10_context_and_environment.md)

