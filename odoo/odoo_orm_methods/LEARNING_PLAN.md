# Odoo ORM Methods - Learning Path

**Playlist URL:** https://www.youtube.com/playlist?list=PLqRRLx0cl0hphrDY9cvs0ZEUn-VZd9dcP  
**Total Videos:** 15  
**Topic:** Odoo ORM (Object-Relational Mapping) Methods

---

## 📚 Learning Objectives

By the end of this learning path, you will:
- Master all essential Odoo ORM methods
- Understand when and how to use each method effectively
- Learn best practices for database operations in Odoo
- Gain practical experience through hands-on examples
- Understand performance implications of different ORM methods

---

## 🗺️ Learning Path Structure

### Phase 1: Foundation - Basic ORM Operations (Videos 1-4)

#### Lesson 1: Introduction to Odoo ORM
- **Video:** https://www.youtube.com/watch?v=8V-uOG8KkKA
- **Topics:**
  - What is ORM in Odoo?
  - Understanding the `self.env` object
  - Recordset basics
  - Model inheritance and structure
- **Practice:**
  - Create a simple model
  - Access records using `self.env`
  - Understand recordset operations

#### Lesson 2: Search Methods
- **Video:** https://www.youtube.com/watch?v=STKq2owQGII
- **Topics:**
  - `search()` method - basic usage
  - Search domains
  - Search with filters
  - Limit and offset
  - Order by
- **Practice:**
  - Write search queries with different domains
  - Practice with limit and offset
  - Combine multiple search conditions

#### Lesson 3: Read Operations
- **Video:** https://www.youtube.com/watch?v=a4KWUtN1nVw
- **Topics:**
  - `read()` method
  - `read_group()` for aggregations
  - Reading specific fields
  - Reading related fields
- **Practice:**
  - Read records with different field selections
  - Practice read_group for reports
  - Access related field data

#### Lesson 4: Search and Read Combined
- **Video:** https://www.youtube.com/watch?v=n37RL_j4K3A
- **Topics:**
  - `search_read()` method
  - When to use search_read vs search+read
  - Performance considerations
  - Field selection in search_read
- **Practice:**
  - Convert search+read to search_read
  - Compare performance
  - Optimize queries

---

### Phase 2: Write Operations (Videos 5-7)

#### Lesson 5: Create Records
- **Video:** https://www.youtube.com/watch?v=qgcGpdGCxeA
- **Topics:**
  - `create()` method
  - Creating single records
  - Creating multiple records (bulk create)
  - Default values
  - Related field creation
- **Practice:**
  - Create records programmatically
  - Handle default values
  - Create records with related fields

#### Lesson 6: Update Records
- **Video:** https://www.youtube.com/watch?v=Cm-DBN_Q-pk
- **Topics:**
  - `write()` method
  - Updating single records
  - Bulk updates
  - Writing to related fields
  - Computed field updates
- **Practice:**
  - Update existing records
  - Bulk update operations
  - Handle computed fields

#### Lesson 7: Delete Operations
- **Video:** https://www.youtube.com/watch?v=Zc3uLs8O8Og
- **Topics:**
  - `unlink()` method
  - Soft delete vs hard delete
  - Cascade deletions
  - Access rights and deletions
- **Practice:**
  - Delete records safely
  - Handle related record deletions
  - Implement soft delete patterns

---

### Phase 3: Advanced Operations (Videos 8-11)

#### Lesson 8: Browse and Exists
- **Video:** https://www.youtube.com/watch?v=tIaIixa3oAs
- **Topics:**
  - `browse()` method
  - When to use browse
  - `exists()` method
  - Checking record existence
- **Practice:**
  - Use browse for direct record access
  - Check if records exist before operations
  - Handle deleted records

#### Lesson 9: Recordset Operations
- **Video:** https://www.youtube.com/watch?v=0qg-6rlo3oU
- **Topics:**
  - `mapped()` method
  - `filtered()` method
  - `sorted()` method
  - Chaining operations
- **Practice:**
  - Transform recordsets with mapped
  - Filter recordsets
  - Sort recordsets
  - Chain multiple operations

#### Lesson 10: Context and Environment
- **Video:** https://www.youtube.com/watch?v=XBj4GgYUSGA
- **Topics:**
  - `with_context()` method
  - Understanding context
  - `sudo()` method
  - User permissions and context
- **Practice:**
  - Pass context to methods
  - Use sudo for elevated permissions
  - Understand security implications

#### Lesson 11: Advanced Search Patterns
- **Video:** https://www.youtube.com/watch?v=h_6cBqeEkGQ
- **Topics:**
  - Complex search domains
  - Search with joins
  - Performance optimization
  - Search best practices
- **Practice:**
  - Write complex search queries
  - Optimize slow searches
  - Use indexes effectively

---

### Phase 4: Specialized Methods (Videos 12-15)

