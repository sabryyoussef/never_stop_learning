"""
Odoo API Test Template - Python Requests
This template provides patterns for testing Odoo REST/JSON-RPC APIs.
"""

import requests
import json
import pytest


class OdooAPIClient:
    """Client for interacting with Odoo API"""
    
    def __init__(self, url: str, db: str, username: str, password: str):
        """
        Initialize Odoo API client
        
        Args:
            url: Odoo server URL (e.g., 'http://localhost:8069')
            db: Database name
            username: Login username
            password: Login password
        """
        self.url = url
        self.db = db
        self.username = username
        self.password = password
        self.session = requests.Session()
        self.uid = None
        
    def authenticate(self):
        """Authenticate and get user ID"""
        endpoint = f"{self.url}/web/session/authenticate"
        
        payload = {
            "jsonrpc": "2.0",
            "params": {
                "db": self.db,
                "login": self.username,
                "password": self.password
            }
        }
        
        response = self.session.post(endpoint, json=payload)
        result = response.json()
        
        if "result" in result and result["result"].get("uid"):
            self.uid = result["result"]["uid"]
            return True
        return False
    
    def call(self, model: str, method: str, args: list = None, kwargs: dict = None):
        """
        Call Odoo model method via JSON-RPC
        
        Args:
            model: Odoo model name (e.g., 'sale.order')
            method: Method name (e.g., 'create', 'search', 'read')
            args: Positional arguments
            kwargs: Keyword arguments
            
        Returns:
            API response result
        """
        if not self.uid:
            raise Exception("Not authenticated. Call authenticate() first.")
        
        endpoint = f"{self.url}/web/dataset/call_kw"
        
        payload = {
            "jsonrpc": "2.0",
            "method": "call",
            "params": {
                "model": model,
                "method": method,
                "args": args or [],
                "kwargs": kwargs or {}
            },
            "id": 1
        }
        
        response = self.session.post(endpoint, json=payload)
        result = response.json()
        
        if "error" in result:
            raise Exception(f"API Error: {result['error']}")
        
        return result.get("result")
    
    def search(self, model: str, domain: list, fields: list = None, limit: int = None):
        """
        Search records in Odoo model
        
        Args:
            model: Odoo model name
            domain: Search domain (e.g., [['state', '=', 'draft']])
            fields: Fields to retrieve
            limit: Maximum number of records
            
        Returns:
            List of records
        """
        kwargs = {}
        if fields:
            kwargs["fields"] = fields
        if limit:
            kwargs["limit"] = limit
        
        # First search for IDs
        ids = self.call(model, "search", args=[domain], kwargs=kwargs)
        
        # Then read the records
        if ids and fields:
            return self.call(model, "read", args=[ids], kwargs={"fields": fields})
        
        return ids
    
    def create(self, model: str, values: dict):
        """
        Create a new record
        
        Args:
            model: Odoo model name
            values: Dictionary of field values
            
        Returns:
            ID of created record
        """
        return self.call(model, "create", args=[values])
    
    def write(self, model: str, record_id: int, values: dict):
        """
        Update existing record
        
        Args:
            model: Odoo model name
            record_id: ID of record to update
            values: Dictionary of field values to update
            
        Returns:
            True if successful
        """
        return self.call(model, "write", args=[[record_id], values])
    
    def unlink(self, model: str, record_id: int):
        """
        Delete a record
        
        Args:
            model: Odoo model name
            record_id: ID of record to delete
            
        Returns:
            True if successful
        """
        return self.call(model, "unlink", args=[[record_id]])


# Pytest fixtures
@pytest.fixture(scope="session")
def odoo_client():
    """Fixture to provide authenticated Odoo API client"""
    client = OdooAPIClient(
        url="http://localhost:8069",
        db="your_database",
        username="admin",
        password="admin"
    )
    client.authenticate()
    return client


# Test examples
def test_authentication():
    """Test Odoo authentication"""
    client = OdooAPIClient(
        url="http://localhost:8069",
        db="your_database",
        username="admin",
        password="admin"
    )
    
    assert client.authenticate() is True
    assert client.uid is not None


def test_invalid_authentication():
    """Test authentication with invalid credentials"""
    client = OdooAPIClient(
        url="http://localhost:8069",
        db="your_database",
        username="invalid",
        password="wrong"
    )
    
    assert client.authenticate() is False


def test_search_partners(odoo_client):
    """Test searching for partners"""
    partners = odoo_client.search(
        model="res.partner",
        domain=[["is_company", "=", True]],
        fields=["name", "email", "phone"],
        limit=10
    )
    
    assert isinstance(partners, list)
    assert len(partners) <= 10
    
    if partners:
        assert "name" in partners[0]


def test_create_sale_order(odoo_client):
    """Test creating a sale order via API"""
    
    # First, get a partner
    partners = odoo_client.search(
        model="res.partner",
        domain=[["is_company", "=", True]],
        limit=1
    )
    assert partners, "No partner found for testing"
    
    # Create sale order
    order_data = {
        "partner_id": partners[0],
        "date_order": "2025-11-06",
    }
    
    order_id = odoo_client.create("sale.order", order_data)
    
    assert isinstance(order_id, int)
    assert order_id > 0
    
    # Verify creation
    order = odoo_client.search(
        model="sale.order",
        domain=[["id", "=", order_id]],
        fields=["name", "state", "partner_id"]
    )
    
    assert len(order) == 1
    assert order[0]["state"] == "draft"
    
    # Cleanup
    odoo_client.unlink("sale.order", order_id)


def test_update_record(odoo_client):
    """Test updating a record via API"""
    
    # Create a partner
    partner_data = {
        "name": "Test Partner API",
        "email": "test@example.com"
    }
    
    partner_id = odoo_client.create("res.partner", partner_data)
    
    # Update the partner
    update_data = {
        "phone": "+1234567890",
        "city": "Test City"
    }
    
    result = odoo_client.write("res.partner", partner_id, update_data)
    assert result is True
    
    # Verify update
    partner = odoo_client.search(
        model="res.partner",
        domain=[["id", "=", partner_id]],
        fields=["phone", "city"]
    )
    
    assert partner[0]["phone"] == "+1234567890"
    assert partner[0]["city"] == "Test City"
    
    # Cleanup
    odoo_client.unlink("res.partner", partner_id)


def test_custom_endpoint():
    """Test custom REST endpoint"""
    
    # Authenticate first
    session = requests.Session()
    auth_response = session.post(
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
    
    assert auth_response.status_code == 200
    
    # Call custom endpoint
    response = session.get("http://localhost:8069/api/sale_orders")
    
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, (list, dict))


if __name__ == "__main__":
    pytest.main([__file__, "-v"])

