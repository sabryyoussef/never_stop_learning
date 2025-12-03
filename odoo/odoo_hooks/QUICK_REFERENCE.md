# Odoo Hooks - Quick Reference Guide

Quick reference for Odoo Hooks implementation and best practices.

---

## 📋 Hook Types Overview

| Hook Type | Execution Time | Use Case | Parameters |
|-----------|----------------|----------|------------|
| `pre_init_hook` | Before installation | Database preparation | `cr` |
| `post_init_hook` | After installation | Initial data setup | `cr, registry` |
| `post_load` | After module loading | Runtime initialization | None |
| `uninstall_hook` | Before uninstallation | Cleanup operations | `cr, registry` |

---

## 🔧 Basic Implementation

### 1. Declare Hooks in `__manifest__.py`

```python
{
    'name': 'My Module',
    'version': '1.0',
    'category': 'Custom',
    'depends': ['base'],
    'data': [
        # ... data files ...
    ],
    'pre_init_hook': 'pre_init_hook',
    'post_init_hook': 'post_init_hook',
    'uninstall_hook': 'uninstall_hook',
    'installable': True,
}
```

### 2. Create `hooks.py` File

```python
import logging
from odoo import api, SUPERUSER_ID

_logger = logging.getLogger(__name__)

def pre_init_hook(cr):
    """
    Run before module installation.
    Use for database schema preparation.
    """
    _logger.info("Running pre_init_hook for my_module")
    # Your code here

def post_init_hook(cr, registry):
    """
    Run after module installation.
    Use for initial data creation.
    """
    _logger.info("Running post_init_hook for my_module")
    env = api.Environment(cr, SUPERUSER_ID, {})
    # Your code here

def uninstall_hook(cr, registry):
    """
    Run before module uninstallation.
    Use for cleanup operations.
    """
    _logger.info("Running uninstall_hook for my_module")
    env = api.Environment(cr, SUPERUSER_ID, {})
    # Your code here
```

### 3. Import Hooks in `__init__.py`

```python
from . import models
from .hooks import pre_init_hook, post_init_hook, uninstall_hook
```

---

## 💻 Common Patterns

### Pattern 1: Database Schema Preparation

```python
def pre_init_hook(cr):
    """Create custom database objects"""
    _logger.info("Creating custom database objects")
    
    # Create custom table
    cr.execute("""
        CREATE TABLE IF NOT EXISTS custom_data (
            id SERIAL PRIMARY KEY,
            name VARCHAR(255),
            value TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
    
    # Create index
    cr.execute("""
        CREATE INDEX IF NOT EXISTS idx_custom_data_name 
        ON custom_data(name)
    """)
```

### Pattern 2: Initial Data Creation

```python
def post_init_hook(cr, registry):
    """Create initial configuration data"""
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Create default records
    env['my.model'].create({
        'name': 'Default Configuration',
        'value': 'default_value',
        'active': True,
    })
    
    # Update existing records
    records = env['res.partner'].search([('is_company', '=', True)])
    records.write({'custom_field': 'default'})
```

### Pattern 3: Data Migration

```python
def post_init_hook(cr, registry):
    """Migrate data from old structure"""
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Get old data
    cr.execute("SELECT id, old_field FROM old_table")
    old_data = cr.fetchall()
    
    # Transform and create new records
    for old_id, old_value in old_data:
        new_value = transform_value(old_value)
        env['new.model'].create({
            'name': f'Migrated_{old_id}',
            'value': new_value,
        })
```

### Pattern 4: Cleanup Operations

```python
def uninstall_hook(cr, registry):
    """Clean up custom data and objects"""
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Delete custom records
    custom_records = env['my.model'].search([])
    custom_records.unlink()
    
    # Drop custom tables
    cr.execute("DROP TABLE IF EXISTS custom_data CASCADE")
    
    # Remove custom data from other models
    cr.execute("""
        UPDATE res_partner 
        SET custom_field = NULL 
        WHERE custom_field IS NOT NULL
    """)
```

### Pattern 5: Version-Specific Updates

```python
def post_init_hook(cr, registry):
    """Handle version-specific updates"""
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Check if this is an update
    cr.execute("""
        SELECT latest_version 
        FROM ir_module_module 
        WHERE name = 'my_module'
    """)
    result = cr.fetchone()
    
    if result:
        old_version = result[0]
        if old_version < '2.0':
            # Perform migration for versions < 2.0
            migrate_to_v2(env)
```

---

## 🎯 Best Practices

### DO ✅

```python
# Use logging
_logger.info("Starting hook execution")

# Handle errors gracefully
try:
    # Hook code
    pass
except Exception as e:
    _logger.error(f"Hook failed: {e}")
    raise

# Check before creating
if not env['my.model'].search([('name', '=', 'default')]):
    env['my.model'].create({'name': 'default'})

# Use transactions properly
cr.execute("BEGIN")
try:
    # Operations
    cr.execute("COMMIT")
except:
    cr.execute("ROLLBACK")
    raise

# Document your hooks
def post_init_hook(cr, registry):
    """
    Initialize default configuration.
    
    Creates:
    - Default company settings
    - Initial user groups
    - System parameters
    """
    pass
```

### DON'T ❌

