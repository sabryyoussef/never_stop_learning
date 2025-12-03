# Lesson 5: Advanced Hook Patterns

**Video:** https://www.youtube.com/watch?v=8K1o9Xhk4gY  
**Status:** ⬜ Not Started  
**Date Completed:**

---

## 📚 Learning Objectives

- Master advanced hook implementation patterns
- Learn complex data migration strategies
- Implement hooks for multi-module scenarios
- Apply performance optimization techniques
- Follow enterprise-level best practices
- Build comprehensive testing strategies

---

## 📝 Key Concepts

### Advanced Hook Patterns

1. **Multi-Stage Migrations:** Break complex migrations into stages
2. **Conditional Hooks:** Execute different logic based on conditions
3. **Hook Chaining:** Coordinate hooks across multiple modules
4. **Rollback Strategies:** Implement safe rollback mechanisms
5. **Performance Optimization:** Handle large datasets efficiently

### Enterprise Considerations

- **Scalability:** Handle millions of records
- **Performance:** Minimize installation/update time
- **Reliability:** Ensure hooks don't fail in production
- **Monitoring:** Track hook execution and performance
- **Documentation:** Comprehensive hook documentation

---

## 💻 Code Examples

### Example 1: Multi-Stage Migration

```python
from odoo import api, SUPERUSER_ID
import logging

_logger = logging.getLogger(__name__)

def post_init_hook(cr, registry):
    """
    Multi-stage migration with progress tracking.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    stages = [
        ('stage1', 'Data Structure Migration', migrate_stage1),
        ('stage2', 'Relationship Migration', migrate_stage2),
        ('stage3', 'Computed Fields Update', migrate_stage3),
        ('stage4', 'External Sync', migrate_stage4),
    ]
    
    # Check migration progress
    progress = get_migration_progress(env)
    
    for stage_id, stage_name, stage_func in stages:
        if stage_id in progress.get('completed', []):
            _logger.info(f"Stage {stage_id} already completed, skipping")
            continue
        
        _logger.info(f"=== Starting {stage_name} ===")
        
        try:
            stage_func(env, cr)
            mark_stage_complete(env, stage_id)
            _logger.info(f"✓ {stage_name} completed")
            
        except Exception as e:
            _logger.error(f"✗ {stage_name} failed: {e}")
            mark_stage_failed(env, stage_id, str(e))
            raise
    
    _logger.info("All migration stages completed")

def get_migration_progress(env):
    """Get migration progress from database"""
    cr = env.cr
    cr.execute("""
        SELECT stage_id, status 
        FROM migration_progress 
        WHERE module = 'my_module'
    """)
    results = cr.fetchall()
    
    progress = {
        'completed': [r[0] for r in results if r[1] == 'completed'],
        'failed': [r[0] for r in results if r[1] == 'failed'],
    }
    return progress

def mark_stage_complete(env, stage_id):
    """Mark migration stage as complete"""
    env.cr.execute("""
        INSERT INTO migration_progress (module, stage_id, status, completed_at)
        VALUES ('my_module', %s, 'completed', NOW())
        ON CONFLICT (module, stage_id) 
        DO UPDATE SET status = 'completed', completed_at = NOW()
    """, (stage_id,))

def mark_stage_failed(env, stage_id, error):
    """Mark migration stage as failed"""
    env.cr.execute("""
        INSERT INTO migration_progress (module, stage_id, status, error, failed_at)
        VALUES ('my_module', %s, 'failed', %s, NOW())
        ON CONFLICT (module, stage_id) 
        DO UPDATE SET status = 'failed', error = %s, failed_at = NOW()
    """, (stage_id, error, error))

def migrate_stage1(env, cr):
    """Stage 1: Data structure migration"""
    _logger.info("Migrating data structure")
    # Implementation
    pass

def migrate_stage2(env, cr):
    """Stage 2: Relationship migration"""
    _logger.info("Migrating relationships")
    # Implementation
    pass

def migrate_stage3(env, cr):
    """Stage 3: Update computed fields"""
    _logger.info("Updating computed fields")
    # Implementation
    pass

def migrate_stage4(env, cr):
    """Stage 4: External synchronization"""
    _logger.info("Syncing with external systems")
    # Implementation
    pass
```

