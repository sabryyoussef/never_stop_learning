# Lesson 15: Best Practices and Performance

**Video:** https://www.youtube.com/watch?v=jdDyLy2nttI  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Learn ORM method performance tips
- Understand common mistakes to avoid
- Master best practices summary
- Apply knowledge in real-world examples
- Optimize ORM operations

---

## 📝 Key Concepts

### Performance Optimization

Key techniques for improving ORM performance:
- Use appropriate methods
- Batch operations
- Optimize searches
- Minimize database queries

### Common Mistakes

Mistakes to avoid:
- Multiple queries in loops
- Not using bulk operations
- Inefficient searches
- Ignoring access rights

### Best Practices

Guidelines for effective ORM usage:
- Choose the right method
- Use bulk operations
- Optimize domains
- Handle errors properly

---

## 💻 Code Examples

### Performance Best Practices

```python
# Bad: Multiple queries in loop
for partner_id in partner_ids:
    partner = self.env['res.partner'].browse(partner_id)
    partner.write({'customer': True})

# Good: Bulk operation
partners = self.env['res.partner'].browse(partner_ids)
partners.write({'customer': True})

# Bad: Search then filter in Python
all_partners = self.env['res.partner'].search([])
customers = [p for p in all_partners if p.customer]

# Good: Filter in domain
customers = self.env['res.partner'].search([('customer', '=', True)])

# Bad: len(search())
count = len(self.env['res.partner'].search([('active', '=', True)]))

# Good: search_count()
count = self.env['res.partner'].search_count([('active', '=', True)])
```

### Using read_group() for Aggregations

```python
# Compute appointment count using read_group
def _compute_appointment_count(self):
    for record in self:
        record.appointment_count = 0
    
    # Group appointments by patient
    appointment_group = self.env['hospital.appointment'].read_group(
        [('state', '=', 'done')],  # Domain
        ['patient_id'],             # Fields
        ['patient_id']              # Group by
    )
    
    # Assign counts to patients
    for appointment in appointment_group:
        patient_id = appointment['patient_id'][0]
        patient = self.browse(patient_id)
        if patient.exists():
            patient.appointment_count = appointment['patient_id_count']
            self -= patient
    
    # Set zero for patients without appointments
    self.appointment_count = 0
```

### Optimized Search Patterns

```python
# Use indexes
# Ensure frequently searched fields are indexed
# In model definition:
_index = 'name'  # Index on name field

# Use limits
top_customers = self.env['res.partner'].search([
    ('customer', '=', True)
], order='amount_total desc', limit=10)

# Optimize domains
# Bad: Complex nested conditions
domain = [
    '|', '|',
    ('field1', '=', 'A'),
    ('field2', '=', 'B'),
    ('field3', '=', 'C')
]

# Good: Simplified when possible
domain = [
    ('field1', 'in', ['A', 'B', 'C'])
]
```

### Error Handling Best Practices

```python
# Always check existence
record = self.env['model'].browse(id)
if not record.exists():
    raise UserError("Record does not exist")

# Handle ensure_one() safely
try:
    record = records.ensure_one()
except ValueError:
    raise UserError("Expected exactly one record")

# Validate before operations
if not record.check_access_rights('write', raise_exception=False):
    raise AccessError("You don't have permission to write")
```

---

## 🎯 Practice Exercises

### Exercise 1: Performance Optimization
- [ ] Convert loop operations to bulk operations
- [ ] Optimize slow searches
- [ ] Use search_count() instead of len(search())
- [ ] Minimize database queries

### Exercise 2: Best Practices
- [ ] Apply best practices in code
- [ ] Fix common mistakes
- [ ] Optimize existing code
- [ ] Document improvements

### Exercise 3: Real-World Application
- [ ] Build a complete module using all ORM methods
- [ ] Apply performance optimizations
- [ ] Handle errors properly
- [ ] Test thoroughly

---

## 📌 Important Notes

### Performance Checklist

- [ ] Use bulk operations (create, write, unlink)
- [ ] Filter in domain, not in Python
- [ ] Use search_count() for counts
- [ ] Use browse() when you know IDs
- [ ] Use search_read() when you need both search and read
- [ ] Limit results when possible
- [ ] Index frequently searched fields

### Common Mistakes to Avoid

1. **Multiple queries in loops** - Use bulk operations
2. **Filtering in Python** - Filter in domain
3. **Not using limits** - Always limit when possible
4. **Ignoring access rights** - Always check permissions
5. **Not handling errors** - Always handle exceptions

### Best Practices Summary

1. **Choose the right method** - Use the most appropriate ORM method
2. **Batch operations** - Group operations together
3. **Optimize searches** - Use efficient domains
4. **Handle errors** - Always handle exceptions
5. **Document code** - Explain complex operations
6. **Test performance** - Measure and optimize

---

## 🔗 Related Topics

- All previous lessons
- Performance optimization
- Error handling
- Security best practices

---

## ❓ Common Questions

**Q: How do I optimize slow ORM operations?**  
A: Use bulk operations, filter in domains, use appropriate methods, and minimize database queries.

**Q: What are the most common mistakes?**  
A: Multiple queries in loops, filtering in Python, not using bulk operations, and ignoring access rights.

**Q: How do I measure performance?**  
A: Use Odoo's profiling tools, measure execution time, and monitor database queries.

---

## 📚 Additional Resources

- Odoo Performance Guide
- Best Practices Documentation
- Optimization Techniques
- Real-World Examples

---

**Previous Lesson:** [Lesson 14: Ensure One and Other Utilities](./lesson_14_ensure_one_and_utilities.md)  
**Course Complete!** 🎉

---

## 🎓 Course Completion

Congratulations on completing the Odoo ORM Methods learning path! You now have a comprehensive understanding of:

- ✅ All essential ORM methods
- ✅ When and how to use each method
- ✅ Performance optimization techniques
- ✅ Best practices and common patterns
- ✅ Error handling and security

**Next Steps:**
1. Build a custom Odoo module
2. Apply all learned methods
3. Contribute to open-source projects
4. Continue learning advanced topics

