# Phase 1: Introduction & Setup - Lessons

All 4 lessons in Phase 1 with video links and key concepts.

---

## Lesson 1: Overview of Odoo Portal Features

**Video:** https://www.youtube.com/watch?v=bDzvf8DLl78  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- What is Odoo Portal?
- Portal vs backend access
- Common portal use cases
- Portal architecture overview
- Portal user management

### Key Concepts:
- Portal provides external user access
- Limited to user's own data
- Custom web interface
- Secure and controlled access

### Practice:
- [ ] Explore Odoo's default portal
- [ ] List 5 real-world portal use cases
- [ ] Understand portal user types

### Notes:
_Add your notes here after watching the video_

---

## Lesson 2: Setting Up Development Environment

**Video:** https://www.youtube.com/watch?v=ZaZJchTcxf0  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Installing required modules
- Portal module dependencies
- Development vs production setup
- Database configuration

### Key Concepts:
- portal module is the foundation
- website module often required
- Proper module dependencies

### Practice:
- [ ] Install Odoo with portal module
- [ ] Create a test database
- [ ] Configure portal settings
- [ ] Create test portal users

### Notes:
_Add your notes here after watching the video_

---

## Lesson 3: Creating Custom Portal Menus

**Video:** https://www.youtube.com/watch?v=yd_GR_neMAs  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Portal menu structure
- Adding custom menu items
- Menu inheritance
- Menu icons and labels

### Key Concepts:
- Inherit from `portal.portal_my_home`
- Use `portal.portal_docs_entry` for menu items
- Menu items show record counts

### Practice:
- [ ] Add a custom menu item
- [ ] Display record count in menu
- [ ] Customize menu icon
- [ ] Test menu visibility

### Code Example:
```xml
<template id="portal_my_home_menu_custom" inherit_id="portal.portal_my_home">
    <xpath expr="//div[hasclass('o_portal_docs')]" position="inside">
        <t t-call="portal.portal_docs_entry">
            <t t-set="title">My Custom Records</t>
            <t t-set="url" t-value="'/my/custom'"/>
            <t t-set="placeholder_count" t-value="'custom_count'"/>
        </t>
    </xpath>
</template>
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 4: Portal Template Basics

**Video:** https://www.youtube.com/watch?v=SKHffx8ZWnQ  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- QWeb template basics
- Portal layout template
- Template inheritance
- Common portal elements

### Key Concepts:
- Use `t-call="portal.portal_layout"` for base layout
- Templates inherit from portal module
- QWeb expressions for dynamic content

### Practice:
- [ ] Create a basic portal template
- [ ] Inherit from portal.portal_layout
- [ ] Add custom content sections
- [ ] Test template rendering

### Code Example:
```xml
<template id="portal_my_custom" name="My Custom Portal">
    <t t-call="portal.portal_layout">
        <div class="container">
            <h3>My Custom Page</h3>
            <p>Portal content goes here</p>
        </div>
    </t>
</template>
```

### Notes:
_Add your notes here after watching the video_

---

## Phase 1 Summary

**Lessons Completed:** ___/4  
**Total Time Spent:** _____ hours  
**Key Takeaways:**
- 
- 
- 

**Next:** [Phase 2: Portal Views](../phase2_portal_views/LESSONS.md)

