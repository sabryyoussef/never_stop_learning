# Lesson 1: Introduction to Odoo Hooks

**Video:** https://www.youtube.com/watch?v=XRxxyJ-FJfI  
**Status:** ⬜ Not Started  
**Date Completed:**

---

## 📚 Learning Objectives

- Understand what Odoo Hooks are and their purpose
- Learn the module lifecycle in Odoo
- Identify different types of hooks available
- Recognize when to use hooks vs. other approaches
- Understand hook execution order

---

## 📝 Key Concepts

### What are Odoo Hooks?

**Odoo Hooks** are special Python functions that execute at specific points during a module's lifecycle:
- **Installation:** When a module is first installed
- **Update:** When a module is upgraded
- **Loading:** When Odoo server starts
- **Uninstallation:** When a module is removed

### Why Use Hooks?

Hooks allow you to:
- Prepare the database before installation
- Initialize data after installation
- Migrate data during updates
- Clean up resources on uninstallation
- Integrate with external systems

### Module Lifecycle

```
┌─────────────────────────────────────────┐
│         Module Installation              │
├─────────────────────────────────────────┤
│  1. pre_init_hook()                     │
│  2. Create database tables              │
│  3. Load XML/CSV data files             │
│  4. post_init_hook()                    │
│  5. Module marked as installed          │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│          Module Update                   │
├─────────────────────────────────────────┤
│  1. Update database schema              │
│  2. Load updated data files             │
│  3. post_init_hook() (if defined)       │
│  4. Module version updated              │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│        Module Uninstallation             │
├─────────────────────────────────────────┤
│  1. uninstall_hook()                    │
│  2. Remove database tables              │
│  3. Delete module data                  │
│  4. Module marked as uninstalled        │
└─────────────────────────────────────────┘
```

### Types of Hooks

| Hook | When It Runs | Common Use Cases |
|------|--------------|------------------|
| `pre_init_hook` | Before installation | Database preparation, schema setup |
| `post_init_hook` | After installation | Data initialization, configuration |
| `post_load` | After server start | Runtime initialization, caching |
| `uninstall_hook` | Before uninstallation | Cleanup, remove custom data |

---

## 💻 Code Examples

### Basic Hook Declaration

**File: `__manifest__.py`**

```python
{
    'name': 'My Custom Module',
    'version': '1.0',
    'category': 'Custom',
    'summary': 'Module with hooks example',
    'depends': ['base'],
    'data': [
        'views/my_views.xml',
    ],
    # Hook declarations
    'pre_init_hook': 'pre_init_hook',
    'post_init_hook': 'post_init_hook',
    'uninstall_hook': 'uninstall_hook',
    'installable': True,
    'application': False,
}
```

### Basic Hook Implementation

**File: `hooks.py`**

```python
import logging
from odoo import api, SUPERUSER_ID

_logger = logging.getLogger(__name__)

def pre_init_hook(cr):
    """
    Hook executed before module installation.
    
    Args:
        cr: Database cursor
    """
    _logger.info("=== Pre-init hook started ===")
    _logger.info("Preparing database for module installation")
    # Database preparation code here
    _logger.info("=== Pre-init hook completed ===")

def post_init_hook(cr, registry):
    """
    Hook executed after module installation.
    
    Args:
        cr: Database cursor
        registry: Odoo registry
    """
    _logger.info("=== Post-init hook started ===")
    env = api.Environment(cr, SUPERUSER_ID, {})
    _logger.info(f"Initializing data for database: {cr.dbname}")
    # Initialization code here
    _logger.info("=== Post-init hook completed ===")

def uninstall_hook(cr, registry):
    """
    Hook executed before module uninstallation.
    
    Args:
        cr: Database cursor
        registry: Odoo registry
    """
    _logger.info("=== Uninstall hook started ===")
    env = api.Environment(cr, SUPERUSER_ID, {})
    _logger.info("Cleaning up module data")
    # Cleanup code here
    _logger.info("=== Uninstall hook completed ===")
```

### Importing Hooks

**File: `__init__.py`**

```python
from . import models
from . import controllers

# Import hooks
from .hooks import pre_init_hook, post_init_hook, uninstall_hook
```

