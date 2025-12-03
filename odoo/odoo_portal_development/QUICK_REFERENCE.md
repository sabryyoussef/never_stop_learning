# Odoo Portal Development - Quick Reference

Quick reference for Odoo Portal development concepts and patterns.

---

## 📋 Portal Basics

### Portal Controller Template

```python
from odoo import http
from odoo.http import request
from odoo.addons.portal.controllers.portal import CustomerPortal

class MyPortal(CustomerPortal):
    
    @http.route(['/my/custom'], type='http', auth='user', website=True)
    def portal_my_custom(self, **kw):
        """Custom portal page"""
        values = self._prepare_portal_layout_values()
        
        # Get user's records
        records = request.env['my.model'].search([
            ('partner_id', '=', request.env.user.partner_id.id)
        ])
        
        values.update({
            'records': records,
            'page_name': 'my_custom',
        })
        
        return request.render("my_module.portal_my_custom", values)
```

### Portal Template Structure

```xml
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <template id="portal_my_custom" name="My Custom Portal">
        <t t-call="portal.portal_layout">
            <t t-set="breadcrumbs_searchbar" t-value="True"/>
            
            <t t-call="portal.portal_searchbar">
                <t t-set="title">My Records</t>
            </t>
            
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <t t-foreach="records" t-as="record">
                            <div class="card mb-3">
                                <div class="card-body">
                                    <h5 class="card-title" t-field="record.name"/>
                                    <p t-field="record.description"/>
                                </div>
                            </div>
                        </t>
                    </div>
                </div>
            </div>
        </t>
    </template>
</odoo>
```

---

## 🛣️ Common Portal Routes

```python
# List view
@http.route(['/my/orders'], type='http', auth='user', website=True)
def portal_my_orders(self, page=1, **kw):
    """Display user's orders"""
    pass

# Detail view
@http.route(['/my/orders/<int:order_id>'], type='http', auth='user', website=True)
def portal_order_detail(self, order_id, **kw):
    """Display single order"""
    pass

# Download action
@http.route(['/my/orders/<int:order_id>/download'], type='http', auth='user')
def portal_order_download(self, order_id, **kw):
    """Download order PDF"""
    pass
```

---

## 🔒 Access Control

### Check Access Rights

```python
def portal_order_detail(self, order_id, **kw):
    order = request.env['sale.order'].browse(order_id)
    
    # Check if user owns the record
    if order.partner_id != request.env.user.partner_id:
        return request.redirect('/my')
    
    # Or use exists() method
    order = request.env['sale.order'].sudo().browse(order_id)
    if not order.exists() or order.partner_id != request.env.user.partner_id:
        return request.redirect('/my')
    
    # Render page
    return request.render("template", {'order': order})
```

### Record Rules for Portal

```xml
<!-- ir.rule for portal access -->
<record id="portal_rule_my_model" model="ir.rule">
    <field name="name">Portal: My Model - Own Records</field>
    <field name="model_id" ref="model_my_model"/>
    <field name="domain_force">[('partner_id', '=', user.partner_id.id)]</field>
    <field name="groups" eval="[(4, ref('base.group_portal'))]"/>
</record>
```

---

## 📄 Portal Menu Items

### Add Menu in portal_templates.xml

```xml
<template id="portal_my_home_menu_custom" name="Portal My Home : custom menu" 
          inherit_id="portal.portal_my_home" priority="20">
    <xpath expr="//div[hasclass('o_portal_docs')]" position="inside">
        <t t-call="portal.portal_docs_entry">
            <t t-set="title">My Custom Records</t>
            <t t-set="url" t-value="'/my/custom'"/>
            <t t-set="placeholder_count" t-value="'custom_count'"/>
        </t>
    </xpath>
</template>
```

---

## 🔍 Pagination Pattern

```python
from odoo.addons.portal.controllers.portal import pager as portal_pager

@http.route(['/my/orders', '/my/orders/page/<int:page>'], 
            type='http', auth='user', website=True)
def portal_my_orders(self, page=1, **kw):
    Order = request.env['sale.order']
    partner = request.env.user.partner_id
    
    # Get total count
    order_count = Order.search_count([
        ('partner_id', '=', partner.id)
    ])
    
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
    
    values = {
        'orders': orders,
        'pager': pager,
    }
    
    return request.render("my_module.portal_my_orders", values)
```

---

## 🔎 Search and Filter Pattern

```python
@http.route(['/my/orders'], type='http', auth='user', website=True)
def portal_my_orders(self, sortby=None, search=None, search_in='content', **kw):
    searchbar_sortings = {
        'date': {'label': 'Newest', 'order': 'date_order desc'},
        'name': {'label': 'Name', 'order': 'name'},
    }
    
    searchbar_inputs = {
        'content': {'input': 'content', 'label': 'Search in All'},
        'name': {'input': 'name', 'label': 'Search in Name'},
    }
    
    # Default sort
    if not sortby:
        sortby = 'date'
    
    # Build domain
    domain = [('partner_id', '=', request.env.user.partner_id.id)]
    
    if search and search_in:
        domain += [(search_in, 'ilike', search)]
    
    # Get orders
    orders = request.env['sale.order'].search(
        domain,
        order=searchbar_sortings[sortby]['order']
    )
    
    values = {
        'orders': orders,
        'searchbar_sortings': searchbar_sortings,
        'searchbar_inputs': searchbar_inputs,
        'sortby': sortby,
        'search_in': search_in,
        'search': search,
    }
    
    return request.render("my_module.portal_my_orders", values)
```

