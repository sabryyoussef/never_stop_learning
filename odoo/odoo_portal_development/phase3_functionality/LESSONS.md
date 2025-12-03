# Phase 3: Portal Functionality - Lessons

All 4 lessons in Phase 3 with video links and key concepts.

---

## Lesson 9: Adding Pagination

**Video:** https://www.youtube.com/watch?v=-wvvSeMqfoM  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Implementing pagination
- Page navigation
- Handling large datasets
- Portal pager widget

### Key Concepts:
- Use `portal_pager()` function
- Set page size (e.g., 10, 20 records)
- Calculate offset for database queries
- Display page numbers

### Practice:
- [ ] Add pagination to list view
- [ ] Set page size to 10
- [ ] Test with 50+ records
- [ ] Style pagination controls

### Code Example:
```python
from odoo.addons.portal.controllers.portal import pager as portal_pager

@http.route(['/my/orders', '/my/orders/page/<int:page>'], 
            type='http', auth='user', website=True)
def portal_my_orders(self, page=1, **kw):
    Order = request.env['sale.order']
    partner = request.env.user.partner_id
    
    # Count total records
    order_count = Order.search_count([('partner_id', '=', partner.id)])
    
    # Pagination
    page_size = 10
    pager = portal_pager(
        url="/my/orders",
        total=order_count,
        page=page,
        step=page_size
    )
    
    # Get records for current page
    orders = Order.search([
        ('partner_id', '=', partner.id)
    ], limit=page_size, offset=pager['offset'])
    
    return request.render("template", {
        'orders': orders,
        'pager': pager,
    })
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 10: Search and Filtering

**Video:** https://www.youtube.com/watch?v=8V5XDIZHRb0  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Search functionality
- Filter implementation
- Sorting options
- Search bar integration

### Key Concepts:
- Use `portal.portal_searchbar` template
- Build dynamic search domains
- Provide multiple sort options
- Remember search state

### Practice:
- [ ] Add search bar to list view
- [ ] Implement search by name
- [ ] Add sort by date/name/amount
- [ ] Add filter by status

### Code Example:
```python
@http.route(['/my/orders'], type='http', auth='user', website=True)
def portal_my_orders(self, sortby=None, search=None, filterby=None, **kw):
    # Sort options
    searchbar_sortings = {
        'date': {'label': 'Newest', 'order': 'date_order desc'},
        'name': {'label': 'Name', 'order': 'name'},
        'amount': {'label': 'Amount', 'order': 'amount_total desc'},
    }
    
    # Search options
    searchbar_inputs = {
        'all': {'input': 'all', 'label': 'Search in All'},
        'name': {'input': 'name', 'label': 'Search in Order'},
    }
    
    # Filter options
    searchbar_filters = {
        'all': {'label': 'All', 'domain': []},
        'draft': {'label': 'Quotations', 'domain': [('state', '=', 'draft')]},
        'confirmed': {'label': 'Confirmed', 'domain': [('state', '=', 'sale')]},
    }
    
    # Build domain
    domain = [('partner_id', '=', request.env.user.partner_id.id)]
    if filterby and filterby in searchbar_filters:
        domain += searchbar_filters[filterby]['domain']
    
    if search and search_in:
        domain += [(search_in, 'ilike', search)]
    
    # Get orders
    orders = request.env['sale.order'].search(
        domain,
        order=searchbar_sortings.get(sortby, searchbar_sortings['date'])['order']
    )
    
    return request.render("template", {
        'orders': orders,
        'searchbar_sortings': searchbar_sortings,
        'sortby': sortby,
        'searchbar_inputs': searchbar_inputs,
        'search_in': search_in,
        'search': search,
        'searchbar_filters': searchbar_filters,
        'filterby': filterby,
    })
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 11: Portal User Authentication

**Video:** https://www.youtube.com/watch?v=OpkzzcPlP5o  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Portal user authentication
- Login/logout flow
- Session management
- Password management

### Key Concepts:
- Use `auth='user'` in routes
- Portal users are in `base.group_portal`
- Automatic redirect to login if not authenticated

### Practice:
- [ ] Test login flow
- [ ] Create portal user
- [ ] Test access with/without login
- [ ] Implement logout functionality

### Code Example:
```python
# Routes with different auth levels
@http.route(['/my/public'], type='http', auth='public', website=True)
def portal_public(self):
    """Accessible without login"""
    return request.render("template")

@http.route(['/my/private'], type='http', auth='user', website=True)
def portal_private(self):
    """Requires login"""
    return request.render("template")
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 12: Access Control and Permissions

**Video:** https://www.youtube.com/watch?v=0-7hkQOvqz8  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Record-level access control
- Record rules for portal
- Checking record ownership
- Preventing unauthorized access

### Key Concepts:
- Always check if user owns the record
- Use ir.rule for automatic filtering
- Redirect unauthorized users
- Log access attempts

### Practice:
- [ ] Create record rule for portal users
- [ ] Test access control
- [ ] Implement ownership check
- [ ] Test with multiple users

### Code Example:
```python
def portal_order_detail(self, order_id, **kw):
    """Display order - with access control"""
    order = request.env['sale.order'].browse(order_id)
    
    # Check ownership
    if not order.exists() or order.partner_id != request.env.user.partner_id:
        return request.redirect('/my')
    
    return request.render("template", {'order': order})
```

```xml
<!-- Record rule for portal users -->
<record id="portal_rule_sale_order" model="ir.rule">
    <field name="name">Portal: Sale Order - Own Orders Only</field>
    <field name="model_id" ref="sale.model_sale_order"/>
    <field name="domain_force">[('partner_id', '=', user.partner_id.id)]</field>
    <field name="groups" eval="[(4, ref('base.group_portal'))]"/>
</record>
```

### Notes:
_Add your notes here after watching the video_

---

## Phase 3 Summary

**Lessons Completed:** ___/4  
**Total Time Spent:** _____ hours  
**Key Takeaways:**
- 
- 
- 

**Previous:** [Phase 2: Portal Views](../phase2_portal_views/LESSONS.md)  
**Next:** [Phase 4: Advanced Topics](../phase4_advanced/LESSONS.md)

