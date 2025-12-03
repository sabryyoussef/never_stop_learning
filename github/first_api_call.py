#!/usr/bin/env python3
"""
Lesson 3.2: Making Your First API Call
GitHub Models API - First API Call Script

This script demonstrates:
- Setting up the API client
- Making your first API call
- Handling responses
- Error handling
- Testing with different prompts
"""

import os
import sys
import json
from pathlib import Path
from datetime import datetime

# Add parent directory to path to access .env file
parent_dir = Path(__file__).parent.parent
sys.path.insert(0, str(parent_dir))

try:
    from dotenv import load_dotenv
    # Load .env from parent directory
    env_path = parent_dir / '.env'
    load_dotenv(env_path)
    print("✅ .env file loaded")
except ImportError:
    print("⚠️  python-dotenv not installed. Using environment variables directly.")
    print("   Install with: pip install python-dotenv")

try:
    from azure.ai.inference import ChatCompletionsClient
    from azure.core.credentials import AzureKeyCredential
    from azure.core.exceptions import AzureError
except ImportError:
    print("❌ Azure AI Inference SDK not installed!")
    print("   Install with: pip install azure-ai-inference azure-core")
    sys.exit(1)


class GitHubModelsClient:
    """Client for interacting with GitHub Models API"""
    
    def __init__(self):
        """Initialize the API client"""
        self.endpoint = "https://models.inference.ai.azure.com"
        self.api_key = os.getenv("GITHUB_TOKEN")
        
        if not self.api_key:
            raise ValueError("GITHUB_TOKEN not found in environment variables!")
        
        self.client = ChatCompletionsClient(
            endpoint=self.endpoint,
            credential=AzureKeyCredential(self.api_key)
        )
        print(f"✅ Client initialized with endpoint: {self.endpoint}")
    
    def call_model(self, model: str, prompt: str, temperature: float = 0.7, 
                   max_tokens: int = 1000, **kwargs):
        """
        Make an API call to GitHub Models
        
        Args:
            model: Model name (e.g., 'gpt-4o-mini', 'claude-3-5-sonnet-20241022')
            prompt: User prompt/message
            temperature: Sampling temperature (0.0-2.0)
            max_tokens: Maximum tokens in response
            **kwargs: Additional parameters (top_p, frequency_penalty, etc.)
        
        Returns:
            Response object with model output
        """
        try:
            print(f"\n📤 Making API call to model: {model}")
            print(f"   Prompt: {prompt[:50]}..." if len(prompt) > 50 else f"   Prompt: {prompt}")
            print(f"   Parameters: temperature={temperature}, max_tokens={max_tokens}")
            
            # Make the API call
            response = self.client.complete(
                model=model,
                messages=[{"role": "user", "content": prompt}],
                temperature=temperature,
                max_tokens=max_tokens,
                **kwargs
            )
            
            print("✅ API call successful!")
            return response
            
        except AzureError as e:
            print(f"❌ Azure API Error: {e}")
            raise
        except Exception as e:
            print(f"❌ Unexpected error: {type(e).__name__}: {e}")
            raise
    
    def get_response_text(self, response):
        """Extract text from API response"""
        try:
            return response.choices[0].message.content
        except (AttributeError, IndexError, KeyError) as e:
            print(f"⚠️  Error parsing response: {e}")
            print(f"   Response structure: {response}")
            return None
    
    def log_request(self, model: str, prompt: str, response_text: str, 
                    parameters: dict = None):
        """Log the request and response for debugging"""
        log_entry = {
            "timestamp": datetime.now().isoformat(),
            "model": model,
            "prompt": prompt,
            "parameters": parameters or {},
            "response": response_text,
            "response_length": len(response_text) if response_text else 0
        }
        
        log_file = Path(__file__).parent / "api_logs.json"
        
        # Load existing logs
        logs = []
        if log_file.exists():
            try:
                with open(log_file, 'r') as f:
                    logs = json.load(f)
            except json.JSONDecodeError:
                logs = []
        
        # Add new log entry
        logs.append(log_entry)
        
        # Save logs (keep last 50 entries)
        logs = logs[-50:]
        
        with open(log_file, 'w') as f:
            json.dump(logs, f, indent=2)
        
        print(f"📝 Request logged to: {log_file}")


def main():
    """Main function to demonstrate API usage"""
    
    print("=" * 60)
    print("GitHub Models API - First API Call")
    print("Lesson 3.2: Making Your First API Call")
    print("=" * 60)
    
    # Initialize client
    try:
        client = GitHubModelsClient()
    except Exception as e:
        print(f"❌ Failed to initialize client: {e}")
        return 1
    
    # Test prompts
    test_prompts = [
        {
            "prompt": "Hello! Can you introduce yourself?",
            "model": "gpt-4o-mini",  # Low tier model
            "temperature": 0.7,
            "max_tokens": 200
        },
        {
            "prompt": "Write a Python function to calculate the factorial of a number.",
            "model": "gpt-4o-mini",
            "temperature": 0.3,  # Lower temperature for code
            "max_tokens": 500
        },
        {
            "prompt": "Explain quantum computing in simple terms.",
            "model": "gpt-4o-mini",
            "temperature": 0.8,  # Higher temperature for creative explanation
            "max_tokens": 300
        }
    ]
    
    print(f"\n🧪 Running {len(test_prompts)} test prompts...\n")
    
    for i, test in enumerate(test_prompts, 1):
        print(f"\n{'=' * 60}")
        print(f"Test {i}/{len(test_prompts)}")
        print(f"{'=' * 60}")
        
        try:
            # Make API call
            response = client.call_model(
                model=test["model"],
                prompt=test["prompt"],
                temperature=test["temperature"],
                max_tokens=test["max_tokens"]
            )
            
            # Extract response text
            response_text = client.get_response_text(response)
            
            if response_text:
                print(f"\n📥 Response:")
                print(f"{'-' * 60}")
                print(response_text)
                print(f"{'-' * 60}")
                
                # Log the request
                client.log_request(
                    model=test["model"],
                    prompt=test["prompt"],
                    response_text=response_text,
                    parameters={
                        "temperature": test["temperature"],
                        "max_tokens": test["max_tokens"]
                    }
                )
            else:
                print("⚠️  No response text received")
        
        except Exception as e:
            print(f"❌ Test {i} failed: {e}")
            continue
    
    print(f"\n{'=' * 60}")
    print("✅ All tests completed!")
    print("=" * 60)
    
    return 0


if __name__ == "__main__":
    exit_code = main()
    sys.exit(exit_code)

