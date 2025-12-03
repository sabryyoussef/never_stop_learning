# Lesson 3: Update Hooks

**Video:** https://www.youtube.com/watch?v=3xOfXfyKXYU  
**Status:** ⬜ Not Started  
**Date Completed:**

---

## 📚 Learning Objectives

- Understand how module updates work in Odoo
- Learn to handle data migration during updates
- Implement version-specific update logic
- Manage backward compatibility
- Test update scenarios effectively

---

## 📝 Key Concepts

### Module Updates in Odoo

When you update a module (increase version number and run `-u module_name`):
1. Odoo updates the database schema
2. Reloads data files (XML/CSV)
3. Executes post_init_hook (if defined)
4. Updates module version in database

### Update vs. Installation

| Aspect | Installation | Update |
|--------|--------------|--------|
| pre_init_hook | ✅ Runs | ❌ Does not run |
| post_init_hook | ✅ Runs | ✅ Runs |
| Data files | Loaded | Reloaded |
| Tables | Created | Altered if needed |

### Data Migration Strategies

1. **In-place migration:** Transform data in existing tables
2. **Table migration:** Move data to new table structure
3. **Incremental migration:** Apply changes step by step
4. **Versioned migration:** Different logic for different versions

---

## 💻 Code Examples

### Example 1: Basic Update Hook

```python
from odoo import api, SUPERUSER_ID
import logging

_logger = logging.getLogger(__name__)

def post_init_hook(cr, registry):
    """
    Handle both installation and updates.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Check if this is an update or fresh install
    cr.execute("""
        SELECT latest_version 
        FROM ir_module_module 
        WHERE name = 'my_module' AND state = 'installed'
    """)
    result = cr.fetchone()
    
    if result:
        old_version = result[0]
        _logger.info(f"Updating from version {old_version}")
        handle_update(env, old_version)
    else:
        _logger.info("Fresh installation detected")
        handle_installation(env)

def handle_installation(env):
    """Handle fresh installation."""
    _logger.info("Creating initial data")
    # Create default records
    env['my.model'].create({'name': 'Default'})

def handle_update(env, old_version):
    """Handle module update."""
    _logger.info(f"Migrating from version {old_version}")
    
    # Version-specific migrations
    if old_version < '1.1.0':
        migrate_to_1_1_0(env)
    
    if old_version < '2.0.0':
        migrate_to_2_0_0(env)
```

### Example 2: Version-Specific Migration

```python
def post_init_hook(cr, registry):
    """
    Apply version-specific migrations.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Get current installed version
    module = env['ir.module.module'].search([
        ('name', '=', 'my_module'),
        ('state', '=', 'installed')
    ])
    
    if not module:
        _logger.info("Fresh installation")
        return
    
    old_version = module.latest_version
    _logger.info(f"Migrating from {old_version} to current version")
    
    # Apply migrations in order
    migrations = [
        ('1.0.0', migrate_to_1_0_0),
        ('1.1.0', migrate_to_1_1_0),
        ('2.0.0', migrate_to_2_0_0),
    ]
    
    for version, migration_func in migrations:
        if old_version < version:
            _logger.info(f"Applying migration to {version}")
            try:
                migration_func(env)
                _logger.info(f"Migration to {version} completed")
            except Exception as e:
                _logger.error(f"Migration to {version} failed: {e}")
                raise

def migrate_to_1_1_0(env):
    """Migrate to version 1.1.0"""
    _logger.info("Adding new field values")
    records = env['my.model'].search([])
    records.write({'new_field': 'default_value'})

def migrate_to_2_0_0(env):
    """Migrate to version 2.0.0"""
    _logger.info("Restructuring data")
    # Complex migration logic
    pass
```

### Example 3: Data Structure Migration

```python
def post_init_hook(cr, registry):
    """
    Migrate from old data structure to new.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    _logger.info("Starting data structure migration")
    
    # Check if migration is needed
    cr.execute("""
        SELECT column_name 
        FROM information_schema.columns 
        WHERE table_name = 'my_model' 
        AND column_name = 'old_field'
    """)
    
    if cr.fetchone():
        _logger.info("Old structure detected, migrating...")
        
        # Get all records with old structure
        cr.execute("""
            SELECT id, old_field, old_value 
            FROM my_model 
            WHERE old_field IS NOT NULL
        """)
        
        old_records = cr.fetchall()
        _logger.info(f"Found {len(old_records)} records to migrate")
        
        # Transform and update
        for record_id, old_field, old_value in old_records:
            new_value = transform_old_value(old_value)
            
            env['my.model'].browse(record_id).write({
                'new_field': new_value,
                'migrated': True,
            })
        
        _logger.info("Data migration completed")
        
        # Optionally remove old column
        # cr.execute("ALTER TABLE my_model DROP COLUMN old_field")
    else:
        _logger.info("No migration needed")

def transform_old_value(old_value):
    """Transform old value format to new format"""
    # Transformation logic
    return f"new_{old_value}"
```

### Example 4: Incremental Field Migration

