# Phase 2: Portal Views - Lessons

All 4 lessons in Phase 2 with video links and key concepts.

---

## Lesson 5: Building List Views in Portal

**Video:** https://www.youtube.com/watch?v=EuvpTunZFPw  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Displaying lists of records
- Table formatting
- Card layouts
- Responsive design

### Key Concepts:
- Use `t-foreach` for iterating records
- Bootstrap classes for styling
- Show only user's own records

### Practice:
- [ ] Create list view for sale orders
- [ ] Display order name, date, amount
- [ ] Add links to detail views
- [ ] Style with Bootstrap cards

### Code Example:
```xml
<t t-foreach="orders" t-as="order">
    <div class="card mb-3">
        <div class="card-body">
            <h5 class="card-title">
                <a t-attf-href="/my/orders/{{order.id}}">
                    <t t-esc="order.name"/>
                </a>
            </h5>
            <p>Date: <span t-field="order.date_order"/></p>
            <p>Total: <span t-field="order.amount_total"/></p>
        </div>
    </div>
</t>
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 6: Creating Form Views

**Video:** https://www.youtube.com/watch?v=k6C0-ORWk6o  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- HTML forms in portal
- Form validation
- Handling form submissions
- CSRF protection

### Key Concepts:
- Use standard HTML forms
- POST to controller
- Validate input server-side
- Provide user feedback

### Practice:
- [ ] Create a contact form
- [ ] Add field validation
- [ ] Handle form submission
- [ ] Show success/error messages

### Code Example:
```python
@http.route(['/my/custom/submit'], type='http', auth='user', 
            methods=['POST'], website=True, csrf=True)
def portal_custom_submit(self, **post):
    """Handle form submission"""
    request.env['my.model'].create({
        'name': post.get('name'),
        'description': post.get('description'),
        'partner_id': request.env.user.partner_id.id,
    })
    return request.redirect('/my/custom?submitted=1')
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 7: Detail Views and Navigation

**Video:** https://www.youtube.com/watch?v=7hb5vJpiyKE  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Single record detail pages
- Navigation between pages
- Back buttons and links
- Related record display

### Key Concepts:
- Use route with record ID: `/my/orders/<int:order_id>`
- Check record ownership
- Display related records (lines, attachments)

### Practice:
- [ ] Create detail view for orders
- [ ] Show all order information
- [ ] Display order lines
- [ ] Add navigation links

### Code Example:
```python
@http.route(['/my/orders/<int:order_id>'], type='http', auth='user', website=True)
def portal_order_detail(self, order_id, **kw):
    """Display order details"""
    order = request.env['sale.order'].browse(order_id)
    
    # Check access
    if order.partner_id != request.env.user.partner_id:
        return request.redirect('/my')
    
    return request.render("my_module.portal_order_detail", {
        'order': order,
        'page_name': 'order',
    })
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 8: Breadcrumb Implementation

**Video:** https://www.youtube.com/watch?v=RLnoDLXgsZ8  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Adding breadcrumb navigation
- Breadcrumb structure
- Custom breadcrumb paths
- Active breadcrumb styling

### Key Concepts:
- Breadcrumbs improve navigation
- Show current location in hierarchy
- Provide quick navigation to parent pages

### Practice:
- [ ] Add breadcrumbs to list view
- [ ] Add breadcrumbs to detail view
- [ ] Customize breadcrumb text
- [ ] Test breadcrumb navigation

### Code Example:
```python
values = {
    'order': order,
    'breadcrumbs': [
        {'name': 'Home', 'url': '/my'},
        {'name': 'Orders', 'url': '/my/orders'},
        {'name': order.name},  # Current page (no URL)
    ],
}
```

### Notes:
_Add your notes here after watching the video_

---

## Phase 2 Summary

**Lessons Completed:** ___/4  
**Total Time Spent:** _____ hours  
**Key Takeaways:**
- 
- 
- 

**Previous:** [Phase 1: Introduction](../phase1_introduction/LESSONS.md)  
**Next:** [Phase 3: Functionality](../phase3_functionality/LESSONS.md)

