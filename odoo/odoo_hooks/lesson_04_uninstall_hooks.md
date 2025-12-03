# Lesson 4: Uninstall Hooks

**Video:** https://www.youtube.com/watch?v=MBj1xCy2oM0  
**Status:** ⬜ Not Started  
**Date Completed:**

---

## 📚 Learning Objectives

- Understand when and why to use uninstall hooks
- Learn to clean up custom data properly
- Handle external resource cleanup
- Implement safe uninstallation procedures
- Test uninstallation scenarios

---

## 📝 Key Concepts

### What is an Uninstall Hook?

The `uninstall_hook` runs BEFORE a module is uninstalled, allowing you to:
- Clean up custom database objects
- Remove data from external systems
- Close external connections
- Archive important data
- Perform final cleanup operations

### When to Use Uninstall Hooks

✅ **Use uninstall hooks for:**
- Removing custom database tables/views
- Cleaning up data in other modules
- Unregistering from external services
- Removing scheduled actions
- Archiving data before deletion

❌ **Don't use uninstall hooks for:**
- Removing module's own tables (Odoo does this)
- Deleting module's own records (Odoo does this)
- Operations that should persist after uninstall

### Uninstallation Process

```
1. uninstall_hook() executes
2. Module data files are removed
3. Module tables are dropped
4. Module marked as uninstalled
```

---

## 💻 Code Examples

### Example 1: Basic Uninstall Hook

```python
from odoo import api, SUPERUSER_ID
import logging

_logger = logging.getLogger(__name__)

def uninstall_hook(cr, registry):
    """
    Clean up before module uninstallation.
    """
    _logger.info("Starting module cleanup")
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    try:
        # Remove custom data
        cleanup_custom_data(env)
        
        # Remove scheduled actions
        cleanup_cron_jobs(env)
        
        # Clean up system parameters
        cleanup_parameters(env)
        
        _logger.info("Module cleanup completed successfully")
        
    except Exception as e:
        _logger.error(f"Cleanup failed: {e}")
        # Don't raise - allow uninstallation to continue

def cleanup_custom_data(env):
    """Remove custom data from other models"""
    _logger.info("Cleaning up custom data")
    
    # Remove custom fields data
    partners = env['res.partner'].search([('custom_field', '!=', False)])
    partners.write({'custom_field': False})

def cleanup_cron_jobs(env):
    """Remove module's cron jobs"""
    _logger.info("Removing cron jobs")
    
    crons = env['ir.cron'].search([
        ('name', 'ilike', 'my_module')
    ])
    crons.unlink()

def cleanup_parameters(env):
    """Remove system parameters"""
    _logger.info("Removing system parameters")
    
    params = env['ir.config_parameter'].search([
        ('key', 'ilike', 'my_module.%')
    ])
    params.unlink()
```

### Example 2: Drop Custom Database Objects

```python
def uninstall_hook(cr, registry):
    """
    Remove custom database objects.
    """
    _logger.info("Removing custom database objects")
    
    try:
        # Drop custom tables
        tables_to_drop = [
            'custom_log',
            'custom_data',
            'custom_cache',
        ]
        
        for table in tables_to_drop:
            _logger.info(f"Dropping table: {table}")
            cr.execute(f"""
                DROP TABLE IF EXISTS {table} CASCADE
            """)
        
        # Drop custom views
        views_to_drop = [
            'custom_view_1',
            'custom_view_2',
        ]
        
        for view in views_to_drop:
            _logger.info(f"Dropping view: {view}")
            cr.execute(f"""
                DROP VIEW IF EXISTS {view} CASCADE
            """)
        
        # Drop custom functions
        functions_to_drop = [
            'custom_function()',
        ]
        
        for func in functions_to_drop:
            _logger.info(f"Dropping function: {func}")
            cr.execute(f"""
                DROP FUNCTION IF EXISTS {func} CASCADE
            """)
        
        _logger.info("Database objects removed successfully")
        
    except Exception as e:
        _logger.error(f"Failed to remove database objects: {e}")
        # Continue anyway

```

### Example 3: External System Cleanup

