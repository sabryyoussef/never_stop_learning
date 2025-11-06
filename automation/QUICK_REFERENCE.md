# 🚀 Quick Reference Guide - Odoo Automation Testing

A cheat sheet for common Odoo testing patterns and commands.

---

## 📋 Common Pytest Commands

```bash
# Run all tests
pytest

# Run specific file
pytest tests/test_sale_order.py

# Run specific test
pytest tests/test_sale_order.py::test_create_order

# Run with markers
pytest -m smoke
pytest -m "not slow"

# Run in headed mode (see browser)
pytest --headed

# Run with specific browser
pytest --browser=chromium
pytest --browser=firefox
pytest --browser=webkit

# Debug mode
PWDEBUG=1 pytest tests/test_sale_order.py

# Generate HTML report
pytest --html=report.html

# Run in parallel (requires pytest-xdist)
pytest -n auto

# Verbose output
pytest -v

# Show print statements
pytest -s

# Stop on first failure
pytest -x

# Run last failed tests
pytest --lf
```

---

## 🎭 Common Playwright Patterns for Odoo

### Login

```python
def login(page: Page, username: str = "admin", password: str = "admin"):
    page.goto("http://localhost:8069")
    page.fill("input[name='login']", username)
    page.fill("input[name='password']", password)
    page.click("button[type='submit']")
    page.wait_for_selector(".o_main_navbar")
```

### Navigate Menu

```python
# Navigate to Sales > Orders > Quotations
page.click("a.o_nav_entry:has-text('Sales')")
page.click("a.o_nav_entry:has-text('Orders')")
page.click("a.o_nav_entry:has-text('Quotations')")
```

### Create New Record

```python
page.click("button.o_list_button_add")
page.wait_for_selector(".o_form_view")
```

### Save Record

```python
page.click("button.o_form_button_save")
page.wait_for_selector(".o_form_readonly")
```

### Edit Record

```python
page.click("button.o_form_button_edit")
page.wait_for_selector(".o_form_editable")
```

### Fill Many2one Field

```python
# Select customer
page.click("div[name='partner_id'] input")
page.fill("div[name='partner_id'] input", "Azure Interior")
page.wait_for_selector(".ui-autocomplete")
page.click(".ui-autocomplete li:has-text('Azure Interior')")
```

### Add One2many Line

```python
# Add product line
page.click("a.o_field_x2many_list_row_add")
page.click("div[name='product_id'] input")
page.fill("div[name='product_id'] input", "Desk")
page.wait_for_selector(".ui-autocomplete")
page.click(".ui-autocomplete li:has-text('Desk')")
```

### Confirm/Action Button

```python
page.click("button[name='action_confirm']")
page.wait_for_load_state("networkidle")
```

### Assert Notification

```python
from playwright.sync_api import expect

# Success notification
notification = page.locator(".o_notification.o_notification_success")
expect(notification).to_be_visible()

# Error notification
error = page.locator(".o_notification.o_notification_danger")
expect(error).to_contain_text("error message")
```

### Assert Field Value

```python
from playwright.sync_api import expect

# Assert input value
expect(page.locator("input[name='name']")).to_have_value("SO001")

# Assert text content
expect(page.locator("span[name='state']")).to_contain_text("Sale Order")
```

---

## 🔍 Common Odoo Selectors

### Buttons

```python
# Create button
"button.o_list_button_add"

# Save button
"button.o_form_button_save"

# Edit button
"button.o_form_button_edit"

# Discard button
"button.o_form_button_cancel"

# Action buttons
"button[name='action_confirm']"
"button[name='action_cancel']"
"button[name='action_done']"

# Smart buttons
"button.oe_stat_button"
```

### Form Fields

```python
# Input field by name
"input[name='field_name']"

# Text area
"textarea[name='field_name']"

# Select/dropdown
"select[name='field_name']"

# Many2one field
"div[name='field_name'] input"

# Checkbox
"input[type='checkbox'][name='field_name']"

# Date field
"input[name='field_name'][type='text'].o_datepicker_input"
```

### Views

```python
# List view
".o_list_view"

# Form view
".o_form_view"

# Kanban view
".o_kanban_view"

# Calendar view
".o_calendar_view"

# Form in edit mode
".o_form_editable"

# Form in readonly mode
".o_form_readonly"
```

### Notifications

```python
# Any notification
".o_notification"

# Success
".o_notification.o_notification_success"

# Warning
".o_notification.o_notification_warning"

# Error
".o_notification.o_notification_danger"

# Info
".o_notification.o_notification_info"
```

### Navigation

```python
# Main navbar
".o_main_navbar"

# Menu entry
"a.o_nav_entry"

# Specific menu
"a.o_nav_entry:has-text('Sales')"

# Breadcrumb
".breadcrumb"
```

