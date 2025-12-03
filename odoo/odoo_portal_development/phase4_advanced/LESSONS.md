# Phase 4: Advanced Topics - Lessons

All 6 lessons in Phase 4 with video links and key concepts.

---

## Lesson 13: Creating Restricted Controllers

**Video:** https://www.youtube.com/watch?v=W0HPbGUWyTc  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Secure controller patterns
- Access token authentication
- Rate limiting
- Security best practices

### Key Concepts:
- Validate all inputs
- Check permissions explicitly
- Log security events
- Use CSRF protection

### Practice:
- [ ] Create secure controller
- [ ] Add access validation
- [ ] Implement access tokens
- [ ] Test security

### Notes:
_Add your notes here after watching the video_

---

## Lesson 14: Custom Portal Actions

**Video:** https://www.youtube.com/watch?v=sgnO1PiCs1Y  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- User-triggered actions
- Form submissions
- AJAX requests
- Action buttons

### Key Concepts:
- Handle POST requests
- Return JSON for AJAX
- Provide user feedback
- Handle errors gracefully

### Practice:
- [ ] Add action button to portal
- [ ] Implement action handler
- [ ] Add AJAX call
- [ ] Show success notification

### Code Example:
```python
@http.route(['/my/orders/<int:order_id>/cancel'], 
            type='json', auth='user', website=True)
def portal_order_cancel(self, order_id, **kw):
    """Cancel order via AJAX"""
    order = request.env['sale.order'].browse(order_id)
    
    if order.partner_id != request.env.user.partner_id:
        return {'error': 'Unauthorized'}
    
    if order.state not in ['draft', 'sent']:
        return {'error': 'Cannot cancel this order'}
    
    order.action_cancel()
    
    return {'success': True, 'message': 'Order cancelled'}
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 15: File Upload in Portal

**Video:** https://www.youtube.com/watch?v=yb0fYyZAwkU  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- File upload implementation
- Attachment handling
- File validation
- Security considerations

### Key Concepts:
- Use `request.httprequest.files`
- Create ir.attachment records
- Validate file type and size
- Link attachments to records

### Practice:
- [ ] Add file upload form
- [ ] Handle file upload
- [ ] Validate file types
- [ ] Display uploaded files

### Code Example:
```python
@http.route(['/my/tickets/<int:ticket_id>/upload'], 
            type='http', auth='user', methods=['POST'], website=True)
def portal_ticket_upload(self, ticket_id, **post):
    """Upload file to ticket"""
    ticket = request.env['helpdesk.ticket'].browse(ticket_id)
    
    # Check access
    if ticket.partner_id != request.env.user.partner_id:
        return request.redirect('/my')
    
    if 'file' in request.httprequest.files:
        file = request.httprequest.files['file']
        
        # Create attachment
        attachment = request.env['ir.attachment'].create({
            'name': file.filename,
            'datas': base64.b64encode(file.read()),
            'res_model': 'helpdesk.ticket',
            'res_id': ticket_id,
        })
        
        # Post message
        ticket.message_post(
            body=f"File uploaded: {file.filename}",
            attachment_ids=[attachment.id]
        )
    
    return request.redirect(f'/my/tickets/{ticket_id}')
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 16: Portal Notifications

**Video:** https://www.youtube.com/watch?v=7R6ZsZQou3I  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Email notifications
- In-portal notifications
- Activity tracking
- Message posting

### Key Concepts:
- Use `message_post()` for notifications
- Send emails with templates
- Track user activities
- Display notifications in portal

### Practice:
- [ ] Send email on portal action
- [ ] Display notifications
- [ ] Implement activity feed
- [ ] Test notification delivery

### Code Example:
```python
# Send email notification
order.message_post(
    body="Your order has been confirmed!",
    subject="Order Confirmation",
    message_type='notification',
    subtype_xmlid='mail.mt_comment',
    partner_ids=[order.partner_id.id],
)

# Send with email template
template = request.env.ref('my_module.email_template_order_confirm')
template.send_mail(order.id, force_send=True)
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 17: Portal Customization

**Video:** https://www.youtube.com/watch?v=f51AsDLBNnM  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Custom styling and branding
- CSS customization
- JavaScript integration
- UX improvements

### Key Concepts:
- Inherit portal templates
- Add custom CSS
- Use Bootstrap classes
- Implement custom JS functionality

### Practice:
- [ ] Customize portal colors/branding
- [ ] Add custom CSS
- [ ] Implement custom JS feature
- [ ] Improve mobile responsiveness

### Code Example:
```xml
<!-- Add custom CSS -->
<template id="portal_custom_assets" inherit_id="web.assets_frontend">
    <xpath expr="." position="inside">
        <link rel="stylesheet" href="/my_module/static/src/css/portal.css"/>
        <script type="text/javascript" src="/my_module/static/src/js/portal.js"/>
    </xpath>
</template>
```

### Notes:
_Add your notes here after watching the video_

---

## Lesson 18: Deployment and Best Practices

**Video:** https://www.youtube.com/watch?v=V7IIWWMX62k  
**Status:** ⬜ Not Started  
**Date:** _____

### Topics:
- Production deployment
- Security hardening
- Performance optimization
- Monitoring and maintenance
- Best practices summary

### Key Concepts:
- Always validate user input
- Use proper access control
- Optimize database queries
- Monitor portal usage
- Keep portal simple and focused

### Best Practices:
✅ **Security:**
- Always check record ownership
- Validate all inputs
- Use CSRF protection
- Log security events

✅ **Performance:**
- Use pagination for large datasets
- Optimize database queries
- Cache when appropriate
- Lazy load images

✅ **UX:**
- Keep interface simple
- Provide clear feedback
- Mobile-responsive design
- Fast page loads

### Practice:
- [ ] Review security checklist
- [ ] Optimize portal performance
- [ ] Test on mobile devices
- [ ] Deploy to staging environment
- [ ] Monitor portal usage

### Deployment Checklist:
- [ ] All routes have proper authentication
- [ ] Access control tested with multiple users
- [ ] Performance tested with large datasets
- [ ] Mobile responsiveness verified
- [ ] Error handling implemented
- [ ] Logging configured
- [ ] Backup procedures in place
- [ ] Monitoring tools setup

### Notes:
_Add your notes here after watching the video_

---

## Phase 4 Summary

**Lessons Completed:** ___/6  
**Total Time Spent:** _____ hours  
**Key Takeaways:**
- 
- 
- 

**Previous:** [Phase 3: Functionality](../phase3_functionality/LESSONS.md)  
**Course Complete!** 🎉

---

## 🎓 Course Completion

Congratulations on completing the Odoo Portal Development course!

**You now know how to:**
- Build custom portals from scratch
- Implement secure controllers
- Create user-friendly portal interfaces
- Handle file uploads and notifications
- Deploy portals to production

**Next Steps:**
- Build your own portal project
- Contribute to OCA portal modules
- Explore advanced portal features
- Share your knowledge with others