---

## 📤 File Upload Pattern

```python
@http.route(['/my/tickets/<int:ticket_id>/upload'], 
            type='http', auth='user', methods=['POST'], website=True, csrf=False)
def portal_ticket_upload(self, ticket_id, **post):
    """Upload file to ticket"""
    ticket = request.env['helpdesk.ticket'].sudo().browse(ticket_id)
    
    # Check access
    if ticket.partner_id != request.env.user.partner_id:
        return request.redirect('/my')
    
    # Handle file upload
    if 'file' in request.httprequest.files:
        file = request.httprequest.files['file']
        
        # Create attachment
        attachment = request.env['ir.attachment'].sudo().create({
            'name': file.filename,
            'datas': base64.b64encode(file.read()),
            'res_model': 'helpdesk.ticket',
            'res_id': ticket_id,
        })
        
        # Post message
        ticket.sudo().message_post(
            body=f"File uploaded: {file.filename}",
            attachment_ids=[attachment.id]
        )
    
    return request.redirect(f'/my/tickets/{ticket_id}')
```

---

## 🔔 Portal Layout Values

```python
def _prepare_portal_layout_values(self):
    """Standard portal layout values"""
    values = super()._prepare_portal_layout_values()
    
    partner = request.env.user.partner_id
    
    # Add custom counts
    values.update({
        'custom_count': request.env['my.model'].search_count([
            ('partner_id', '=', partner.id)
        ]),
    })
    
    return values
```

---

## 🎨 Portal Template Patterns

### List View Template

```xml
<template id="portal_my_custom_list" name="My Custom List">
    <t t-call="portal.portal_layout">
        <t t-set="breadcrumbs_searchbar" t-value="True"/>
        
        <t t-call="portal.portal_searchbar">
            <t t-set="title">My Records</t>
        </t>
        
        <div class="container">
            <div class="row">
                <t t-if="not records">
                    <p class="alert alert-info">No records found.</p>
                </t>
                <t t-else="">
                    <t t-foreach="records" t-as="record">
                        <div class="col-12 col-md-6 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <a t-attf-href="/my/custom/{{record.id}}">
                                            <t t-esc="record.name"/>
                                        </a>
                                    </h5>
                                    <p class="card-text" t-field="record.description"/>
                                </div>
                            </div>
                        </div>
                    </t>
                </t>
            </div>
            
            <!-- Pagination -->
            <div t-if="pager" class="o_portal_pager mt-4">
                <t t-call="portal.pager"/>
            </div>
        </div>
    </t>
</template>
```

### Detail View Template

```xml
<template id="portal_my_custom_detail" name="My Custom Detail">
    <t t-call="portal.portal_layout">
        <t t-set="o_portal_fullwidth_alert" groups="sale.group_sale_salesman">
            <t t-call="portal.portal_back_in_edit_mode">
                <t t-set="backend_url" t-value="'/web#model=my.model&amp;id=%s&amp;view_type=form' % (record.id)"/>
            </t>
        </t>

        <div class="container">
            <div class="card">
                <div class="card-header">
                    <h4><t t-esc="record.name"/></h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <strong>Date:</strong> <span t-field="record.date"/>
                        </div>
                        <div class="col-md-6">
                            <strong>Status:</strong> <span t-field="record.state"/>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-12">
                            <strong>Description:</strong>
                            <p t-field="record.description"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </t>
</template>
```

---

## 🎯 Common Patterns

### Pattern 1: Portal User Check

```python
def _document_check_access(self, model_name, document_id, access_token=None):
    """Check if current user can access document"""
    document = request.env[model_name].browse([document_id])
    document_sudo = document.sudo().exists()
    
    if not document_sudo:
        return False
    
    # Check access
    try:
        document.check_access_rights('read')
        document.check_access_rule('read')
    except:
        return False
    
    return document_sudo
```

### Pattern 2: Portal Counter

```python
def _prepare_portal_layout_values(self):
    values = super()._prepare_portal_layout_values()
    
    MyModel = request.env['my.model']
    custom_count = MyModel.search_count([
        ('partner_id', '=', request.env.user.partner_id.id)
    ])
    
    values['custom_count'] = custom_count
    return values
```

### Pattern 3: Breadcrumb Navigation

```python
def portal_order_detail(self, order_id, **kw):
    order = request.env['sale.order'].browse(order_id)
    
    values = {
        'order': order,
        'page_name': 'order',
        'breadcrumbs': [
            {'name': 'Home', 'url': '/my'},
            {'name': 'Orders', 'url': '/my/orders'},
            {'name': order.name, 'url': f'/my/orders/{order_id}'},
        ],
    }
    
    return request.render("template", values)
```

---

## 🔗 Quick Links

- [Portal Module](https://github.com/odoo/odoo/tree/17.0/addons/portal)
- [Website Module](https://github.com/odoo/odoo/tree/17.0/addons/website)
- [QWeb Documentation](https://www.odoo.com/documentation/17.0/developer/reference/frontend/qweb.html)

---

**Last Updated:** 2025-12-03