```python
# Don't ignore errors
def post_init_hook(cr, registry):
    try:
        # code
        pass
    except:
        pass  # ❌ Silent failure

# Don't perform long operations
def post_init_hook(cr, registry):
    # ❌ This will block installation
    for i in range(1000000):
        env['my.model'].create({'name': f'Record {i}'})

# Don't hardcode values
def post_init_hook(cr, registry):
    # ❌ Hardcoded database name
    cr.execute("USE my_database")

# Don't modify core tables directly
def pre_init_hook(cr):
    # ❌ Modifying core Odoo table
    cr.execute("ALTER TABLE res_users ADD COLUMN custom_field TEXT")
```

---

## 🔍 Common Use Cases

### 1. Create System Parameters

```python
def post_init_hook(cr, registry):
    env = api.Environment(cr, SUPERUSER_ID, {})
    IrConfigParameter = env['ir.config_parameter']
    
    IrConfigParameter.set_param('my_module.api_key', 'default_key')
    IrConfigParameter.set_param('my_module.api_url', 'https://api.example.com')
```

### 2. Create Default Records

```python
def post_init_hook(cr, registry):
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Create default categories
    categories = ['Category A', 'Category B', 'Category C']
    for cat_name in categories:
        env['my.category'].create({'name': cat_name})
```

### 3. Update Existing Data

```python
def post_init_hook(cr, registry):
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Update all partners
    partners = env['res.partner'].search([])
    partners.write({'custom_field': 'initialized'})
```

### 4. External System Integration

```python
def post_init_hook(cr, registry):
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Initialize external connection
    try:
        external_api = ExternalAPI()
        external_api.register_webhook(env['ir.config_parameter'].get_param('base.url'))
        _logger.info("External system initialized successfully")
    except Exception as e:
        _logger.warning(f"Could not initialize external system: {e}")
```

### 5. Database Index Creation

```python
def pre_init_hook(cr):
    """Create performance indexes"""
    indexes = [
        ("idx_partner_ref", "res_partner", "ref"),
        ("idx_sale_order_date", "sale_order", "date_order"),
    ]
    
    for idx_name, table, column in indexes:
        cr.execute(f"""
            CREATE INDEX IF NOT EXISTS {idx_name} 
            ON {table}({column})
        """)
```

---

## 🧪 Testing Hooks

### Unit Test Example

```python
from odoo.tests import TransactionCase

class TestModuleHooks(TransactionCase):
    
    def test_post_init_hook_creates_default_data(self):
        """Test that post_init_hook creates expected records"""
        # Count records before
        count_before = self.env['my.model'].search_count([])
        
        # Run hook
        from ..hooks import post_init_hook
        post_init_hook(self.cr, self.registry)
        
        # Verify records created
        count_after = self.env['my.model'].search_count([])
        self.assertGreater(count_after, count_before)
    
    def test_uninstall_hook_cleanup(self):
        """Test that uninstall_hook removes custom data"""
        # Create test data
        self.env['my.model'].create({'name': 'Test'})
        
        # Run uninstall hook
        from ..hooks import uninstall_hook
        uninstall_hook(self.cr, self.registry)
        
        # Verify cleanup
        count = self.env['my.model'].search_count([])
        self.assertEqual(count, 0)
```

---

## 🐛 Debugging Tips

### 1. Enable Debug Logging

```python
import logging
_logger = logging.getLogger(__name__)
_logger.setLevel(logging.DEBUG)

def post_init_hook(cr, registry):
    _logger.debug("Hook started")
    _logger.debug(f"Registry: {registry}")
    _logger.debug(f"Database: {cr.dbname}")
    # ... hook code ...
    _logger.debug("Hook completed")
```

### 2. Check Hook Execution

```bash
# Check Odoo logs
tail -f /var/log/odoo/odoo.log | grep "hook"

# Install module with verbose logging
odoo-bin -d mydb -i my_module --log-level=debug
```

### 3. Test Hooks Manually

```python
# In Odoo shell
from odoo import api, SUPERUSER_ID
from odoo.addons.my_module.hooks import post_init_hook

env = api.Environment(cr, SUPERUSER_ID, {})
post_init_hook(cr, env.registry)
```

---

## 📚 Function Signatures

### pre_init_hook

```python
def pre_init_hook(cr):
    """
    Args:
        cr: Database cursor
    
    Returns:
        None
    
    Raises:
        Exception: If initialization fails
    """
    pass
```

### post_init_hook

```python
def post_init_hook(cr, registry):
    """
    Args:
        cr: Database cursor
        registry: Odoo registry object
    
    Returns:
        None
    
    Raises:
        Exception: If initialization fails
    """
    pass
```

### uninstall_hook

```python
def uninstall_hook(cr, registry):
    """
    Args:
        cr: Database cursor
        registry: Odoo registry object
    
    Returns:
        None
    
    Raises:
        Exception: If cleanup fails
    """
    pass
```

---

## 🔗 Quick Links

- [Odoo Hooks Documentation](https://www.odoo.com/documentation/17.0/developer/reference/backend/hooks.html)
- [Module Manifest Reference](https://www.odoo.com/documentation/17.0/developer/reference/backend/module.html)
- [OCA Guidelines](https://github.com/OCA/odoo-community.org)

---

## 📝 Cheat Sheet

```python
# Minimal hook implementation
from odoo import api, SUPERUSER_ID
import logging

_logger = logging.getLogger(__name__)

def post_init_hook(cr, registry):
    env = api.Environment(cr, SUPERUSER_ID, {})
    _logger.info("Hook executed")
```

```python
# __manifest__.py
{
    'post_init_hook': 'post_init_hook',
}
```

```python
# __init__.py
from .hooks import post_init_hook
```

---

**Last Updated:** 2025-12-02

