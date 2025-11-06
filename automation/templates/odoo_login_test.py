"""
Odoo Login Test Template - Playwright
This template provides a reusable login test for Odoo applications.
"""

import pytest
from playwright.sync_api import Page, expect


class OdooLoginTest:
    """Base class for Odoo login tests"""
    
    # Configuration - Update these for your Odoo instance
    ODOO_URL = "http://localhost:8069"
    DATABASE = "your_database"
    USERNAME = "admin"
    PASSWORD = "admin"
    
    @pytest.fixture(scope="function")
    def login(self, page: Page):
        """
        Fixture to handle Odoo login before each test
        Usage: Add 'login' parameter to your test function
        """
        # Navigate to Odoo login page
        page.goto(self.ODOO_URL)
        
        # Wait for login form to load
        page.wait_for_selector("input[name='login']")
        
        # Fill in login credentials
        page.fill("input[name='login']", self.USERNAME)
        page.fill("input[name='password']", self.PASSWORD)
        
        # Click login button
        page.click("button[type='submit']")
        
        # Wait for successful login (main menu should appear)
        page.wait_for_selector(".o_main_navbar", timeout=10000)
        
        yield page
        
        # Logout after test (optional)
        # page.click(".o_user_menu")
        # page.click("a[data-menu='logout']")


def test_odoo_login_success(page: Page):
    """Test successful login to Odoo"""
    
    # Navigate to Odoo
    page.goto("http://localhost:8069")
    
    # Fill login form
    page.fill("input[name='login']", "admin")
    page.fill("input[name='password']", "admin")
    
    # Submit login
    page.click("button[type='submit']")
    
    # Assert successful login
    expect(page.locator(".o_main_navbar")).to_be_visible()
    expect(page).to_have_url("http://localhost:8069/web")


def test_odoo_login_invalid_credentials(page: Page):
    """Test login with invalid credentials"""
    
    # Navigate to Odoo
    page.goto("http://localhost:8069")
    
    # Fill with invalid credentials
    page.fill("input[name='login']", "invalid_user")
    page.fill("input[name='password']", "wrong_password")
    
    # Submit login
    page.click("button[type='submit']")
    
    # Assert error message appears
    expect(page.locator(".alert-danger")).to_be_visible()
    expect(page.locator(".alert-danger")).to_contain_text("Wrong login/password")


def test_odoo_login_empty_fields(page: Page):
    """Test login with empty fields"""
    
    # Navigate to Odoo
    page.goto("http://localhost:8069")
    
    # Try to submit without filling fields
    page.click("button[type='submit']")
    
    # Assert validation messages
    expect(page.locator("input[name='login']:invalid")).to_be_visible()
    expect(page.locator("input[name='password']:invalid")).to_be_visible()


if __name__ == "__main__":
    pytest.main([__file__, "-v"])

