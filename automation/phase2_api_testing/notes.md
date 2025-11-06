# Phase 2: API Testing (Odoo Controller Verification) - Notes

## 📚 Learning Objectives
- Master Postman for API testing
- Validate JSON responses from Odoo controllers
- Create reusable API test collections

---

## 🎥 Video 1: Introduction to Postman

**Video Link:** https://www.youtube.com/watch?v=juldrxDrSH0  
**Status:** ⬜ Not Watched  
**Date Watched:** _____

### Key Takeaways
- 
- 
- 

### Odoo-Specific Applications
- Testing `/api/delivery_orders` endpoint
- Testing `/api/sale_orders` endpoint
- Authentication with Odoo API

### Action Items
- [ ] Install Postman
- [ ] Create workspace for Odoo project
- [ ] 

---

## 🎥 Video 2: Create First API Request

**Video Link:** https://www.youtube.com/watch?v=cR_FqveTewo  
**Status:** ⬜ Not Watched  
**Date Watched:** _____

### Key Takeaways
- 
- 
- 

### Odoo-Specific Applications
- 
- 

### Action Items
- [ ] Create GET request for Odoo endpoint
- [ ] Validate response structure
- [ ] 

---

## 📋 Phase Deliverable

**Task:** Create Postman collection for Odoo API endpoints

### Collection Structure:
```
Odoo API Tests/
├── Authentication/
│   ├── Login
│   └── Get Session Info
├── Sales Orders/
│   ├── Create Sale Order
│   ├── Get Sale Order
│   └── Update Sale Order
├── Delivery Orders/
│   ├── Create Delivery
│   └── Get Delivery Status
└── Custom Endpoints/
    └── [Your custom endpoints]
```

### Endpoints to Test:
1. **Authentication:**
   - POST `/web/session/authenticate`
   
2. **Sales Orders:**
   - GET `/api/sale_orders`
   - POST `/api/sale_orders`
   
3. **Custom Module Endpoints:**
   - 
   - 

---

## 💡 Odoo API Tips
- Use session cookies for authentication
- Include CSRF tokens in POST requests
- Test both JSON-RPC and REST endpoints

## ❓ Questions to Research
- How to handle Odoo session management in Postman?
- What are the common response codes from Odoo?
- 