---

## 🎯 Practice Exercises

### Exercise 1: Identify Hook Use Cases
Review the following scenarios and identify which hook type would be appropriate:

- [ ] **Scenario A:** Create default configuration records after module installation
  - Answer: _____

- [ ] **Scenario B:** Create a custom database table before Odoo creates model tables
  - Answer: _____

- [ ] **Scenario C:** Remove custom data from external system when uninstalling
  - Answer: _____

- [ ] **Scenario D:** Transform existing data format during module update
  - Answer: _____

### Exercise 2: Review Existing Modules
Find and analyze hooks in popular Odoo modules:

- [ ] Browse OCA modules on GitHub
- [ ] Find 3 modules that use hooks
- [ ] Document what each hook does
- [ ] Note any patterns you observe

**Modules Found:**
1. Module: _____ | Hook Type: _____ | Purpose: _____
2. Module: _____ | Hook Type: _____ | Purpose: _____
3. Module: _____ | Hook Type: _____ | Purpose: _____

### Exercise 3: Create Module Structure
Create a basic module structure with hook placeholders:

- [ ] Create module directory
- [ ] Create `__manifest__.py` with hook declarations
- [ ] Create `hooks.py` with basic hook functions
- [ ] Create `__init__.py` with hook imports
- [ ] Test module installation (hooks should log messages)

---

## 📌 Important Notes

### Hook Execution Order

1. **Installation:**
   ```
   pre_init_hook → Create Tables → Load Data → post_init_hook
   ```

2. **Update:**
   ```
   Update Schema → Load Data → post_init_hook (if present)
   ```

3. **Uninstallation:**
   ```
   uninstall_hook → Drop Tables → Remove Data
   ```

### Key Points to Remember

- **Hooks are optional** - Only use them when needed
- **Keep hooks simple** - Complex logic should be in separate functions
- **Always log** - Use logging to track hook execution
- **Handle errors** - Wrap risky operations in try-except blocks
- **Test thoroughly** - Test installation, update, and uninstallation
- **Document well** - Explain what each hook does and why

### When NOT to Use Hooks

❌ **Don't use hooks for:**
- Regular business logic (use model methods instead)
- Simple data that can be loaded via XML/CSV
- Operations that should run on every server start (use `post_load` carefully)
- Complex operations that might fail (consider alternative approaches)

✅ **Use hooks for:**
- Database schema preparation
- Complex data initialization
- Data migration between versions
- External system integration
- Cleanup operations

---

## 🔗 Related Topics

- Odoo Module Structure
- Database Cursors and Transactions
- Odoo Registry
- Module Installation Process
- Data Files (XML/CSV)

---

## ❓ Questions & Answers

**Q: Can I use ORM methods in pre_init_hook?**  
A: No, the ORM is not fully initialized yet. Use raw SQL with the cursor (`cr.execute()`).

**Q: What's the difference between post_init_hook and loading data via XML?**  
A: XML is for static data. post_init_hook is for dynamic data creation or complex initialization logic.

**Q: Do hooks run on every module update?**  
A: post_init_hook runs on updates if defined. pre_init_hook only runs on first installation.

**Q: Can hooks access external APIs?**  
A: Yes, but handle errors gracefully as external services might be unavailable during installation.

**Q: How do I test hooks during development?**  
A: Uninstall and reinstall the module, or call hooks manually from Odoo shell.

---

## 📚 Additional Resources

- [Odoo Hooks Documentation](https://www.odoo.com/documentation/17.0/developer/reference/backend/hooks.html)
- [Module Manifest Reference](https://www.odoo.com/documentation/17.0/developer/reference/backend/module.html)
- [OCA Module Guidelines](https://github.com/OCA/odoo-community.org)

---

## 📝 Video Notes

**Note:** Watch the video and add your notes here:

### Key Points from Video:
- 
- 
- 

### Examples Shown:
- 
- 
- 

### Important Takeaways:
- 
- 
- 

---

**Next Lesson:** [Lesson 2: Pre-Init and Post-Init Hooks](./lesson_02_pre_post_init_hooks.md)

