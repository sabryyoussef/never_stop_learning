# Lesson 7: Delete Operations

**Video:** https://www.youtube.com/watch?v=Zc3uLs8O8Og  
**Status:** ⬜ Not Started  
**Date Completed:** 

---

## 📚 Learning Objectives

- Master the `unlink()` method
- Understand soft delete vs hard delete
- Learn about cascade deletions
- Handle access rights for deletions
- Safely delete records

---

## 📝 Key Concepts

### The `unlink()` Method

The `unlink()` method permanently deletes records from the database.

**Basic Syntax:**
```python
record.unlink()
records.unlink()
```

**Returns:**
- `True` if successful

**Important:** This is a **permanent deletion**. The record cannot be recovered.

### Deleting Single Records

```python
# Delete a single record
partner = self.env['res.partner'].browse(1)
partner.unlink()
# Returns: True
# Record is permanently deleted
```

### Bulk Deletions

```python
# Delete multiple records at once
partners = self.env['res.partner'].search([('active', '=', False)])
partners.unlink()
# All inactive partners are deleted
```

### Soft Delete vs Hard Delete

#### Soft Delete (Recommended)
```python
# Instead of deleting, mark as inactive
partner = self.env['res.partner'].browse(1)
partner.write({'active': False})
# Record still exists but is hidden
```

#### Hard Delete (Permanent)
```python
# Permanently delete record
partner = self.env['res.partner'].browse(1)
partner.unlink()
# Record is completely removed from database
```

### Cascade Deletions

Odoo handles cascade deletions automatically based on field definitions:

- **ondelete='cascade'** - Related records are deleted
- **ondelete='set null'** - Related field is set to NULL
- **ondelete='restrict'** - Prevents deletion if related records exist

### Access Rights

- **Access rights** are checked automatically
- Users can only delete records they have permission to delete
- **Superuser** can delete any record

---

## 💻 Code Examples

### Basic Delete Operations

```python
# Delete a single record
partner = self.env['res.partner'].browse(1)
partner.unlink()
# Returns: True

# Delete using search
partner = self.env['res.partner'].search([('email', '=', 'test@example.com')], limit=1)
if partner:
    partner.unlink()
```

### Bulk Deletions

```python
# Delete all inactive partners
inactive_partners = self.env['res.partner'].search([('active', '=', False)])
inactive_partners.unlink()
# All inactive partners deleted

# Delete with condition
old_orders = self.env['sale.order'].search([
    ('state', '=', 'cancel'),
    ('create_date', '<', '2020-01-01')
])
old_orders.unlink()
```

### Safe Delete (Check Before Delete)

```python
# Check if record exists before deleting
partner = self.env['res.partner'].browse(1)
if partner.exists():
    partner.unlink()

# Check access rights
partner = self.env['res.partner'].browse(1)
if partner.check_access_rights('unlink', raise_exception=False):
    partner.unlink()
```

### Soft Delete Pattern

```python
# Instead of deleting, mark as inactive
def soft_delete_partner(self, partner_id):
    partner = self.env['res.partner'].browse(partner_id)
    if partner.exists():
        partner.write({'active': False})
        # Record is hidden but not deleted
        return True
    return False
```

### Delete with Validation

```python
# Delete with checks
def safe_delete_partner(self, partner_id):
    partner = self.env['res.partner'].browse(partner_id)
    
    # Check if record exists
    if not partner.exists():
        return False
    
    # Check if has related records
    orders = self.env['sale.order'].search([('partner_id', '=', partner_id)])
    if orders:
        raise UserError("Cannot delete partner with existing orders")
    
    # Delete the record
    partner.unlink()
    return True
```

### Delete Related Records

```python
# Delete order lines before deleting order
order = self.env['sale.order'].browse(1)
order.order_line.unlink()  # Delete all lines
order.unlink()  # Delete order

# Or let cascade handle it (if configured)
order.unlink()  # Lines deleted automatically if ondelete='cascade'
```

---

## 🎯 Practice Exercises

### Exercise 1: Basic Delete
- [ ] Delete a single partner record
- [ ] Delete a record found by search
- [ ] Verify the record is deleted

### Exercise 2: Bulk Delete
- [ ] Delete all inactive partners
- [ ] Delete records based on a condition
- [ ] Count records before and after deletion

### Exercise 3: Safe Delete
- [ ] Check if record exists before deleting
- [ ] Check access rights before deleting
- [ ] Handle deletion errors gracefully