```python
def uninstall_hook(cr, registry):
    """
    Clean up external system integrations.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    _logger.info("Cleaning up external integrations")
    
    try:
        # Get API configuration
        api_url = env['ir.config_parameter'].get_param('my_module.api_url')
        api_key = env['ir.config_parameter'].get_param('my_module.api_key')
        
        if api_url and api_key:
            # Unregister webhooks
            unregister_webhooks(api_url, api_key)
            
            # Delete external data
            cleanup_external_data(api_url, api_key)
            
            _logger.info("External cleanup completed")
        else:
            _logger.info("No external configuration found")
            
    except Exception as e:
        _logger.warning(f"External cleanup failed: {e}")
        # Don't block uninstallation

def unregister_webhooks(api_url, api_key):
    """Unregister webhooks from external system"""
    import requests
    
    try:
        response = requests.delete(
            f"{api_url}/webhooks",
            headers={'Authorization': f'Bearer {api_key}'},
            timeout=10
        )
        
        if response.status_code == 200:
            _logger.info("Webhooks unregistered successfully")
        else:
            _logger.warning(f"Webhook unregistration failed: {response.status_code}")
            
    except Exception as e:
        _logger.error(f"Failed to unregister webhooks: {e}")

def cleanup_external_data(api_url, api_key):
    """Remove data from external system"""
    import requests
    
    try:
        response = requests.delete(
            f"{api_url}/data",
            headers={'Authorization': f'Bearer {api_key}'},
            timeout=10
        )
        
        if response.status_code == 200:
            _logger.info("External data cleaned up")
            
    except Exception as e:
        _logger.error(f"Failed to cleanup external data: {e}")
```

### Example 4: Archive Data Before Deletion

```python
def uninstall_hook(cr, registry):
    """
    Archive important data before uninstallation.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    _logger.info("Archiving data before uninstallation")
    
    try:
        # Create archive table
        cr.execute("""
            CREATE TABLE IF NOT EXISTS my_module_archive (
                id SERIAL PRIMARY KEY,
                original_id INTEGER,
                data JSONB,
                archived_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                archived_by INTEGER
            )
        """)
        
        # Get all records to archive
        records = env['my.model'].search([])
        
        _logger.info(f"Archiving {len(records)} records")
        
        for record in records:
            # Convert record to JSON
            data = {
                'name': record.name,
                'value': record.value,
                'date': str(record.date) if record.date else None,
                # Add other important fields
            }
            
            # Insert into archive
            cr.execute("""
                INSERT INTO my_module_archive 
                (original_id, data, archived_by)
                VALUES (%s, %s, %s)
            """, (record.id, json.dumps(data), env.uid))
        
        _logger.info("Data archived successfully")
        _logger.info("Archive table 'my_module_archive' will persist after uninstallation")
        
    except Exception as e:
        _logger.error(f"Archiving failed: {e}")
```

### Example 5: Comprehensive Cleanup

```python
def uninstall_hook(cr, registry):
    """
    Comprehensive cleanup before uninstallation.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    _logger.info("=== Starting comprehensive cleanup ===")
    
    cleanup_tasks = [
        ("Custom data", cleanup_custom_data),
        ("Cron jobs", cleanup_cron_jobs),
        ("System parameters", cleanup_system_parameters),
        ("External integrations", cleanup_external_integrations),
        ("Database objects", cleanup_database_objects),
        ("Scheduled actions", cleanup_scheduled_actions),
        ("Email templates", cleanup_email_templates),
    ]
    
    for task_name, task_func in cleanup_tasks:
        try:
            _logger.info(f"Executing: {task_name}")
            task_func(env, cr)
            _logger.info(f"✓ {task_name} completed")
        except Exception as e:
            _logger.error(f"✗ {task_name} failed: {e}")
            # Continue with other tasks
    
    _logger.info("=== Cleanup completed ===")

def cleanup_custom_data(env, cr):
    """Remove custom data"""
    # Remove data added to other models
    cr.execute("""
        UPDATE res_partner 
        SET custom_field = NULL 
        WHERE custom_field IS NOT NULL
    """)

def cleanup_cron_jobs(env, cr):
    """Remove cron jobs"""
    crons = env['ir.cron'].search([
        '|',
        ('name', 'ilike', 'my_module'),
        ('model_id.model', '=', 'my.model')
    ])
    if crons:
        crons.unlink()
        _logger.info(f"Removed {len(crons)} cron jobs")

def cleanup_system_parameters(env, cr):
    """Remove system parameters"""
    params = env['ir.config_parameter'].search([
        ('key', 'ilike', 'my_module.%')
    ])
    if params:
        params.unlink()
        _logger.info(f"Removed {len(params)} parameters")

def cleanup_external_integrations(env, cr):
    """Clean up external integrations"""
    # Implementation from Example 3
    pass

def cleanup_database_objects(env, cr):
    """Remove custom database objects"""
    # Implementation from Example 2
    pass

def cleanup_scheduled_actions(env, cr):
    """Remove scheduled actions"""
    actions = env['ir.actions.server'].search([
        ('name', 'ilike', 'my_module')
    ])
    if actions:
        actions.unlink()

def cleanup_email_templates(env, cr):
    """Remove email templates"""
    templates = env['mail.template'].search([
        ('model', '=', 'my.model')
    ])
    if templates:
        templates.unlink()
```

