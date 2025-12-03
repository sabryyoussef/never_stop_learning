# Phase 3 Video Notes - Extracted from Transcripts

This file contains key points extracted directly from the YouTube video transcripts.

---

## Lesson 8 Video: Search ORM Method

**Video ID:** tIaIixa3oAs  
**Title:** Odoo Search ORM Method || Odoo ORM Tutorial

**Note:** This video covers the `search()` method in detail, which complements the browse() lesson.

### Key Points:

#### 1. Basic Search
```python
# Search all records
partners = self.env['res.partner'].search([])
# Returns all records

# Search with domain
partners = self.env['res.partner'].search([('active', '=', True)])
# Returns filtered records
```

#### 2. Search with Domain
```python
# Single condition
patients = self.env['hospital.patient'].search([('gender', '=', 'male')])

# Multiple conditions (AND)
patients = self.env['hospital.patient'].search([
    ('gender', '=', 'female'),
    ('id', '=', 71)
])

# OR condition
patients = self.env['hospital.patient'].search([
    '|',
    ('id', '=', 71),
    ('gender', '=', 'female')
])
```

#### 3. Search with Limit
```python
# Limit results
patients = self.env['hospital.patient'].search([], limit=1)
# Returns only 1 record

patients = self.env['hospital.patient'].search([], limit=5)
# Returns 5 records

# Limit doesn't exceed total records
patients = self.env['hospital.patient'].search([], limit=50)
# Returns all records if total < 50
```

#### 4. Search with Order
```python
# Order by field (ascending by default)
patients = self.env['hospital.patient'].search([], order='id')
# Returns: 2, 3, 16, ... (ascending)

# Order descending
patients = self.env['hospital.patient'].search([], order='id desc')
# Returns: 71, 63, 58, ... (descending)

# Order by multiple fields
patients = self.env['hospital.patient'].search([], order='id desc, name')
# Order by id descending, then by name
```

---

## Lesson 9 Video: Search Count ORM Method

**Video ID:** 0qg-6rlo3oU  
**Title:** Odoo Search Count ORM Method || Odoo ORM documentation

### Key Points:

#### 1. Search Count Basics
```python
# Count all records
count = self.env['hospital.patient'].search_count([])
# Returns: 14 (total records)

# Count with domain
female_count = self.env['hospital.patient'].search_count([('gender', '=', 'female')])
# Returns: 12

male_count = self.env['hospital.patient'].search_count([('gender', '=', 'male')])
# Returns: 2
```

#### 2. Multiple Conditions
```python
# AND condition
count = self.env['hospital.patient'].search_count([
    ('gender', '=', 'female'),
    ('gender', '=', 'male')
])
# Returns: 0 (no patient can be both)

# OR condition
count = self.env['hospital.patient'].search_count([
    '|',
    ('gender', '=', 'female'),
    ('gender', '=', 'male')
])
# Returns: 14 (all patients)
```

#### 3. Alternative: search() with count=True
```python
# Using search with count parameter
count = self.env['hospital.patient'].search([], count=True)
# Same result as search_count()
```

---

## Lesson 10 Video: Get Metadata

**Video ID:** XBj4GgYUSGA  
**Title:** Odoo Get Metadata || Odoo ORM Methods

### Key Points:

#### 1. Get Metadata Method
```python
# Get metadata for a record
record = self.env['hospital.patient.tag'].browse(99)
metadata = record.get_metadata()
# Returns list with dictionary containing:
# - id: record ID
# - create_uid: creator user ID
# - create_date: creation date
# - write_uid: last modifier user ID
# - write_date: last modification date
# - xml_id: external ID
# - noupdate: noupdate attribute
```

#### 2. Accessing Metadata Values
```python
# Get full metadata
metadata = record.get_metadata()
# Returns: [{'id': 99, 'create_uid': 1, ...}]

# Get specific value
metadata_dict = record.get_metadata()[0]
xml_id = metadata_dict.get('xml_id')
# Returns: 'om_hospital.patient_tag_mrs'

# Get other values
record_id = metadata_dict.get('id')
create_date = metadata_dict.get('create_date')
```

#### 3. Use Cases
- Get external ID (XML ID) of a record
- Check who created/modified a record
- Get creation/modification dates
- Check noupdate attribute

---

## Lesson 11 Video: Fields Get

**Video ID:** h_6cBqeEkGQ  
**Title:** Odoo Fields Get || Odoo ORM Method

### Key Points:

#### 1. Fields Get Method
```python
# Get all fields
model = self.env['hospital.patient']
all_fields = model.fields_get()
# Returns dictionary with all fields and their attributes

# Get specific fields
fields = model.fields_get(['name', 'gender'])
# Returns only name and gender fields

# Get specific attributes
fields = model.fields_get(['name', 'gender'], ['type', 'string'])
# Returns only type and string attributes
```

#### 2. Field Attributes Returned
- `type`: Field type (char, integer, many2one, etc.)
- `string`: Field label
- `required`: Is field required
- `readonly`: Is field readonly
- `store`: Is field stored
- `searchable`: Is field searchable
- `sortable`: Is field sortable
- And more...

#### 3. Use Cases
- Get field information programmatically
- Check field types and attributes
- Build dynamic forms
- Validate field configurations

---

## Summary

### Search Method (Lesson 8):
- Search records with domains
- Use limit and order parameters
- Combine AND/OR conditions
- Essential for data retrieval

### Search Count (Lesson 9):
- Count records matching domain
- More efficient than len(search())
- Use for statistics and counts
- Supports same domain syntax as search()

### Get Metadata (Lesson 10):
- Get record metadata (ID, dates, users, XML ID)
- Useful for tracking and external IDs
- Access creation/modification info
- Check noupdate attribute

### Fields Get (Lesson 11):
- Get field information
- Check field types and attributes
- Useful for dynamic operations
- Programmatic field inspection

---

**Note:** These notes are extracted from actual video transcripts. The videos provide practical examples and real-world usage patterns.