### Example 2: Performance-Optimized Migration

```python
def post_init_hook(cr, registry):
    """
    High-performance migration for large datasets.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    _logger.info("Starting performance-optimized migration")
    
    # Get total count
    cr.execute("SELECT COUNT(*) FROM my_model WHERE migrated = FALSE")
    total = cr.fetchone()[0]
    
    if total == 0:
        _logger.info("No records to migrate")
        return
    
    _logger.info(f"Migrating {total} records")
    
    # Use cursor-based pagination for memory efficiency
    batch_size = 1000
    offset = 0
    migrated_count = 0
    
    while True:
        # Fetch batch using raw SQL for performance
        cr.execute("""
            SELECT id, old_field1, old_field2, old_field3
            FROM my_model
            WHERE migrated = FALSE
            ORDER BY id
            LIMIT %s OFFSET %s
        """, (batch_size, offset))
        
        batch = cr.fetchall()
        
        if not batch:
            break
        
        # Process batch
        for record_id, old_field1, old_field2, old_field3 in batch:
            try:
                # Transform data
                new_value = transform_data(old_field1, old_field2, old_field3)
                
                # Update using raw SQL for performance
                cr.execute("""
                    UPDATE my_model
                    SET new_field = %s, migrated = TRUE
                    WHERE id = %s
                """, (new_value, record_id))
                
                migrated_count += 1
                
            except Exception as e:
                _logger.error(f"Failed to migrate record {record_id}: {e}")
        
        # Commit batch
        cr.commit()
        
        # Log progress
        progress = (migrated_count / total) * 100
        _logger.info(f"Progress: {migrated_count}/{total} ({progress:.1f}%)")
        
        offset += batch_size
    
    _logger.info(f"Migration completed: {migrated_count} records migrated")

def transform_data(field1, field2, field3):
    """Transform old data format to new format"""
    # Complex transformation logic
    return f"{field1}_{field2}_{field3}"
```

### Example 3: Conditional Hook Execution

```python
def post_init_hook(cr, registry):
    """
    Execute different logic based on environment and conditions.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Detect environment
    is_production = detect_production_environment(env)
    is_test = detect_test_environment(env)
    
    _logger.info(f"Environment: {'Production' if is_production else 'Test/Dev'}")
    
    # Get module configuration
    config = get_module_config(env)
    
    # Conditional execution
    if is_production:
        _logger.info("Running production initialization")
        initialize_production(env, config)
    elif is_test:
        _logger.info("Running test initialization")
        initialize_test_data(env)
    else:
        _logger.info("Running development initialization")
        initialize_dev_data(env)
    
    # Feature flags
    if config.get('enable_external_sync'):
        _logger.info("External sync enabled")
        setup_external_sync(env, config)
    
    if config.get('enable_advanced_features'):
        _logger.info("Advanced features enabled")
        setup_advanced_features(env)

def detect_production_environment(env):
    """Detect if running in production"""
    # Check various indicators
    base_url = env['ir.config_parameter'].get_param('web.base.url', '')
    
    production_indicators = [
        'production' in base_url.lower(),
        'prod' in base_url.lower(),
        not base_url.startswith('http://localhost'),
    ]
    
    return any(production_indicators)

def detect_test_environment(env):
    """Detect if running in test environment"""
    return env.registry.in_test_mode()

def get_module_config(env):
    """Get module configuration"""
    return {
        'enable_external_sync': env['ir.config_parameter'].get_param(
            'my_module.enable_external_sync', 'False'
        ) == 'True',
        'enable_advanced_features': env['ir.config_parameter'].get_param(
            'my_module.enable_advanced_features', 'False'
        ) == 'True',
    }

def initialize_production(env, config):
    """Production-specific initialization"""
    _logger.info("Initializing production environment")
    # Minimal data, no test records
    pass

def initialize_test_data(env):
    """Test-specific initialization"""
    _logger.info("Creating test data")
    # Create test records
    pass

def initialize_dev_data(env):
    """Development-specific initialization"""
    _logger.info("Creating development data")
    # Create extensive test data
    pass
```