---

## 🎯 Practice Exercises

### Exercise 1: Create Uninstall Hook

- [ ] Create a module with custom data
- [ ] Implement uninstall_hook
- [ ] Add cleanup for custom tables
- [ ] Add cleanup for system parameters
- [ ] Test uninstallation

### Exercise 2: Test Cleanup

- [ ] Install module and create test data
- [ ] Verify data exists
- [ ] Uninstall module
- [ ] Verify cleanup was successful
- [ ] Check logs for cleanup messages

### Exercise 3: Archive Before Uninstall

- [ ] Create archive table in uninstall_hook
- [ ] Archive all module data
- [ ] Complete uninstallation
- [ ] Verify archive table still exists
- [ ] Verify archived data is accessible

---

## 📌 Important Notes

### Best Practices

✅ **DO:**
- Log all cleanup operations
- Handle errors gracefully
- Don't block uninstallation on errors
- Archive important data
- Clean up external resources
- Remove scheduled actions
- Test uninstallation thoroughly

❌ **DON'T:**
- Raise exceptions (allow uninstall to continue)
- Delete data from other modules' tables
- Assume external services are available
- Perform long-running operations
- Delete audit logs
- Remove data that should persist

### Safe Cleanup Pattern

```python
def uninstall_hook(cr, registry):
    """Safe cleanup pattern"""
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    try:
        # Attempt cleanup
        cleanup_operations(env)
    except Exception as e:
        _logger.error(f"Cleanup failed: {e}")
        # Don't raise - allow uninstallation
```

### Testing Uninstallation

```bash
# Install module
odoo-bin -d testdb -i my_module

# Create test data
# ... use Odoo interface ...

# Uninstall with logging
odoo-bin -d testdb -u my_module --log-level=debug

# Verify cleanup
psql testdb -c "SELECT * FROM my_module_archive"
```

---

## 🔗 Related Topics

- Module Lifecycle
- Database Cleanup
- External API Integration
- Data Archiving
- Error Handling

---

## ❓ Questions & Answers

**Q: Will Odoo remove my module's tables automatically?**  
A: Yes, Odoo removes tables defined in models automatically.

**Q: Should I delete data from other modules?**  
A: Only if your module added that data. Be very careful.

**Q: What if external API is unavailable during uninstall?**  
A: Log the error and continue. Don't block uninstallation.

**Q: Can I prevent uninstallation?**  
A: Not recommended. Log warnings instead.

**Q: Should I commit in uninstall_hook?**  
A: No, let Odoo handle transaction management.

---

## 📚 Additional Resources

- [Odoo Module Uninstallation](https://www.odoo.com/documentation/17.0/developer/reference/backend/module.html)
- [PostgreSQL DROP Commands](https://www.postgresql.org/docs/current/sql-drop.html)
- [Python Requests Library](https://requests.readthedocs.io/)

---

## 📝 Video Notes

**Note:** Watch the video and add your notes here:

### Key Points from Video:
- 
- 
- 

### Cleanup Examples Shown:
- 
- 
- 

### Important Takeaways:
- 
- 
- 

---

**Previous Lesson:** [Lesson 3: Update Hooks](./lesson_03_update_hooks.md)  
**Next Lesson:** [Lesson 5: Advanced Hook Patterns](./lesson_05_advanced_patterns.md)

