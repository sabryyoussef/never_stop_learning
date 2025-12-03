# Phase 1 Video Notes - Extracted from Transcripts

This file contains key points extracted directly from the YouTube video transcripts.

---

## Lesson 2 Video: Recordset Operations (Filtered, Mapped, Sorted)

**Video ID:** STKq2owQGII  
**Title:** Odoo ORM: RecordSet Operations - Sorted, Filtered & Mapped

### Key Points:

#### 1. Mapped Operation
- **Purpose:** Extract field values from recordsets into a list
- **Syntax:** `records.mapped('field_name')`
- **Use Cases:**
  - Get list of partner names: `partners.mapped('name')`
  - Get list of phone numbers: `partners.mapped('phone')`
  - Get list of emails: `partners.mapped('email')`
  - Get related records: `records.mapped('partner_id')`

**Example from video:**
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
```

#### 2. Sorted Operation
- **Purpose:** Sort recordsets based on a field or custom function
- **Syntax:** `records.sorted(key, reverse=False)`
- **Parameters:**
  - `key`: Field name (string) or lambda function
  - `reverse`: True for descending, False for ascending (default)

**Example from video:**
```python
# Sort partners by create date (ascending)
sorted_partners = partners.sorted(lambda r: r.create_date)
# Returns partners in order: ID 1, 14, 16, ... (oldest first)

# Sort partners by write date (descending)
sorted_partners = partners.sorted(lambda r: r.write_date, reverse=True)
# Returns partners with most recently updated first

# Sort by field name
sorted_partners = partners.sorted('name')
```

**Key Points:**
- Use lambda function: `lambda r: r.field_name`
- Pass `reverse=True` for descending order
- Default is ascending order
- Can sort by any field (create_date, write_date, name, etc.)

#### 3. Filtered Operation
- **Purpose:** Filter recordsets based on conditions
- **Syntax:** `records.filtered(condition)`
- **Conditions:**
  - Field name (string): `records.filtered('active')` - filters where active=True
  - Lambda function: `records.filtered(lambda r: r.amount > 100)`

**Example from video:**
```python
# Filter only customers
customers = partners.filtered('customer')
# Returns only partners where customer=True

# Filter non-customers
non_customers = partners.filtered(lambda r: not r.customer)
# Returns partners where customer=False or not set

# Filter with custom condition
high_value = partners.filtered(lambda r: r.amount > 1000)
```

**Key Points:**
- `filtered('field')` filters where field=True
- Use `lambda` for complex conditions
- Use `not` to negate conditions
- Returns new recordset (doesn't modify original)

### Practical Implementation from Video:

```python
def test_recordset_operations(self):
    # Get all partners
    partners = self.env['res.partner'].search([])
    
    # Mapped: Get list of names
    partner_names = partners.mapped('name')
    print("Partner Names:", partner_names)
    
    # Sorted: Sort by create date
    sorted_partners = partners.sorted(lambda r: r.create_date)
    print("Sorted Partners (by create_date):", sorted_partners)
    
    # Filtered: Filter only customers
    customers = partners.filtered('customer')
    print("Customers:", customers)
    
    # Combined operations
    customer_names = partners.filtered('customer').mapped('name')
    print("Customer Names:", customer_names)
```

### Important Notes:
- All three operations return **new recordsets** (immutable)
- Operations can be **chained**: `records.filtered('active').sorted('name').mapped('email')`
- `mapped()` returns a **list**, not a recordset
- `sorted()` and `filtered()` return **recordsets**
- These operations are used extensively in Odoo codebase

---

## Lesson 4 Video: Create ORM Method

**Video ID:** n37RL_j4K3A  
**Title:** Odoo Create ORM Method | Odoo ORM Methods

### Key Points:

#### 1. Create Method Basics
- **Purpose:** Create new records in the database programmatically
- **Syntax:** `self.env['model.name'].create(vals)`
- **Returns:** Created record(s) as recordset

**Example from video:**
```python
# Create a single record
partner = self.env['res.partner'].create({
    'name': 'ORM Methods'
})
# Returns: res.partner(71,)
# System creates record with ID 71
```

#### 2. Creating Records with Multiple Fields
```python
# Create with multiple fields
partner = self.env['res.partner'].create({
    'name': 'Odoo Methods',
    'email': 'odoomates@gmail.com',
    'phone': '1234567890'
})
# Returns: res.partner(72,)
```

#### 3. Using Variables for Values
```python
# Define values as variable
vals = {
    'name': 'Odoo Methods',
    'email': 'odoomates@gmail.com',
    'phone': '1234567890'
}

# Create record
partner = self.env['res.partner'].create(vals)
```

#### 4. Field Names
- Use **technical field names** (not display names)
- Check field technical name by hovering over field in UI
- Common fields:
  - `name` - Name field
  - `email` - Email field
  - `phone` - Phone field
  - `customer` - Customer boolean
  - `supplier` - Supplier boolean

#### 5. Using Playground (Odoo 15)
- Access via Technical menu → Playground
- Write code directly in browser
- Click "Execute" to run
- Results shown immediately
- Great for testing ORM methods

### Practical Example from Video:

```python
# In Odoo 15 Playground
# Create a new patient
self.env['hospital.patient'].create({
    'name': 'ORM Methods'
})

# Result: hospital.patient(71,)
# New record created with ID 71

# Create with more fields
self.env['hospital.patient'].create({
    'name': 'Odoo Methods',
    'email': 'odoomates@gmail.com',
    'phone': '1234567890'
})

# Result: hospital.patient(72,)
# New record created with ID 72
```

### Important Notes:
- **Field validation** happens automatically
- **Required fields** must be provided
- **Default values** are applied if not specified
- **Character fields** accept any string (even without quotes in some cases)
- **Returns recordset** with created record(s)
- **ID is assigned** automatically by database

### Best Practices:
1. Use **variables** for complex value dictionaries
2. **Validate data** before creating (or handle exceptions)
3. Use **bulk create** for multiple records: `create([vals1, vals2, ...])`
4. Check **field technical names** in debug mode
5. Use **context** for default values: `with_context(default_field='value')`

---

## Summary

### Recordset Operations (Lesson 2):
- **mapped()**: Extract field values into list
- **sorted()**: Sort recordsets by field or function
- **filtered()**: Filter recordsets by condition
- All return new recordsets (except mapped returns list)
- Can be chained together

### Create Method (Lesson 4):
- **create()**: Create new records programmatically
- Pass values as dictionary
- Returns created record(s)
- Can create single or multiple records
- Field validation is automatic

---

**Note:** These notes are extracted from actual video transcripts. Some videos may cover topics slightly different from the planned lesson titles, but the content is valuable for learning Odoo ORM methods.