### Example 4: Hook with Rollback Strategy

```python
def post_init_hook(cr, registry):
    """
    Migration with rollback capability.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    _logger.info("Starting migration with rollback support")
    
    # Create backup before migration
    backup_id = create_migration_backup(env)
    
    try:
        # Perform migration
        perform_migration(env)
        
        # Validate migration
        if validate_migration(env):
            _logger.info("Migration validated successfully")
            mark_backup_as_successful(env, backup_id)
        else:
            _logger.error("Migration validation failed")
            rollback_migration(env, backup_id)
            raise Exception("Migration validation failed")
            
    except Exception as e:
        _logger.error(f"Migration failed: {e}")
        rollback_migration(env, backup_id)
        raise

def create_migration_backup(env):
    """Create backup of data before migration"""
    _logger.info("Creating migration backup")
    
    backup_id = env['migration.backup'].create({
        'name': f'Migration Backup {fields.Datetime.now()}',
        'module': 'my_module',
        'status': 'in_progress',
    })
    
    # Backup data to JSON
    records = env['my.model'].search([])
    backup_data = []
    
    for record in records:
        backup_data.append({
            'id': record.id,
            'name': record.name,
            'value': record.value,
            # Add other fields
        })
    
    backup_id.write({
        'data': json.dumps(backup_data),
        'record_count': len(backup_data),
    })
    
    _logger.info(f"Backed up {len(backup_data)} records")
    return backup_id

def perform_migration(env):
    """Perform the actual migration"""
    _logger.info("Performing migration")
    # Migration logic
    pass

def validate_migration(env):
    """Validate migration results"""
    _logger.info("Validating migration")
    
    # Check data integrity
    cr = env.cr
    cr.execute("""
        SELECT COUNT(*) 
        FROM my_model 
        WHERE new_field IS NULL AND old_field IS NOT NULL
    """)
    
    unmigrated = cr.fetchone()[0]
    
    if unmigrated > 0:
        _logger.error(f"Found {unmigrated} unmigrated records")
        return False
    
    return True

def rollback_migration(env, backup_id):
    """Rollback migration using backup"""
    _logger.warning("Rolling back migration")
    
    backup_data = json.loads(backup_id.data)
    
    for record_data in backup_data:
        record = env['my.model'].browse(record_data['id'])
        if record.exists():
            record.write({
                'name': record_data['name'],
                'value': record_data['value'],
            })
    
    backup_id.write({'status': 'rolled_back'})
    _logger.info("Rollback completed")

def mark_backup_as_successful(env, backup_id):
    """Mark backup as successful"""
    backup_id.write({'status': 'successful'})
```

### Example 5: Comprehensive Hook with Monitoring