#### Lesson 12: Copy and Duplicate
- **Video:** https://www.youtube.com/watch?v=9rHKtoKz_yw
- **Topics:**
  - `copy()` method
  - `copy_data()` method
  - Duplicating records
  - Handling related records in copy
- **Practice:**
  - Copy records with modifications
  - Handle one2many and many2many in copy
  - Custom copy logic

#### Lesson 13: Name Get and Name Search
- **Video:** https://www.youtube.com/watch?v=S5FWeUTtmmE
- **Topics:**
  - `name_get()` method
  - `name_search()` method
  - Custom display names
  - Search by name patterns
- **Practice:**
  - Customize record display names
  - Implement name_search for autocomplete
  - Handle multi-language names

#### Lesson 14: Ensure One and Other Utilities
- **Video:** https://www.youtube.com/watch?v=mr6ZbUcOG_U
- **Topics:**
  - `ensure_one()` method
  - `ensure_one()` vs `exists()`
  - Other utility methods
  - Error handling patterns
- **Practice:**
  - Use ensure_one for validation
  - Handle recordset size errors
  - Implement robust error handling

#### Lesson 15: Best Practices and Performance
- **Video:** https://www.youtube.com/watch?v=jdDyLy2nttI
- **Topics:**
  - ORM method performance tips
  - Common mistakes to avoid
  - Best practices summary
  - Real-world examples
- **Practice:**
  - Review and optimize code
  - Apply all learned methods
  - Build a complete example module

---

## 📝 Study Plan

### Week 1: Foundation (Lessons 1-4)
- **Day 1-2:** Lesson 1 - Introduction to Odoo ORM
- **Day 3-4:** Lesson 2 - Search Methods
- **Day 5-6:** Lesson 3 - Read Operations
- **Day 7:** Lesson 4 - Search and Read Combined + Review

### Week 2: Write Operations (Lessons 5-7)
- **Day 1-2:** Lesson 5 - Create Records
- **Day 3-4:** Lesson 6 - Update Records
- **Day 5-6:** Lesson 7 - Delete Operations
- **Day 7:** Review and Practice All Write Operations

### Week 3: Advanced Operations (Lessons 8-11)
- **Day 1:** Lesson 8 - Browse and Exists
- **Day 2-3:** Lesson 9 - Recordset Operations
- **Day 4-5:** Lesson 10 - Context and Environment
- **Day 6-7:** Lesson 11 - Advanced Search Patterns

### Week 4: Specialized Methods & Mastery (Lessons 12-15)
- **Day 1-2:** Lesson 12 - Copy and Duplicate
- **Day 3-4:** Lesson 13 - Name Get and Name Search
- **Day 5:** Lesson 14 - Ensure One and Utilities
- **Day 6-7:** Lesson 15 - Best Practices + Final Project

---

## 🎯 Practice Projects

### Project 1: Library Management System
- Create models for Books, Authors, Members
- Implement CRUD operations
- Use search, read, create, write, unlink

### Project 2: Task Management Module
- Advanced search patterns
- Recordset operations (mapped, filtered, sorted)
- Context and permissions

### Project 3: Reporting Module
- Use read_group for aggregations
- Complex search queries
- Performance optimization

---

## 📋 Checklist for Each Lesson

- [ ] Watch the video completely
- [ ] Take notes on key concepts
- [ ] Complete practice exercises
- [ ] Review code examples
- [ ] Try variations of examples
- [ ] Document questions and answers
- [ ] Share learnings (optional)

---

## 🔗 Additional Resources

- [Odoo ORM Documentation](https://www.odoo.com/documentation/16.0/developer/reference/backend/orm.html)
- [Odoo API Reference](https://www.odoo.com/documentation/16.0/developer/reference/backend/orm.html#model-reference)
- Odoo Community Forums
- Odoo GitHub Repository

---

## 📊 Progress Tracking

### Completion Status
- [ ] Phase 1: Foundation (0/4 lessons)
- [ ] Phase 2: Write Operations (0/3 lessons)
- [ ] Phase 3: Advanced Operations (0/4 lessons)
- [ ] Phase 4: Specialized Methods (0/4 lessons)

### Practice Projects
- [ ] Project 1: Library Management
- [ ] Project 2: Task Management
- [ ] Project 3: Reporting Module

---

## 💡 Tips for Success

1. **Practice Regularly:** Code along with each video
2. **Take Notes:** Document important concepts and patterns
3. **Experiment:** Try variations of examples
4. **Review:** Revisit previous lessons regularly
5. **Build Projects:** Apply knowledge in real scenarios
6. **Ask Questions:** Use forums and communities
7. **Read Documentation:** Complement videos with official docs

---

## 🎓 Next Steps After Completion

1. Build a custom Odoo module using all ORM methods
2. Contribute to open-source Odoo projects
3. Explore advanced topics:
   - ORM hooks and decorators
   - Custom SQL queries
   - Performance tuning
   - Testing ORM methods

---

**Last Updated:** 2025-01-27  
**Status:** Planning Phase

