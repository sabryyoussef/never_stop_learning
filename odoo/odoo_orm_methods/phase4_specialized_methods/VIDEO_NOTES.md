# Phase 4 Video Notes - Extracted from Transcripts

This file contains key points extracted directly from the YouTube video transcripts.

---

## Lesson 12 Video: Name Create Function

**Video ID:** 9rHKtoKz_yw  
**Title:** Name Create Function In Odoo || Odoo ORM Method

### Key Points:

#### 1. Name Create Function Purpose
- Creates records from just a name (for many2one/many2many fields)
- Used when model doesn't have `rec_name` or `name` field
- Allows quick creation from UI autocomplete

#### 2. When to Use name_create()
```python
# When model has no rec_name and no 'name' field
# Odoo doesn't know where to pass the value
# Define name_create() to handle it

@api.model
def name_create(self, name):
    # name parameter contains the entered value
    return self.create({
        'operation_name': name  # Pass to custom field
    }).name_get()[0]
```

#### 3. Example Implementation
```python
# In hospital.operation model
@api.model
def name_create(self, name):
    print(f"Entered value: {name}")
    return self.create({
        'operation_name': name
    }).name_get()[0]
```

#### 4. Use Cases
- Many2one fields with create option
- Many2many fields with create option
- Models without standard 'name' field
- Custom field assignment

---

## Lesson 13 Video: Name Get Function

**Video ID:** S5FWeUTtmmE  
**Title:** Name Get Function In Odoo || Odoo Name Get Method

### Key Points:

#### 1. Name Get Function Purpose
- Returns display name for records
- Used in many2one fields, dropdowns, etc.
- Can show multiple field values

#### 2. Default Behavior
```python
# Default name_get() returns rec_name
def name_get(self):
    return [(record.id, record.rec_name) for record in self]
```

#### 3. Custom name_get()
```python
# Show reference + name
@api.depends('reference', 'name')
def name_get(self):
    result = []
    for record in self:
        name = f"[{record.reference}] {record.name}"
        result.append((record.id, name))
    return result

# Simplified version
@api.depends('reference', 'name')
def name_get(self):
    return [(record.id, f"[{record.reference}] {record.name}") for record in self]
```

#### 4. Formatting Options
```python
# With brackets
name = f"[{record.reference}] {record.name}"
# Result: "[REF001] Patient Name"

# With space
name = f"{record.reference} {record.name}"
# Result: "REF001 Patient Name"
```

---

## Lesson 14 Video: Default Get Function

**Video ID:** mr6ZbUcOG_U  
**Title:** Default Get Function In Odoo || Odoo Default Get Method

### Key Points:

#### 1. Default Get Function Purpose
- Provides default values for fields
- Called when form is opened
- Can set dynamic defaults

#### 2. Implementation
```python
# Override default_get() method
@api.model
def default_get(self, fields):
    res = super().default_get(fields)
    # fields parameter contains list of field names
    # Modify res dictionary to set defaults
    res['date_cancel'] = fields.Datetime.today()
    return res
```

#### 3. Important Notes
- Must be placed **before field definitions**
- Must call `super()` first
- Must return a dictionary
- `fields` parameter contains field names to get defaults for

#### 4. Example
```python
# In wizard model
@api.model
def default_get(self, fields):
    res = super().default_get(fields)
    res['reason'] = 'Odoo Mates'  # Set default reason
    res['date_cancel'] = fields.Datetime.today()  # Set today's date
    return res
```

#### 5. Use Cases
- Set default values dynamically
- Set values based on context
- Set computed defaults
- Override field defaults

---

## Lesson 15 Video: Read Group Method

**Video ID:** jdDyLy2nttI  
**Title:** Read Group Method In Odoo || Odoo Read Group Method

### Key Points:

#### 1. Read Group Method Purpose
- Groups records and computes aggregations
- Similar to SQL GROUP BY
- Used for reports and statistics

#### 2. Basic Syntax
```python
result = self.env['model'].read_group(
    domain,      # Search domain
    fields,      # Fields to aggregate
    groupby      # Fields to group by
)
```

#### 3. Computing Appointment Count
```python
def _compute_appointment_count(self):
    # Initialize all to zero
    for record in self:
        record.appointment_count = 0
    
    # Group appointments by patient
    appointment_group = self.env['hospital.appointment'].read_group(
        [('state', '=', 'done')],  # Domain: only done appointments
        ['patient_id'],             # Fields
        ['patient_id']              # Group by patient
    )
    
    # Assign counts
    for appointment in appointment_group:
        patient_id = appointment['patient_id'][0]  # Get ID from tuple
        patient = self.browse(patient_id)
        if patient.exists():
            patient.appointment_count = appointment['patient_id_count']
            self -= patient  # Remove from self
    
    # Set zero for remaining (patients without appointments)
    self.appointment_count = 0
```

#### 4. Read Group Result Format
```python
# Result format:
[
    {
        'patient_id': (id, name),  # Tuple
        'patient_id_count': count   # Aggregation
    },
    ...
]

# Access values:
patient_id = appointment['patient_id'][0]  # Get ID
count = appointment['patient_id_count']    # Get count
```

#### 5. Domain in read_group()
```python
# Filter before grouping
appointment_group = self.env['hospital.appointment'].read_group(
    [('state', '=', 'done')],  # Only done appointments
    ['patient_id'],
    ['patient_id']
)
```

#### 6. Handling Missing Records
```python
# Records not in group result need default value
# Subtract processed records from self
self -= patient

# Set default for remaining
self.appointment_count = 0
```

---

## Summary

### Name Create (Lesson 12):
- Creates records from name only
- Used when no rec_name or name field
- Handles many2one/many2many create option
- Passes value to custom field

### Name Get (Lesson 13):
- Returns display name for records
- Can show multiple fields
- Used in dropdowns and many2one fields
- Customize format as needed

### Default Get (Lesson 14):
- Provides default values for fields
- Called when form opens
- Must be before field definitions
- Can set dynamic defaults

### Read Group (Lesson 15):
- Groups records and aggregates
- Used for statistics and reports
- More efficient than manual grouping
- Handles missing records properly

---

**Note:** These notes are extracted from actual video transcripts. The videos provide detailed implementation examples and real-world use cases.

