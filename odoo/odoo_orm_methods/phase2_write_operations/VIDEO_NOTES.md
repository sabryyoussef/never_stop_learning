# Phase 2 Video Notes - Extracted from Transcripts

This file contains key points extracted directly from the YouTube video transcripts.

---

## Lesson 5 Video: Browse ORM Method

**Video ID:** qgcGpdGCxeA  
**Title:** Odoo Browse ORM Method | Odoo ORM Methods

**Note:** This video is about the `browse()` method, not `create()`. The `browse()` method is covered in Phase 3, but the video is in this playlist position.

### Key Points:

#### 1. Browse Method Basics
- **Purpose:** Get records by ID(s) without searching
- **Syntax:** `self.env['model.name'].browse(id)` or `browse([id1, id2, ...])`
- **Use Case:** When you already know the ID(s) of the record(s)

**Example from video:**
```python
# Browse single record by ID
patient = self.env['hospital.patient'].browse(51)
# Returns: hospital.patient(51,)

# Access field values
patient.name  # Returns: 'Papaya'
patient.email  # Returns: 'odoomates@gmail.com'
patient.phone  # Returns phone number
```

#### 2. Browse Multiple Records
```python
# Browse multiple records by IDs
patients = self.env['hospital.patient'].browse([51, 72])
# Returns: hospital.patient(51, 72)

# Accessing fields on multiple records causes SingletonError
# patients.name  # Error: Expected singleton

# Solution: Use mapped() or loop
patient_names = patients.mapped('name')
# Returns: ['Papaya', 'Odoo Mates Test']

# Or loop through
for patient in patients:
    print(patient.name)
```

#### 3. Browse Non-Existing Records
```python
# Browse a non-existing ID
patient = self.env['hospital.patient'].browse(200)
# Returns: hospital.patient(200,) - recordset is created

# But accessing fields shows error
patient.name  # Error: Record does not exist
```

#### 4. Using exists() with browse()
```python
# Check if record exists
patient = self.env['hospital.patient'].browse(200)
if patient.exists():
    print(patient.name)
else:
    print("Record does not exist")

# For multiple records
patients = self.env['hospital.patient'].browse([51, 200])
existing = patients.exists()
# Returns only existing records
```

### Important Notes:
- `browse()` doesn't verify if record exists until you access a field
- Use `exists()` to check if records exist
- For multiple records, use `mapped()` or loop to access fields
- More efficient than `search()` when you know the IDs

---

## Lesson 6 Video: Write ORM Method

**Video ID:** Cm-DBN_Q-pk  
**Title:** Odoo Write ORM Method || Odoo ORM Methods

### Key Points:

#### 1. Write Method Basics
- **Purpose:** Update existing records
- **Syntax:** `record.write({'field': 'value'})`
- **Returns:** `True` on success

**Example from video:**
```python
# Browse a record
patient = self.env['hospital.patient'].browse(3)

# Update name
patient.write({'name': 'Updated Name'})
# Returns: True
# Name is updated in database

# Update email
patient.write({'email': 'dummy@example.com'})
# Returns: True
```

#### 2. Updating Multiple Fields
```python
# Update multiple fields at once
patient.write({
    'name': 'ORM',
    'email': 'odoomates@gmail.com'
})
# Both fields updated in one operation
```

#### 3. Practical Example from Video
```python
# Initial record
patient = self.env['hospital.patient'].browse(3)
patient.name  # 'Odoo Mates'

# Update name
patient.write({'name': 'Updated Name'})
# After refresh: 'Updated Name'

# Update email
patient.write({'email': 'dummy@example.com'})
# Email field is set

# Update name again
patient.write({'name': 'ORM'})
# Name changed to 'ORM'
```

### Important Notes:
- `write()` returns `True` on success
- Pass field values as dictionary
- Can update multiple fields in one call
- Use technical field names (not display names)
- Changes are saved immediately to database

---

## Lesson 7 Video: Unlink ORM Method

**Video ID:** Zc3uLs8O8Og  
**Title:** Odoo Unlink ORM Method || Odoo ORM Documentation

### Key Points:

#### 1. Unlink Method Basics
- **Purpose:** Permanently delete records from database
- **Syntax:** `record.unlink()`
- **Returns:** `True` on success
- **Warning:** Deletion is **permanent** and cannot be recovered

**Example from video:**
```python
# Browse record to delete
patient = self.env['hospital.patient'].browse(73)

# Delete the record
patient.unlink()
# Returns: True
# Record is permanently deleted
```

#### 2. Verification from Video
```python
# Before deletion: 16 records in database
# Delete record 73
patient = self.env['hospital.patient'].browse(73)
patient.unlink()
# After deletion: 15 records (count decreased)

# Delete record 72
patient = self.env['hospital.patient'].browse(72)
patient.unlink()
# After deletion: 14 records (count decreased)
```

#### 3. Important Points
- Deletion is **permanent** - cannot be undone
- Record count decreases after deletion
- No confirmation dialog - executes immediately
- Always verify before deleting important records

### Best Practices:
1. **Check before deleting:**
   ```python
   patient = self.env['hospital.patient'].browse(id)
   if patient.exists():
       patient.unlink()
   ```

2. **Consider soft delete:**
   ```python
   # Instead of unlink(), mark as inactive
   patient.write({'active': False})
   ```

3. **Bulk delete:**
   ```python
   # Delete multiple records
   patients = self.env['hospital.patient'].browse([72, 73])
   patients.unlink()
   ```

---

## Summary

### Browse Method (Lesson 5 video):
- Get records by ID(s) directly
- More efficient than search when you know IDs
- Use `exists()` to verify record existence
- For multiple records, use `mapped()` or loop

### Write Method (Lesson 6 video):
- Update existing records
- Returns `True` on success
- Can update multiple fields at once
- Changes saved immediately

### Unlink Method (Lesson 7 video):
- Permanently delete records
- Returns `True` on success
- Deletion is permanent - cannot be recovered
- Always verify before deleting

---

**Note:** The Lesson 5 video is about `browse()` method, which is typically covered in Phase 3. However, `browse()` is useful for getting records before using `write()` or `unlink()`, so understanding it helps with write operations.