```python
def post_init_hook(cr, registry):
    """
    Migrate field values incrementally.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Find records that need migration
    records_to_migrate = env['my.model'].search([
        ('migrated', '=', False),
        ('old_status', '!=', False),
    ])
    
    total = len(records_to_migrate)
    _logger.info(f"Migrating {total} records")
    
    batch_size = 100
    for i in range(0, total, batch_size):
        batch = records_to_migrate[i:i+batch_size]
        
        for record in batch:
            try:
                # Transform old status to new status
                new_status = map_old_to_new_status(record.old_status)
                
                record.write({
                    'new_status': new_status,
                    'migrated': True,
                    'migration_date': fields.Datetime.now(),
                })
                
            except Exception as e:
                _logger.error(f"Failed to migrate record {record.id}: {e}")
        
        _logger.info(f"Migrated {min(i+batch_size, total)}/{total} records")
        
        # Commit batch
        cr.commit()
    
    _logger.info("Migration completed successfully")

def map_old_to_new_status(old_status):
    """Map old status values to new status values"""
    mapping = {
        'draft': 'new',
        'confirmed': 'in_progress',
        'done': 'completed',
        'cancelled': 'cancelled',
    }
    return mapping.get(old_status, 'new')
```

### Example 5: External Data Synchronization

```python
def post_init_hook(cr, registry):
    """
    Synchronize with external system after update.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    _logger.info("Synchronizing with external system")
    
    try:
        # Get configuration
        api_url = env['ir.config_parameter'].get_param('my_module.api_url')
        api_key = env['ir.config_parameter'].get_param('my_module.api_key')
        
        if not api_url or not api_key:
            _logger.warning("External API not configured, skipping sync")
            return
        
        # Get records that need sync
        records_to_sync = env['my.model'].search([
            ('synced', '=', False),
        ])
        
        _logger.info(f"Syncing {len(records_to_sync)} records")
        
        for record in records_to_sync:
            try:
                # Send to external API
                response = send_to_external_api(
                    api_url, 
                    api_key, 
                    record.get_sync_data()
                )
                
                if response.get('success'):
                    record.write({
                        'synced': True,
                        'external_id': response.get('id'),
                    })
                    _logger.info(f"Synced record {record.id}")
                
            except Exception as e:
                _logger.error(f"Failed to sync record {record.id}: {e}")
        
        _logger.info("External synchronization completed")
        
    except Exception as e:
        _logger.error(f"Synchronization failed: {e}")
        # Don't raise - allow module update to complete

def send_to_external_api(url, key, data):
    """Send data to external API"""
    import requests
    response = requests.post(
        url,
        headers={'Authorization': f'Bearer {key}'},
        json=data,
        timeout=30
    )
    return response.json()
```

---

## 🎯 Practice Exercises

### Exercise 1: Create Update Scenario

- [ ] Create a module with version 1.0.0
- [ ] Add some test data
- [ ] Update to version 1.1.0 with new field
- [ ] Implement migration in post_init_hook
- [ ] Test the update process

### Exercise 2: Implement Data Migration

- [ ] Create records with old data structure
- [ ] Change model structure (add/remove fields)
- [ ] Write migration code in post_init_hook
- [ ] Test migration preserves data correctly
- [ ] Verify all records migrated

### Exercise 3: Version-Specific Updates

- [ ] Create multiple version migrations
- [ ] Test updating from version 1.0 to 2.0
- [ ] Test updating from version 1.5 to 2.0
- [ ] Verify correct migrations run
- [ ] Check logs for migration messages

---

## 📌 Important Notes

### Best Practices for Updates

✅ **DO:**
- Check if migration is needed before running
- Log all migration steps
- Handle errors gracefully
- Test updates on copy of production data
- Keep migrations idempotent (safe to run multiple times)
- Commit large migrations in batches

❌ **DON'T:**
- Assume data structure
- Delete old data immediately
- Run long operations without batching
- Ignore errors
- Skip testing
- Forget to handle edge cases

### Testing Updates

```bash
# Backup database
pg_dump mydb > backup.sql

# Test update
odoo-bin -d mydb -u my_module --log-level=debug

# If issues, restore
psql mydb < backup.sql
```

### Idempotent Migrations

```python
# Good - Can run multiple times safely
def migrate_data(env):
    records = env['my.model'].search([('migrated', '=', False)])
    for record in records:
        record.write({'new_field': 'value', 'migrated': True})

# Bad - Will fail on second run
def migrate_data(env):
    records = env['my.model'].search([])
    for record in records:
        record.write({'new_field': 'value'})  # No check if already done
```

---

## 🔗 Related Topics

- Module Versioning
- Database Migrations
- Backward Compatibility
- Data Transformation
- Testing Strategies

---

## ❓ Questions & Answers

**Q: Does pre_init_hook run on updates?**  
A: No, only on first installation.

**Q: How do I test updates without affecting production?**  
A: Always test on a copy of the production database first.

**Q: Can I rollback a failed update?**  
A: Odoo rolls back automatically if hook raises an exception.

**Q: Should I delete old fields immediately?**  
A: No, keep them for a few versions to allow rollback if needed.

**Q: How do I handle large data migrations?**  
A: Process in batches and commit periodically.

---

## 📚 Additional Resources

- [Odoo Module Versioning](https://www.odoo.com/documentation/17.0/developer/reference/backend/module.html)
- [Database Migration Best Practices](https://www.postgresql.org/docs/current/ddl-alter.html)
- [OCA Migration Guidelines](https://github.com/OCA/maintainer-tools)

---

## 📝 Video Notes

**Note:** Watch the video and add your notes here:

### Key Points from Video:
- 
- 
- 

### Migration Examples Shown:
- 
- 
- 

### Important Takeaways:
- 
- 
- 

---

**Previous Lesson:** [Lesson 2: Pre-Init and Post-Init Hooks](./lesson_02_pre_post_init_hooks.md)  
**Next Lesson:** [Lesson 4: Uninstall Hooks](./lesson_04_uninstall_hooks.md)