### Exercise 4: Soft Delete
- [ ] Implement soft delete (mark as inactive)
- [ ] Compare soft delete vs hard delete
- [ ] Restore a soft-deleted record

---

## 📌 Important Notes

### When to Use unlink()

- **Use `unlink()`** when you need to permanently remove records
- **Consider soft delete** (mark as inactive) for important records
- **Check dependencies** before deleting
- **Handle errors** appropriately

### Safety Considerations

1. **Always check if record exists** - Use `exists()` before `unlink()`
2. **Check access rights** - Verify user has permission to delete
3. **Check dependencies** - Ensure no related records will be orphaned
4. **Use soft delete** - For important records, consider marking inactive instead
5. **Backup important data** - Before bulk deletions

### Common Patterns

#### Safe Delete with Exists Check
```python
record = self.env['model'].browse(id)
if record.exists():
    record.unlink()
```

#### Delete with Access Check
```python
record = self.env['model'].browse(id)
if record.exists() and record.check_access_rights('unlink', raise_exception=False):
    record.unlink()
```

#### Soft Delete Pattern
```python
# Instead of unlink(), mark as inactive
record.write({'active': False})
```

#### Delete with Validation
```python
def delete_if_safe(self, record_id):
    record = self.env['model'].browse(record_id)
    if not record.exists():
        return False
    
    # Check for dependencies
    if self._has_dependencies(record):
        raise UserError("Cannot delete: has dependencies")
    
    record.unlink()
    return True
```

### Cascade Deletions

Odoo automatically handles cascade based on field `ondelete` parameter:

```python
# In model definition
partner_id = fields.Many2one('res.partner', ondelete='cascade')
# When partner is deleted, related records are deleted

partner_id = fields.Many2one('res.partner', ondelete='set null')
# When partner is deleted, field is set to NULL

partner_id = fields.Many2one('res.partner', ondelete='restrict')
# Prevents deletion if related records exist
```

### Error Handling

```python
try:
    partner = self.env['res.partner'].browse(1)
    partner.unlink()
except AccessError:
    # User doesn't have permission
    raise UserError("You don't have permission to delete this record")
except Exception as e:
    # Other errors
    raise UserError(f"Cannot delete record: {e}")
```

---

## 🔗 Related Topics

- `create()` method
- `write()` method
- `exists()` method
- Access rights
- Model constraints

---

## ❓ Common Questions

**Q: Can I recover a deleted record?**  
A: No, `unlink()` permanently deletes records. Consider using soft delete (mark as inactive) instead.

**Q: What happens to related records when I delete?**  
A: It depends on the `ondelete` parameter: 'cascade' deletes them, 'set null' sets to NULL, 'restrict' prevents deletion.

**Q: Can I delete multiple records at once?**  
A: Yes, call `unlink()` on a recordset with multiple records.

**Q: How do I check if a record still exists after deletion?**  
A: Use `exists()` method: `if record.exists(): ...`

**Q: What's the difference between soft delete and hard delete?**  
A: Soft delete marks records as inactive (hidden but kept), hard delete permanently removes them from database.

---

## 📚 Additional Resources

- Odoo unlink() Method Documentation
- Cascade Deletions Guide
- Access Rights Documentation
- Soft Delete Patterns

---

**Previous Lesson:** [Lesson 6: Update Records](./lesson_06_update_records.md)  
**Next Phase:** [Phase 3: Advanced Operations](../phase3_advanced_operations/)

---

## 📝 Video Notes (from transcript)

### Key Points from Video:

1. **Basic unlink() usage:**
   ```python
   record.unlink()
   ```

2. **Example from video:**
   ```python
   # Browse a record to delete
   patient = self.env['hospital.patient'].browse(73)
   
   # Delete the record
   patient.unlink()
   # Returns: True
   # Record is permanently deleted from database
   ```

3. **Bulk delete:**
   ```python
   # Delete multiple records
   patients = self.env['hospital.patient'].browse([72, 73])
   patients.unlink()
   ```

4. **Important points:**
   - `unlink()` returns `True` on success
   - Deletion is **permanent** - cannot be recovered
   - Record count decreases after deletion
   - Always verify record exists before deleting

5. **From video transcript:**
   - Initially had 16 records
   - After deleting record 73: 15 records
   - After deleting record 72: 14 records
   - Each deletion reduces the count

