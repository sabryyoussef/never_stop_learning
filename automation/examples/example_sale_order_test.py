"""
Example: Complete Sale Order Test for Odoo
This demonstrates a full workflow test for creating and confirming a sale order.
"""

import pytest
from playwright.sync_api import Page, expect


@pytest.fixture(scope="function")
def logged_in_page(page: Page):
    """Fixture to provide a logged-in Odoo session"""
    # Navigate to Odoo
    page.goto("http://localhost:8069")
    
    # Login
    page.fill("input[name='login']", "admin")
    page.fill("input[name='password']", "admin")
    page.click("button[type='submit']")
    
    # Wait for successful login
    page.wait_for_selector(".o_main_navbar", timeout=10000)
    
    return page


def test_create_and_confirm_sale_order(logged_in_page: Page):
    """
    Complete test: Create a sale order, add products, and confirm it
    
    This test demonstrates:
    - Navigation through Odoo menus
    - Form field manipulation
    - Many2one field selection
    - One2many line creation
    - Button actions
    - State verification
    """
    page = logged_in_page
    
    # Step 1: Navigate to Sales module
    page.click("a.o_nav_entry:has-text('Sales')")
    page.wait_for_load_state("networkidle")
    
    # Step 2: Open Quotations
    page.click("a.o_nav_entry:has-text('Orders')")
    page.click("a.o_nav_entry:has-text('Quotations')")
    page.wait_for_selector(".o_list_view")
    
    # Step 3: Create new quotation
    page.click("button.o_list_button_add")
    page.wait_for_selector(".o_form_view")
    
    # Step 4: Select customer
    page.click("div[name='partner_id'] input")
    page.fill("div[name='partner_id'] input", "Azure Interior")
    page.wait_for_selector(".ui-autocomplete")
    page.click(".ui-autocomplete li:has-text('Azure Interior')")
    
    # Wait for customer details to load
    page.wait_for_load_state("networkidle")
    
    # Step 5: Add first product line
    page.click("a.o_field_x2many_list_row_add")
    
    # Select product
    page.click("div[name='product_id'] input")
    page.fill("div[name='product_id'] input", "Desk Combination")
    page.wait_for_selector(".ui-autocomplete")
    page.click(".ui-autocomplete li:has-text('Desk Combination')")
    
    # Set quantity
    page.fill("input[name='product_uom_qty']", "5")
    
    # Wait for price calculation
    page.wait_for_load_state("networkidle")
    
    # Step 6: Add second product line
    page.click("a.o_field_x2many_list_row_add")
    
    page.click("div[name='product_id'] input")
    page.fill("div[name='product_id'] input", "Office Chair")
    page.wait_for_selector(".ui-autocomplete")
    page.click(".ui-autocomplete li:has-text('Office Chair')")
    
    page.fill("input[name='product_uom_qty']", "10")
    page.wait_for_load_state("networkidle")
    
    # Step 7: Verify total amount is calculated
    total_amount = page.locator("span[name='amount_total']")
    expect(total_amount).not_to_be_empty()
    
    # Step 8: Save the quotation
    page.click("button.o_form_button_save")
    page.wait_for_selector(".o_form_readonly")
    
    # Step 9: Verify quotation is in draft state
    state_field = page.locator("span[name='state']")
    expect(state_field).to_contain_text("Quotation")
    
    # Step 10: Get quotation number for verification
    quotation_number = page.locator("span[name='name']").inner_text()
    print(f"Created quotation: {quotation_number}")
    
    # Step 11: Confirm the sale order
    page.click("button[name='action_confirm']")
    page.wait_for_load_state("networkidle")
    
    # Step 12: Verify state changed to Sale Order
    expect(state_field).to_contain_text("Sale Order")
    
    # Step 13: Verify success notification
    notification = page.locator(".o_notification.o_notification_success")
    expect(notification).to_be_visible(timeout=5000)
    
    # Step 14: Verify delivery order was created
    smart_button = page.locator("button.oe_stat_button:has-text('Delivery')")
    expect(smart_button).to_be_visible()
    
    print(f"✅ Sale order {quotation_number} confirmed successfully!")


def test_sale_order_with_discount(logged_in_page: Page):
    """Test creating a sale order with discounted products"""
    page = logged_in_page
    
    # Navigate to create new quotation
    page.goto("http://localhost:8069/web#model=sale.order&view_type=form")
    page.click("button.o_list_button_add")
    page.wait_for_selector(".o_form_view")
    
    # Select customer
    page.click("div[name='partner_id'] input")
    page.fill("div[name='partner_id'] input", "Deco Addict")
    page.wait_for_selector(".ui-autocomplete")
    page.click(".ui-autocomplete li:has-text('Deco Addict')")
    
    # Add product with discount
    page.click("a.o_field_x2many_list_row_add")
    page.click("div[name='product_id'] input")
    page.fill("div[name='product_id'] input", "Cabinet")
    page.wait_for_selector(".ui-autocomplete")
    page.click(".ui-autocomplete li:has-text('Cabinet')")
    
    # Set quantity and discount
    page.fill("input[name='product_uom_qty']", "3")
    page.fill("input[name='discount']", "10")
    
    page.wait_for_load_state("networkidle")
    
    # Save and verify
    page.click("button.o_form_button_save")
    page.wait_for_selector(".o_form_readonly")
    
    # Verify discount is applied
    discount_field = page.locator("span[name='discount']")
    expect(discount_field).to_contain_text("10")
    
    print("✅ Sale order with discount created successfully!")


def test_sale_order_validation(logged_in_page: Page):
    """Test form validation when required fields are missing"""
    page = logged_in_page
    
    # Navigate to create new quotation
    page.goto("http://localhost:8069/web#model=sale.order&view_type=form")
    page.click("button.o_list_button_add")
    page.wait_for_selector(".o_form_view")
    
    # Try to save without selecting customer (required field)
    page.click("button.o_form_button_save")
    
    # Verify validation error
    invalid_field = page.locator("div[name='partner_id'].o_field_invalid")
    expect(invalid_field).to_be_visible()
    
    # Verify error notification
    notification = page.locator(".o_notification.o_notification_danger")
    expect(notification).to_be_visible()
    expect(notification).to_contain_text("required")
    
    print("✅ Form validation working correctly!")


def test_cancel_sale_order(logged_in_page: Page):
    """Test canceling a draft sale order"""
    page = logged_in_page
    
    # Create a simple quotation
    page.goto("http://localhost:8069/web#model=sale.order&view_type=form")
    page.click("button.o_list_button_add")
    page.wait_for_selector(".o_form_view")
    
    # Select customer
    page.click("div[name='partner_id'] input")
    page.fill("div[name='partner_id'] input", "Azure Interior")
    page.wait_for_selector(".ui-autocomplete")
    page.click(".ui-autocomplete li:has-text('Azure Interior')")
    
    # Save
    page.click("button.o_form_button_save")
    page.wait_for_selector(".o_form_readonly")
    
    # Cancel the order
    page.click("button[name='action_cancel']")
    
    # Confirm cancellation in dialog (if appears)
    if page.locator(".modal-footer button.btn-primary").is_visible():
        page.click(".modal-footer button.btn-primary")
    
    page.wait_for_load_state("networkidle")
    
    # Verify state is cancelled
    state_field = page.locator("span[name='state']")
    expect(state_field).to_contain_text("Cancelled")
    
    print("✅ Sale order cancelled successfully!")


if __name__ == "__main__":
    pytest.main([__file__, "-v", "--headed"])