```python
import time
from contextlib import contextmanager

def post_init_hook(cr, registry):
    """
    Enterprise-grade hook with monitoring and metrics.
    """
    env = api.Environment(cr, SUPERUSER_ID, {})
    
    # Initialize monitoring
    monitor = HookMonitor(env, 'post_init_hook')
    
    try:
        with monitor.track_operation('initialization'):
            # Main initialization logic
            initialize_module(env, monitor)
        
        # Log metrics
        monitor.log_metrics()
        
    except Exception as e:
        monitor.log_error(e)
        raise

def initialize_module(env, monitor):
    """Initialize module with monitoring"""
    
    tasks = [
        ('create_default_data', create_default_data),
        ('setup_configurations', setup_configurations),
        ('initialize_integrations', initialize_integrations),
        ('validate_setup', validate_setup),
    ]
    
    for task_name, task_func in tasks:
        with monitor.track_operation(task_name):
            task_func(env)

class HookMonitor:
    """Monitor hook execution and collect metrics"""
    
    def __init__(self, env, hook_name):
        self.env = env
        self.hook_name = hook_name
        self.start_time = time.time()
        self.operations = {}
        self.errors = []
    
    @contextmanager
    def track_operation(self, operation_name):
        """Track operation execution time"""
        _logger.info(f"Starting: {operation_name}")
        op_start = time.time()
        
        try:
            yield
            duration = time.time() - op_start
            self.operations[operation_name] = {
                'status': 'success',
                'duration': duration,
            }
            _logger.info(f"✓ {operation_name} completed in {duration:.2f}s")
            
        except Exception as e:
            duration = time.time() - op_start
            self.operations[operation_name] = {
                'status': 'failed',
                'duration': duration,
                'error': str(e),
            }
            _logger.error(f"✗ {operation_name} failed after {duration:.2f}s: {e}")
            raise
    
    def log_error(self, error):
        """Log error"""
        self.errors.append({
            'error': str(error),
            'timestamp': time.time(),
        })
    
    def log_metrics(self):
        """Log collected metrics"""
        total_duration = time.time() - self.start_time
        
        _logger.info("=== Hook Execution Metrics ===")
        _logger.info(f"Hook: {self.hook_name}")
        _logger.info(f"Total Duration: {total_duration:.2f}s")
        _logger.info(f"Operations: {len(self.operations)}")
        
        for op_name, op_data in self.operations.items():
            status = op_data['status']
            duration = op_data['duration']
            _logger.info(f"  - {op_name}: {status} ({duration:.2f}s)")
        
        if self.errors:
            _logger.info(f"Errors: {len(self.errors)}")
            for error in self.errors:
                _logger.error(f"  - {error['error']}")
        
        # Store metrics in database
        self.store_metrics(total_duration)
    
    def store_metrics(self, total_duration):
        """Store metrics in database for analysis"""
        self.env['hook.execution.log'].create({
            'hook_name': self.hook_name,
            'duration': total_duration,
            'operations': json.dumps(self.operations),
            'errors': json.dumps(self.errors),
            'executed_at': fields.Datetime.now(),
        })

def create_default_data(env):
    """Create default data"""
    pass

def setup_configurations(env):
    """Setup configurations"""
    pass

def initialize_integrations(env):
    """Initialize integrations"""
    pass

def validate_setup(env):
    """Validate setup"""
    pass
```

---

## 🎯 Practice Exercises

### Exercise 1: Implement Multi-Stage Migration

- [ ] Design a 4-stage migration process
- [ ] Implement progress tracking
- [ ] Add rollback capability
- [ ] Test each stage independently
- [ ] Test full migration flow

### Exercise 2: Performance Optimization

- [ ] Create test data (10,000+ records)
- [ ] Implement batch processing
- [ ] Measure execution time
- [ ] Optimize SQL queries
- [ ] Compare before/after performance

### Exercise 3: Enterprise Hook

- [ ] Implement monitoring
- [ ] Add metrics collection
- [ ] Create comprehensive logging
- [ ] Add error handling
- [ ] Test in production-like environment

---

## 📌 Important Notes

### Performance Best Practices

- Use raw SQL for large datasets
- Process in batches
- Commit periodically
- Use indexes
- Avoid ORM for bulk operations
- Monitor memory usage

### Testing Strategies

```python
# Unit tests for hooks
from odoo.tests import TransactionCase

class TestHooks(TransactionCase):
    def test_post_init_hook(self):
        from ..hooks import post_init_hook
        post_init_hook(self.cr, self.registry)
        # Assertions
```

---

## 🔗 Related Topics

- Performance Optimization
- Database Indexing
- Monitoring and Metrics
- Error Handling Patterns
- Enterprise Odoo Development

---

## 📚 Additional Resources

- [Odoo Performance Guidelines](https://www.odoo.com/documentation/17.0/developer/reference/backend/performance.html)
- [PostgreSQL Performance Tips](https://wiki.postgresql.org/wiki/Performance_Optimization)
- [Python Profiling](https://docs.python.org/3/library/profile.html)

---

## 📝 Video Notes

**Note:** Watch the video and add your notes here:

### Key Points from Video:
- 
- 
- 

### Advanced Patterns Shown:
- 
- 
- 

### Important Takeaways:
- 
- 
- 

---

**Previous Lesson:** [Lesson 4: Uninstall Hooks](./lesson_04_uninstall_hooks.md)  
**Course Complete!** 🎉

