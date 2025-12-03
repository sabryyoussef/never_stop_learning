# Odoo ORM Methods - Quick Reference Guide

A quick reference for all Odoo ORM methods covered in the playlist.

---

## 📖 Table of Contents

1. [Search Methods](#search-methods)
2. [Read Methods](#read-methods)
3. [Write Methods](#write-methods)
4. [Recordset Operations](#recordset-operations)
5. [Context & Environment](#context--environment)
6. [Utility Methods](#utility-methods)

---

## 🔍 Search Methods

### `search(domain, limit=None, offset=0, order=None)`
Search for records matching a domain.

```python
# Basic search
records = self.env['model.name'].search([('field', '=', 'value')])

# With limit
records = self.env['model.name'].search([('field', '=', 'value')], limit=10)

# With offset (pagination)
records = self.env['model.name'].search([('field', '=', 'value')], offset=10, limit=10)

# With ordering
records = self.env['model.name'].search([('field', '=', 'value')], order='name desc')
```

### `search_count(domain)`
Count records matching a domain (more efficient than len(search())).

```python
count = self.env['model.name'].search_count([('field', '=', 'value')])
```

### `search_read(domain, fields=None, offset=0, limit=None, order=None)`
Search and read in one operation (more efficient).

```python
records = self.env['model.name'].search_read(
    [('field', '=', 'value')],
    fields=['name', 'date'],
    limit=10
)
```

---

## 📖 Read Methods

### `read(fields=None)`
Read field values from records.

```python
# Read all fields
values = record.read()

# Read specific fields
values = record.read(['name', 'date', 'amount'])

# Read from recordset
values = records.read(['name', 'date'])
```

### `read_group(domain, fields, groupby, offset=0, limit=None, orderby=None)`
Group records and compute aggregations.

```python
result = self.env['sale.order'].read_group(
    [('state', '=', 'sale')],
    fields=['amount_total:sum'],
    groupby=['partner_id']
)
```

---

## ✍️ Write Methods

### `create(vals_list)`
Create new record(s).

```python
# Create single record
record = self.env['model.name'].create({
    'name': 'New Record',
    'field': 'value'
})

# Create multiple records (bulk)
records = self.env['model.name'].create([
    {'name': 'Record 1'},
    {'name': 'Record 2'},
])
```

### `write(vals)`
Update existing record(s).

```python
# Update single record
record.write({'name': 'Updated Name'})

# Bulk update
records.write({'state': 'done'})
```

### `unlink()`
Delete record(s).

```python
# Delete single record
record.unlink()

# Delete multiple records
records.unlink()
```

### `copy(default=None)`
Copy record(s).

```python
# Copy with default values
new_record = record.copy({'name': 'Copy of ' + record.name})
```

---

## 🔄 Recordset Operations

### `mapped(func)`
Apply a function to each record and return a list.

```python
# Get list of field values
names = records.mapped('name')

# Get list of related records
partners = records.mapped('partner_id')

# Apply custom function
amounts = records.mapped(lambda r: r.amount * 2)
```

### `filtered(func)`
Filter recordset based on a function or field.

```python
# Filter by field value
active_records = records.filtered('active')

# Filter by custom function
high_amount = records.filtered(lambda r: r.amount > 100)
```

### `sorted(key=None, reverse=False)`
Sort recordset.

```python
# Sort by field
sorted_records = records.sorted('name')

# Sort by custom function
sorted_records = records.sorted(key=lambda r: r.amount, reverse=True)
```

---

## 🌐 Context & Environment

### `with_context(**context)`
Add or modify context.

```python
# Add context
records = self.env['model'].with_context(lang='fr_FR').search([])

# Modify context
records = self.env['model'].with_context(default_field='value')
```

### `sudo(user=None)`
Execute with elevated permissions.

```python
# Execute as superuser
records = self.env['model'].sudo().search([])

# Execute as specific user
records = self.env['model'].sudo(user_id).search([])
```

### `browse(ids)`
Get records by IDs (direct access, no search).

```python
records = self.env['model.name'].browse([1, 2, 3])
```

---

## 🛠️ Utility Methods

### `exists()`
Check if records still exist (useful after unlink).

```python
if record.exists():
    record.write({'field': 'value'})
```

### `ensure_one()`
Ensure recordset contains exactly one record.

```python
record = records.ensure_one()  # Raises error if not exactly one
```

### `name_get()`
Get display name for records.

```python
names = records.name_get()  # Returns [(id, name), ...]
```

### `name_search(name='', args=None, operator='ilike', limit=100)`
Search records by name (for autocomplete).

```python
results = self.env['model'].name_search('search term', limit=10)
```

---

## 📊 Domain Operators

| Operator | Description | Example |
|----------|-------------|---------|
| `=` | Equal | `[('field', '=', 'value')]` |
| `!=` | Not equal | `[('field', '!=', 'value')]` |
| `>` | Greater than | `[('field', '>', 100)]` |
| `>=` | Greater or equal | `[('field', '>=', 100)]` |
| `<` | Less than | `[('field', '<', 100)]` |
| `<=` | Less or equal | `[('field', '<=', 100)]` |
| `like` | Pattern match | `[('field', 'like', 'pattern%')]` |
| `ilike` | Case-insensitive like | `[('field', 'ilike', 'pattern%')]` |
| `in` | In list | `[('field', 'in', [1, 2, 3])]` |
| `not in` | Not in list | `[('field', 'not in', [1, 2, 3])]` |
| `child_of` | Child of (hierarchical) | `[('parent_id', 'child_of', parent_id)]` |
| `parent_of` | Parent of (hierarchical) | `[('id', 'parent_of', child_id)]` |

---

## 🔗 Combining Domains

```python
# AND (default)
domain = [('field1', '=', 'value1'), ('field2', '>', 100)]

# OR
domain = ['|', ('field1', '=', 'value1'), ('field2', '=', 'value2')]

# NOT
domain = [('field', '!=', 'value')]

# Complex: (A AND B) OR (C AND D)
domain = [
    '|',
    '&', ('field1', '=', 'A'), ('field2', '=', 'B'),
    '&', ('field3', '=', 'C'), ('field4', '=', 'D')
]
```

---

## ⚡ Performance Tips

1. **Use `search_count()` instead of `len(search())`**
   ```python
   # Bad
   count = len(self.env['model'].search([('field', '=', 'value')]))
   
   # Good
   count = self.env['model'].search_count([('field', '=', 'value')])
   ```

2. **Use `search_read()` instead of `search()` + `read()`**
   ```python
   # Bad
   records = self.env['model'].search([('field', '=', 'value')])
   data = records.read(['name', 'date'])
   
   # Good
   data = self.env['model'].search_read(
       [('field', '=', 'value')],
       fields=['name', 'date']
   )
   ```

3. **Bulk operations are faster**
   ```python
   # Bad - Multiple queries
   for record in records:
       record.write({'field': 'value'})
   
   # Good - Single query
   records.write({'field': 'value'})
   ```

4. **Use `browse()` for known IDs**
   ```python
   # Bad - Unnecessary search
   records = self.env['model'].search([('id', 'in', [1, 2, 3])])
   
   # Good - Direct access
   records = self.env['model'].browse([1, 2, 3])
   ```

---

## 🎯 Common Patterns

### Get or Create
```python
record = self.env['model'].search([('field', '=', 'value')], limit=1)
if not record:
    record = self.env['model'].create({'field': 'value'})
```

### Update or Create
```python
record = self.env['model'].search([('field', '=', 'value')], limit=1)
if record:
    record.write({'other_field': 'new_value'})
else:
    self.env['model'].create({
        'field': 'value',
        'other_field': 'new_value'
    })
```

### Safe Delete
```python
if record.exists():
    record.unlink()
```

### Get Related Records
```python
# One2many
related = record.one2many_field_ids

# Many2one
related = record.many2one_field_id

# Many2many
related = record.many2many_field_ids
```

---

**Last Updated:** 2025-01-27