---

## 🌐 Odoo API Testing Patterns

### Authentication

```python
import requests

session = requests.Session()
response = session.post(
    "http://localhost:8069/web/session/authenticate",
    json={
        "jsonrpc": "2.0",
        "params": {
            "db": "your_database",
            "login": "admin",
            "password": "admin"
        }
    }
)
```

### Search Records

```python
response = session.post(
    "http://localhost:8069/web/dataset/call_kw",
    json={
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
            "model": "sale.order",
            "method": "search",
            "args": [[["state", "=", "draft"]]],
            "kwargs": {"limit": 10}
        }
    }
)
```

### Create Record

```python
response = session.post(
    "http://localhost:8069/web/dataset/call_kw",
    json={
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
            "model": "sale.order",
            "method": "create",
            "args": [{
                "partner_id": 1,
                "date_order": "2025-11-06"
            }],
            "kwargs": {}
        }
    }
)
```

---

## ⏱️ Wait Strategies

```python
# Wait for selector
page.wait_for_selector(".o_form_view", timeout=10000)

# Wait for load state
page.wait_for_load_state("networkidle")
page.wait_for_load_state("domcontentloaded")

# Wait for URL
page.wait_for_url("**/web#*")

# Wait for function
page.wait_for_function("document.readyState === 'complete'")

# Wait for timeout (avoid if possible)
page.wait_for_timeout(1000)

# Auto-waiting (built into most actions)
page.click("button")  # Automatically waits for element
page.fill("input", "text")  # Automatically waits
```

---

## 🎯 Pytest Fixtures

### Basic Login Fixture

```python
import pytest
from playwright.sync_api import Page

@pytest.fixture(scope="function")
def logged_in_page(page: Page):
    page.goto("http://localhost:8069")
    page.fill("input[name='login']", "admin")
    page.fill("input[name='password']", "admin")
    page.click("button[type='submit']")
    page.wait_for_selector(".o_main_navbar")
    return page
```

### API Client Fixture

```python
import pytest
from odoo_api_client import OdooAPIClient

@pytest.fixture(scope="session")
def odoo_api():
    client = OdooAPIClient(
        url="http://localhost:8069",
        db="your_database",
        username="admin",
        password="admin"
    )
    client.authenticate()
    return client
```

---

## 🏷️ Pytest Markers

```python
# Mark as smoke test
@pytest.mark.smoke
def test_login():
    pass

# Mark as slow test
@pytest.mark.slow
def test_bulk_import():
    pass

# Mark as UI test
@pytest.mark.ui
def test_form_view():
    pass

# Mark as API test
@pytest.mark.api
def test_endpoint():
    pass

# Skip test
@pytest.mark.skip(reason="Not implemented yet")
def test_future_feature():
    pass

# Skip conditionally
@pytest.mark.skipif(condition, reason="Reason")
def test_conditional():
    pass

# Expected to fail
@pytest.mark.xfail
def test_known_bug():
    pass
```

---

## 📸 Screenshots and Videos

```python
# Take screenshot
page.screenshot(path="screenshot.png")

# Screenshot of specific element
element = page.locator(".o_form_view")
element.screenshot(path="form.png")

# Full page screenshot
page.screenshot(path="full.png", full_page=True)

# Videos are automatically recorded if configured in playwright.config.js
```

---

## 🔧 Debugging Tips

```bash
# Run with Playwright inspector
PWDEBUG=1 pytest test_file.py

# Run in headed mode with slow motion
pytest --headed --slowmo=1000

# Show browser console logs
pytest -s  # Shows print statements

# Use breakpoint in code
def test_something(page):
    page.goto("http://localhost:8069")
    breakpoint()  # Pauses here
    page.click("button")
```

---

## 📊 Test Organization

```python
# Group tests in class
class TestSaleOrder:
    def test_create(self, logged_in_page):
        pass
    
    def test_confirm(self, logged_in_page):
        pass
    
    def test_cancel(self, logged_in_page):
        pass

# Use parametrize for multiple test cases
@pytest.mark.parametrize("quantity,expected", [
    (1, 100),
    (5, 500),
    (10, 1000),
])
def test_price_calculation(quantity, expected, page):
    pass
```

---

## 🎓 Best Practices

1. **Use stable selectors** - Prefer data attributes over classes
2. **Wait properly** - Use explicit waits, not sleep()
3. **Keep tests independent** - Each test should work alone
4. **Use fixtures** - Reuse common setup code
5. **Name tests clearly** - Use descriptive names
6. **Test one thing** - Each test should verify one behavior
7. **Clean up** - Remove test data after tests
8. **Handle flakiness** - Add proper waits and retries

---

**Quick Reference Version:** 1.0  
**Last Updated:** 2025-11-06

