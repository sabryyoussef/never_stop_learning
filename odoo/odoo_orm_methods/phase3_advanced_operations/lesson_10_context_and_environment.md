# Lesson 10: Context and Environment

**Video:** https://www.youtube.com/watch?v=XBj4GgYUSGA  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Understand the `with_context()` method
- Learn about context in Odoo
- Master the `sudo()` method
- Understand user permissions and context
- Use context for default values and behavior

---

## 📝 Key Concepts

### The `with_context()` Method

The `with_context()` method adds or modifies context for operations.

**Basic Syntax:**
```python
records = self.env['model'].with_context(key=value)
records = self.env['model'].with_context(**context_dict)
```

**Common Uses:**
- Set default values
- Change language
- Pass flags to methods
- Modify behavior

### Understanding Context

Context is a dictionary that carries information throughout a request:
- User preferences
- Default values
- Language settings
- Flags and options

### The `sudo()` Method

The `sudo()` method executes operations with elevated permissions (as superuser).

**Basic Syntax:**
```python
records = self.env['model'].sudo()
records = self.env['model'].sudo(user_id)
```

**Warning:** Use `sudo()` carefully - it bypasses security rules!

---

## 💻 Code Examples

### Using with_context()

```python
# Set default values
partner = self.env['res.partner'].with_context(
    default_customer=True,
    default_country_id=1
).create({
    'name': 'New Customer'
})

# Change language
records = self.env['res.partner'].with_context(lang='fr_FR').search([])

# Pass flags
records = self.env['sale.order'].with_context(
    skip_invoice_sync=True
).create({...})

# Multiple context values
records = self.env['model'].with_context(
    default_field1='value1',
    default_field2='value2',
    lang='es_ES'
)
```

### Accessing Context

```python
# Get current context
context = self.env.context
lang = context.get('lang')
default_customer = context.get('default_customer', False)

# Check context values
if 'skip_validation' in self.env.context:
    # Skip validation logic
    pass
```

### Using sudo()

```python
# Execute as superuser
partners = self.env['res.partner'].sudo().search([])
# Bypasses access rights

# Execute as specific user
partners = self.env['res.partner'].sudo(user_id=2).search([])
# Executes as user with ID 2

# Create with sudo
partner = self.env['res.partner'].sudo().create({
    'name': 'Admin Created'
})
```

### Combining Context and Sudo

```python
# Use both together
partner = (
    self.env['res.partner']
    .sudo()
    .with_context(default_customer=True)
    .create({'name': 'New Partner'})
)
```

### Common Context Patterns

```python
# Set default values for create
order = self.env['sale.order'].with_context(
    default_partner_id=1,
    default_date_order=fields.Datetime.now()
).create({})

# Change language for display
names = self.env['res.partner'].with_context(
    lang='fr_FR'
).browse(1).name_get()

# Pass flags to methods
result = self.env['model'].with_context(
    active_test=False  # Include inactive records
).search([])
```

---

## 🎯 Practice Exercises

### Exercise 1: Using with_context()
- [ ] Set default values using context
- [ ] Change language using context
- [ ] Pass custom flags in context
- [ ] Access context values

### Exercise 2: Using sudo()
- [ ] Execute operations as superuser
- [ ] Execute as specific user
- [ ] Understand security implications
- [ ] Use sudo() safely

### Exercise 3: Context Patterns
- [ ] Set defaults for create operations
- [ ] Modify behavior with context flags
- [ ] Chain context operations
- [ ] Access and modify context

---

## 📌 Important Notes

### Security Considerations

1. **`sudo()` bypasses security** - Use carefully
2. **Always validate** - Even with sudo()
3. **Document usage** - Explain why sudo() is needed
4. **Minimize scope** - Use sudo() only when necessary

### Context Best Practices

1. **Set defaults** - Use context for default values
2. **Pass flags** - Use context to modify behavior
3. **Language** - Use context for translations
4. **Don't abuse** - Don't pass too much in context

### Common Context Keys

- `default_*` - Default values for fields
- `lang` - Language code
- `active_test` - Include inactive records
- `tz` - Timezone
- `uid` - User ID
- `date` - Current date

---

## 🔗 Related Topics

- `create()` method
- `write()` method
- Access rights
- Security rules

---

## ❓ Common Questions

**Q: When should I use `sudo()`?**  
A: Only when you need to bypass access rights. Always document why and use it carefully.

**Q: Can I modify context?**  
A: Yes, use `with_context()` to add or modify context values.

**Q: Is context shared across requests?**  
A: No, context is per-request. Each request has its own context.

**Q: How do I pass context to methods?**  
A: Use `with_context()` before calling methods, or pass context explicitly.

---

## 📚 Additional Resources

- Odoo Context Documentation
- sudo() Method Reference
- Security Best Practices

---

**Previous Lesson:** [Lesson 9: Recordset Operations](./lesson_09_recordset_operations.md)  
**Next Lesson:** [Lesson 11: Advanced Search Patterns](./lesson_11_advanced_search_patterns.md)

