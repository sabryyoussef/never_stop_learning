# Lesson 11: Advanced Search Patterns

**Video:** https://www.youtube.com/watch?v=h_6cBqeEkGQ  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Master complex search domains
- Learn search optimization techniques
- Understand search with joins
- Apply performance best practices
- Write efficient search queries

---

## 📝 Key Concepts

### Complex Search Domains

Advanced domain syntax for complex queries:
- Multiple AND/OR conditions
- Nested conditions
- Field operators
- Related field searches

### Search Optimization

Techniques to improve search performance:
- Use indexes
- Limit results
- Optimize domain conditions
- Avoid unnecessary searches

### Search with Related Fields

Searching through related models:
- Many2one field searches
- One2many field searches
- Many2many field searches

---

## 💻 Code Examples

### Complex Domain Patterns

```python
# Multiple AND conditions
domain = [
    ('active', '=', True),
    ('customer', '=', True),
    ('country_id', '!=', False)
]

# OR conditions
domain = [
    '|',
    ('customer', '=', True),
    ('supplier', '=', True)
]

# Complex nested conditions
domain = [
    '|',
    '&', ('field1', '=', 'A'), ('field2', '=', 'B'),
    '&', ('field3', '=', 'C'), ('field4', '=', 'D')
]

# Date range searches
from datetime import datetime, timedelta
date_from = datetime.now() - timedelta(days=30)
domain = [
    ('create_date', '>=', date_from),
    ('create_date', '<=', datetime.now())
]
```

### Search with Related Fields

```python
# Search by many2one field
orders = self.env['sale.order'].search([
    ('partner_id.country_id', '=', 1)  # Orders from country ID 1
])

# Search by one2many field
partners = self.env['res.partner'].search([
    ('order_ids.state', '=', 'sale')  # Partners with confirmed orders
])

# Search by many2many field
products = self.env['product.product'].search([
    ('categ_id.name', 'ilike', 'electronics')
])
```

### Optimized Search Patterns

```python
# Use limit when you only need a few records
top_customers = self.env['res.partner'].search([
    ('customer', '=', True)
], order='amount_total desc', limit=10)

# Use search_count for counts
count = self.env['res.partner'].search_count([
    ('active', '=', True)
])
# More efficient than len(search())

# Combine with exists() for safety
partners = self.env['res.partner'].search([('active', '=', True)])
existing = partners.exists()
```

### Performance Optimization

```python
# Bad: Multiple searches
for partner_id in partner_ids:
    partner = self.env['res.partner'].browse(partner_id)
    if partner.customer:
        # Process

# Good: Single search with filter
partners = self.env['res.partner'].browse(partner_ids)
customers = partners.filtered('customer')
for customer in customers:
    # Process

# Bad: Search all then filter in Python
all_partners = self.env['res.partner'].search([])
customers = [p for p in all_partners if p.customer]

# Good: Filter in domain
customers = self.env['res.partner'].search([('customer', '=', True)])
```

---

## 🎯 Practice Exercises

### Exercise 1: Complex Domains
- [ ] Write domains with multiple AND conditions
- [ ] Write domains with OR conditions
- [ ] Create nested domain conditions
- [ ] Search with date ranges

### Exercise 2: Related Field Searches
- [ ] Search by many2one fields
- [ ] Search by one2many fields
- [ ] Search by many2many fields
- [ ] Combine related field searches

### Exercise 3: Optimization
- [ ] Optimize slow searches
- [ ] Use search_count() instead of len(search())
- [ ] Use limits appropriately
- [ ] Compare search performance

---

## 📌 Important Notes

### Performance Tips

1. **Use indexes** - Frequently searched fields should be indexed
2. **Limit results** - Use limit parameter when possible
3. **Filter in domain** - Don't filter in Python
4. **Use search_count()** - For counts, not len(search())
5. **Avoid loops** - Batch operations instead

### Domain Best Practices

1. **Keep it simple** - Complex domains can be slow
2. **Use appropriate operators** - Choose the right operator
3. **Index frequently searched fields** - Improves performance
4. **Test performance** - Measure and optimize

### Common Mistakes

1. **Searching all records** - Always use appropriate domains
2. **Filtering in Python** - Filter in domain instead
3. **Multiple searches in loops** - Batch operations
4. **Not using limits** - When you only need a few records

---

## 🔗 Related Topics

- `search()` method
- `search_count()` method
- `search_read()` method
- Performance optimization

---

## ❓ Common Questions

**Q: How do I optimize slow searches?**  
A: Use indexes, add limits, filter in domain, and avoid unnecessary searches.

**Q: Can I search by related fields?**  
A: Yes, use dot notation: `('partner_id.country_id', '=', 1)`

**Q: When should I use search_count()?**  
A: When you only need the count, not the actual records.

**Q: How do I search with date ranges?**  
A: Use `>=` and `<=` operators with date values.

---

## 📚 Additional Resources

- Odoo Domain Syntax Documentation
- Search Performance Guide
- Database Indexing

---

**Previous Lesson:** [Lesson 10: Context and Environment](./lesson_10_context_and_environment.md)  
**Next Phase:** [Phase 4: Specialized Methods](../phase4_specialized_methods/)

