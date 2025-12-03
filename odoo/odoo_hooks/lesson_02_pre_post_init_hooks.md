# Lesson 2: Pre-Init and Post-Init Hooks

**Video:** https://www.youtube.com/watch?v=SWJdNdQnQVQ  
**Status:** ⬜ Not Started  
**Date Completed:**

---

## 📚 Learning Objectives

- Understand the difference between pre_init_hook and post_init_hook
- Learn when to use each hook type
- Master database cursor operations in pre_init_hook
- Use Odoo ORM in post_init_hook
- Implement error handling and logging
- Follow best practices for hook implementation

---

## 📝 Key Concepts

### pre_init_hook

**Purpose:** Prepare the database BEFORE Odoo creates model tables and loads data.

**Characteristics:**
- Runs before any module tables are created
- Only has access to database cursor (`cr`)
- Cannot use Odoo ORM
- Must use raw SQL
- Runs only on first installation

**Common Use Cases:**
- Create custom database tables
- Create database functions or triggers
- Prepare database schema
- Create indexes for performance
- Migrate data from external sources

### post_init_hook

**Purpose:** Initialize data AFTER module installation is complete.

**Characteristics:**
- Runs after all tables are created
- Has access to cursor (`cr`) and registry
- Can use Odoo ORM
- Can access all models
- Runs on installation and updates

**Common Use Cases:**
- Create default records
- Initialize configuration
- Set up relationships between records
- Import initial data
- Configure external integrations

---

## 💻 Code Examples

### Example 1: Basic pre_init_hook

```python
import logging

_logger = logging.getLogger(__name__)

def pre_init_hook(cr):
    """
    Create custom database table before module installation.
    """
    _logger.info("Creating custom database objects")
    
    # Create custom table
    cr.execute("""
        CREATE TABLE IF NOT EXISTS custom_log (
            id SERIAL PRIMARY KEY,
            user_id INTEGER,
            action VARCHAR(100),
            timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            details TEXT
        )
    """)
    
    # Create index for performance
    cr.execute("""
        CREATE INDEX IF NOT EXISTS idx_custom_log_user 
        ON custom_log(user_id)
    """)
    
    # Create index on timestamp
    cr.execute("""
        CREATE INDEX IF NOT EXISTS idx_custom_log_timestamp 
        ON custom_log(timestamp DESC)
    """)
    
    _logger.info("Custom database objects created successfully")
```

### Example 2: Basic post_init_hook

```python
from odoo import api, SUPERUSER_ID
import logging

_logger = logging.getLogger(__name__)

def post_init_hook(cr, registry):
    """
    Initialize default configuration and data.
    """
    _logger.info("Initializing module data")
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Create default configuration
    env['ir.config_parameter'].set_param(
        'my_module.default_value', 
        'default'
    )
    
    # Create default records
    default_category = env['my.category'].create({
        'name': 'Default Category',
        'code': 'DEFAULT',
        'active': True,
    })
    
    _logger.info(f"Created default category: {default_category.name}")
```

### Example 3: Advanced pre_init_hook with Error Handling

```python
def pre_init_hook(cr):
    """
    Advanced database preparation with error handling.
    """
    _logger.info("Starting database preparation")
    
    try:
        # Check if table already exists
        cr.execute("""
            SELECT EXISTS (
                SELECT FROM information_schema.tables 
                WHERE table_name = 'custom_data'
            )
        """)
        table_exists = cr.fetchone()[0]
        
        if not table_exists:
            _logger.info("Creating custom_data table")
            cr.execute("""
                CREATE TABLE custom_data (
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(255) NOT NULL,
                    value JSONB,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)
            
            # Create indexes
            cr.execute("""
                CREATE INDEX idx_custom_data_name ON custom_data(name);
                CREATE INDEX idx_custom_data_value ON custom_data USING GIN(value);
            """)
            
            _logger.info("Table created successfully")
        else:
            _logger.info("Table already exists, skipping creation")
            
    except Exception as e:
        _logger.error(f"Error in pre_init_hook: {e}")
        raise
```

### Example 4: Advanced post_init_hook with Data Creation

```python
def post_init_hook(cr, registry):
    """
    Create comprehensive initial data.
    """
    _logger.info("Creating initial data")
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    try:
        # Create categories
        categories = [
            {'name': 'Category A', 'code': 'CAT_A', 'sequence': 1},
            {'name': 'Category B', 'code': 'CAT_B', 'sequence': 2},
            {'name': 'Category C', 'code': 'CAT_C', 'sequence': 3},
        ]
        
        for cat_data in categories:
            # Check if already exists
            existing = env['my.category'].search([
                ('code', '=', cat_data['code'])
            ])
            
            if not existing:
                category = env['my.category'].create(cat_data)
                _logger.info(f"Created category: {category.name}")
            else:
                _logger.info(f"Category {cat_data['code']} already exists")
        
        # Set system parameters
        params = {
            'my_module.api_endpoint': 'https://api.example.com',
            'my_module.timeout': '30',
            'my_module.retry_count': '3',
        }
        
        IrConfigParameter = env['ir.config_parameter']
        for key, value in params.items():
            IrConfigParameter.set_param(key, value)
            _logger.info(f"Set parameter: {key} = {value}")
        
        # Create default user groups
        group_vals = {
            'name': 'My Module User',
            'category_id': env.ref('base.module_category_custom').id,
        }
        
        existing_group = env['res.groups'].search([
            ('name', '=', group_vals['name'])
        ])
        
        if not existing_group:
            group = env['res.groups'].create(group_vals)
            _logger.info(f"Created user group: {group.name}")
        
        _logger.info("Initial data created successfully")
        
    except Exception as e:
        _logger.error(f"Error creating initial data: {e}")
        raise
```

