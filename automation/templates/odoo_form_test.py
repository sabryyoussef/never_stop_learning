"""
Odoo Form Test Template - Playwright
This template provides reusable patterns for testing Odoo form views.
"""

import pytest
from playwright.sync_api import Page, expect


class OdooFormTest:
    """Base class for Odoo form tests"""
    
    ODOO_URL = "http://localhost:8069"
    
    @staticmethod
    def navigate_to_menu(page: Page, menu_path: list):
        """
        Navigate through Odoo menu structure
        
        Args:
            page: Playwright page object
            menu_path: List of menu items to click (e.g., ['Sales', 'Orders', 'Quotations'])
        """
        for menu_item in menu_path:
            page.click(f"a.o_nav_entry:has-text('{menu_item}')")
            page.wait_for_load_state("networkidle")
    
    @staticmethod
    def create_new_record(page: Page):
        """Click the 'Create' button in list view"""
        page.click("button.o_list_button_add")
        page.wait_for_selector(".o_form_view")
    
    @staticmethod
    def save_record(page: Page):
        """Click the 'Save' button in form view"""
        page.click("button.o_form_button_save")
        page.wait_for_selector(".o_form_readonly")
    
    @staticmethod
    def edit_record(page: Page):
        """Click the 'Edit' button in form view"""
        page.click("button.o_form_button_edit")
        page.wait_for_selector(".o_form_editable")
    
    @staticmethod
    def confirm_record(page: Page, button_name: str = "action_confirm"):
        """
        Click a confirmation button (like 'Confirm' on Sale Orders)
        
        Args:
            button_name: The name attribute of the button
        """
        page.click(f"button[name='{button_name}']")
        page.wait_for_load_state("networkidle")
    
    @staticmethod
    def fill_field(page: Page, field_name: str, value: str):
        """
        Fill a form field by field name
        
        Args:
            field_name: The name attribute of the field
            value: The value to fill
        """
        page.fill(f"input[name='{field_name}']", value)
    
    @staticmethod
    def select_dropdown(page: Page, field_name: str, option_text: str):
        """
        Select an option from a dropdown field
        
        Args:
            field_name: The name attribute of the field
            option_text: The text of the option to select
        """
        page.click(f"select[name='{field_name}']")
        page.click(f"option:has-text('{option_text}')")
    
    @staticmethod
    def select_many2one(page: Page, field_name: str, record_name: str):
        """
        Select a record in a Many2one field
        
        Args:
            field_name: The name attribute of the field
            record_name: The name of the record to select
        """
        # Click the Many2one field
        page.click(f"div[name='{field_name}'] input")
        
        # Type to search
        page.fill(f"div[name='{field_name}'] input", record_name)
        
        # Wait for dropdown and select
        page.wait_for_selector(".ui-autocomplete")
        page.click(f".ui-autocomplete li:has-text('{record_name}')")
    
    @staticmethod
    def assert_notification(page: Page, notification_type: str, message: str):
        """
        Assert that a notification appears with specific message
        
        Args:
            notification_type: 'success', 'warning', 'danger', or 'info'
            message: Expected message text
        """
        notification_selector = f".o_notification.o_notification_{notification_type}"
        expect(page.locator(notification_selector)).to_be_visible()
        expect(page.locator(notification_selector)).to_contain_text(message)
    
    @staticmethod
    def assert_field_value(page: Page, field_name: str, expected_value: str):
        """
        Assert that a field contains expected value
        
        Args:
            field_name: The name attribute of the field
            expected_value: Expected value
        """
        field_locator = page.locator(f"input[name='{field_name}']")
        expect(field_locator).to_have_value(expected_value)


def test_create_sale_order(page: Page):
    """Example: Test creating a Sale Order in Odoo"""
    
    # Login (assuming login fixture is available)
    page.goto("http://localhost:8069/web")
    
    # Navigate to Sales > Orders > Quotations
    OdooFormTest.navigate_to_menu(page, ["Sales", "Orders", "Quotations"])
    
    # Create new record
    OdooFormTest.create_new_record(page)
    
    # Fill customer field
    OdooFormTest.select_many2one(page, "partner_id", "Azure Interior")
    
    # Add product line
    page.click("a.o_field_x2many_list_row_add")
    OdooFormTest.select_many2one(page, "product_id", "Desk Combination")
    
    # Fill quantity
    OdooFormTest.fill_field(page, "product_uom_qty", "5")
    
    # Save the record
    OdooFormTest.save_record(page)
    
    # Assert success notification
    OdooFormTest.assert_notification(page, "success", "Sale Order created")
    
    # Confirm the order
    OdooFormTest.confirm_record(page, "action_confirm")
    
    # Assert state changed
    expect(page.locator(".o_field_widget[name='state']")).to_contain_text("Sale Order")


def test_edit_existing_record(page: Page):
    """Example: Test editing an existing record"""
    
    # Navigate to record
    page.goto("http://localhost:8069/web#id=1&model=sale.order&view_type=form")
    
    # Click Edit
    OdooFormTest.edit_record(page)
    
    # Modify field
    OdooFormTest.fill_field(page, "client_order_ref", "TEST-REF-001")
    
    # Save
    OdooFormTest.save_record(page)
    
    # Assert field updated
    OdooFormTest.assert_field_value(page, "client_order_ref", "TEST-REF-001")


def test_form_validation(page: Page):
    """Example: Test form validation"""
    
    # Navigate to form
    page.goto("http://localhost:8069/web#model=sale.order&view_type=form")
    
    # Create new
    OdooFormTest.create_new_record(page)
    
    # Try to save without required fields
    OdooFormTest.save_record(page)
    
    # Assert validation error
    expect(page.locator(".o_field_invalid")).to_be_visible()
    OdooFormTest.assert_notification(page, "danger", "required")


if __name__ == "__main__":
    pytest.main([__file__, "-v"])

