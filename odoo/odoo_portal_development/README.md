# Odoo Portal Development Learning Path

**Playlist:** [Odoo Portal Development](https://www.youtube.com/playlist?list=PLAR8TpPnVeTT21BZYQRfocC8MXh-fP6Ij)  
**Channel:** Weblearns  
**Total Lessons:** 18  
**Status:** 🆕 Not Started  
**Date Created:** 2025-12-03

---

## 📚 Overview

This comprehensive learning path covers Odoo Portal Development - creating custom portals that allow external users (customers, partners, suppliers) to access specific Odoo data and functionality through a web interface.

### What is Odoo Portal?

Odoo Portal is a frontend interface that allows external users to:
- View their orders, invoices, and documents
- Submit requests and forms
- Track delivery status
- Access personalized content
- Interact with the Odoo system without backend access

---

## 🎯 Learning Objectives

By completing this learning path, you will:

- Understand Odoo Portal architecture
- Create custom portal menus and views
- Implement list and form views in portals
- Add breadcrumb navigation
- Implement pagination for large datasets
- Create restricted controllers for security
- Deploy portals to production
- Master portal customization techniques

---

## 📖 Course Structure (18 Lessons)

### Phase 1: Introduction & Setup (Lessons 1-4)
1. **Overview of Odoo Portal Features**
2. **Setting Up Development Environment**
3. **Creating Custom Portal Menus**
4. **Portal Template Basics**

### Phase 2: Portal Views (Lessons 5-8)
5. **Building List Views in Portal**
6. **Creating Form Views**
7. **Detail Views and Navigation**
8. **Breadcrumb Implementation**

### Phase 3: Portal Functionality (Lessons 9-12)
9. **Adding Pagination**
10. **Search and Filtering**
11. **Portal User Authentication**
12. **Access Control and Permissions**

### Phase 4: Advanced Topics (Lessons 13-18)
13. **Creating Restricted Controllers**
14. **Custom Portal Actions**
15. **File Upload in Portal**
16. **Portal Notifications**
17. **Portal Customization**
18. **Deployment and Best Practices**

---

## 🗂️ Folder Structure

```
odoo_portal_development/
├── README.md                     # This file
├── LEARNING_PLAN.md             # Detailed learning plan
├── PROGRESS_TRACKER.md          # Track your progress
├── QUICK_REFERENCE.md           # Quick reference guide
├── phase1_introduction/         # Phase 1 lessons
│   ├── README.md
│   ├── lesson_01.md
│   ├── lesson_02.md
│   ├── lesson_03.md
│   └── lesson_04.md
├── phase2_portal_views/         # Phase 2 lessons
│   ├── README.md
│   ├── lesson_05.md
│   ├── lesson_06.md
│   ├── lesson_07.md
│   └── lesson_08.md
├── phase3_functionality/        # Phase 3 lessons
│   ├── README.md
│   ├── lesson_09.md
│   ├── lesson_10.md
│   ├── lesson_11.md
│   └── lesson_12.md
└── phase4_advanced/             # Phase 4 lessons
    ├── README.md
    ├── lesson_13.md
    ├── lesson_14.md
    ├── lesson_15.md
    ├── lesson_16.md
    ├── lesson_17.md
    └── lesson_18.md
```

---

## 🚀 Getting Started

1. **Prerequisites:**
   - Basic Odoo module development knowledge
   - Understanding of Odoo ORM
   - Familiarity with Python and QWeb templates
   - Basic web development (HTML, CSS, JavaScript)

2. **Recommended Learning Path:**
   - Complete Odoo ORM Methods playlist first
   - Follow lessons in order
   - Practice with each lesson
   - Build the practice projects

3. **Practice Projects:**
   - Create a customer order portal
   - Build a support ticket portal
   - Develop a document management portal

---

## 📝 Key Concepts

### Portal Architecture

```
┌─────────────────────────────────────┐
│   External Users (Customers)        │
│   (Portal Access)                   │
└─────────────┬───────────────────────┘
              │
              │ HTTPS
              ▼
┌─────────────────────────────────────┐
│   Odoo Portal Controllers            │
│   - Authentication                   │
│   - Access Control                   │
│   - Data Filtering                   │
└─────────────┬───────────────────────┘
              │
              │ ORM
              ▼
┌─────────────────────────────────────┐
│   Odoo Models & Database             │
│   - sale.order                       │
│   - account.move (invoices)          │
│   - Custom models                    │
└─────────────────────────────────────┘
```

### Common Portal Use Cases

- **Customer Portal:** Orders, invoices, delivery tracking
- **Partner Portal:** Contracts, documents, reports
- **Supplier Portal:** Purchase orders, RFQs
- **Support Portal:** Tickets, knowledge base
- **Employee Portal:** Leave requests, timesheets

---

## 🔗 Related Topics

- Odoo Controllers
- QWeb Templates
- Portal User Management
- Access Rights
- Website Development
- Security

---

## 📚 Additional Resources

- [Odoo Portal Documentation](https://www.odoo.com/documentation/17.0/developer/reference/backend/http.html#portal)
- [QWeb Templates](https://www.odoo.com/documentation/17.0/developer/reference/frontend/qweb.html)
- [Odoo Controllers](https://www.odoo.com/documentation/17.0/developer/reference/backend/http.html)

---

## ✅ Progress Tracking

- [ ] Phase 1: Introduction & Setup (0/4 lessons)
- [ ] Phase 2: Portal Views (0/4 lessons)
- [ ] Phase 3: Functionality (0/4 lessons)
- [ ] Phase 4: Advanced Topics (0/6 lessons)

---

**Start Date:** _____  
**Completion Date:** _____  
**Total Time Spent:** _____ hours

**Estimated Total Time:** 30-40 hours  
**Skill Level After Completion:** Intermediate to Advanced