### Example 5: Data Migration in pre_init_hook

```python
def pre_init_hook(cr):
    """
    Migrate data from old table structure.
    """
    _logger.info("Checking for data migration")
    
    # Check if old table exists
    cr.execute("""
        SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_name = 'old_custom_data'
        )
    """)
    old_table_exists = cr.fetchone()[0]
    
    if old_table_exists:
        _logger.info("Old table found, migrating data")
        
        # Create new table
        cr.execute("""
            CREATE TABLE IF NOT EXISTS new_custom_data (
                id SERIAL PRIMARY KEY,
                name VARCHAR(255),
                new_field VARCHAR(100),
                migrated_value TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        """)
        
        # Migrate data
        cr.execute("""
            INSERT INTO new_custom_data (name, new_field, migrated_value)
            SELECT 
                old_name,
                'default',
                old_value::TEXT
            FROM old_custom_data
            WHERE old_name IS NOT NULL
        """)
        
        migrated_count = cr.rowcount
        _logger.info(f"Migrated {migrated_count} records")
        
        # Optionally rename old table
        cr.execute("""
            ALTER TABLE old_custom_data 
            RENAME TO old_custom_data_backup
        """)
        
        _logger.info("Data migration completed")
```

---

## 🎯 Practice Exercises

### Exercise 1: Create Module with pre_init_hook

Create a module that uses pre_init_hook to:

- [ ] Create a custom table named `module_audit_log`
- [ ] Add columns: id, user_id, action, timestamp, details
- [ ] Create indexes on user_id and timestamp
- [ ] Add logging for each step
- [ ] Test by installing the module

**Code Template:**
```python
def pre_init_hook(cr):
    # Your code here
    pass
```

### Exercise 2: Implement post_init_hook for Data Initialization

Create a post_init_hook that:

- [ ] Creates 5 default categories
- [ ] Sets 3 system parameters
- [ ] Creates a default configuration record
- [ ] Logs all operations
- [ ] Handles duplicate records gracefully

**Code Template:**
```python
def post_init_hook(cr, registry):
    # Your code here
    pass
```

### Exercise 3: Test Hook Execution

- [ ] Install your module
- [ ] Check Odoo logs for hook messages
- [ ] Verify database table was created
- [ ] Verify default records exist
- [ ] Uninstall and reinstall to test again

---

## 📌 Important Notes

### Function Signatures

```python
# pre_init_hook - Only cursor available
def pre_init_hook(cr):
    """
    Args:
        cr: psycopg2 cursor object
    """
    pass

# post_init_hook - Cursor and registry available
def post_init_hook(cr, registry):
    """
    Args:
        cr: psycopg2 cursor object
        registry: Odoo registry object
    """
    pass
```

### Database Cursor Operations

```python
# Execute SQL
cr.execute("SELECT * FROM my_table")

# Fetch results
result = cr.fetchone()  # Single row
results = cr.fetchall()  # All rows

# Get affected row count
cr.execute("UPDATE my_table SET field = 'value'")
affected = cr.rowcount

# Commit (usually not needed in hooks)
# cr.commit()  # Odoo handles commits
```

### Using Environment in post_init_hook

```python
from odoo import api, SUPERUSER_ID

def post_init_hook(cr, registry):
    # Create environment
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Access models
    partners = env['res.partner'].search([])
    
    # Create records
    new_record = env['my.model'].create({'name': 'Test'})
    
    # Update records
    partners.write({'custom_field': 'value'})
```

### Error Handling Best Practices

```python
def post_init_hook(cr, registry):
    _logger.info("Starting initialization")
    
    try:
        env = api.Environment(cr, SUPERUSER_ID, {})
        
        # Your code here
        
        _logger.info("Initialization completed successfully")
        
    except Exception as e:
        _logger.error(f"Initialization failed: {e}")
        _logger.exception("Full traceback:")
        raise  # Re-raise to fail installation
```

---

## 🔗 Related Topics

- Database Cursors and Transactions
- Odoo ORM Basics
- SQL in Odoo
- Logging in Python
- Error Handling

---

## ❓ Questions & Answers

**Q: Can I use self.env in pre_init_hook?**  
A: No, `self` doesn't exist in hooks. Use `cr` for raw SQL only.

**Q: Should I commit transactions in hooks?**  
A: No, Odoo handles transaction management. Let it commit automatically.

**Q: Can post_init_hook access models from other modules?**  
A: Yes, if those modules are in the `depends` list in `__manifest__.py`.

**Q: What happens if a hook raises an exception?**  
A: The installation/update fails and rolls back all changes.

**Q: Can I call one hook from another?**  
A: Not recommended. Keep hooks independent and focused.

---

## 📚 Additional Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Odoo ORM Documentation](https://www.odoo.com/documentation/17.0/developer/reference/backend/orm.html)
- [Python Logging](https://docs.python.org/3/library/logging.html)

---

## 📝 Video Notes

**Note:** Watch the video and add your notes here:

### Key Points from Video:
- 
- 
- 

### Code Examples Shown:
- 
- 
- 

### Important Takeaways:
- 
- 
- 

---

**Previous Lesson:** [Lesson 1: Introduction to Odoo Hooks](./lesson_01_introduction.md)  
**Next Lesson:** [Lesson 3: Update Hooks](./lesson_03_update_hooks.md)

