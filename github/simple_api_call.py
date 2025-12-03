#!/usr/bin/env python3
"""
Simple API Call Example - Quick Start
Use this for quick testing and experimentation
"""

import os
import sys
from pathlib import Path

# Load environment variables
parent_dir = Path(__file__).parent.parent
sys.path.insert(0, str(parent_dir))

from dotenv import load_dotenv
load_dotenv(parent_dir / '.env')

from azure.ai.inference import ChatCompletionsClient
from azure.core.credentials import AzureKeyCredential

# Initialize client
endpoint = "https://models.inference.ai.azure.com"
api_key = os.getenv("GITHUB_TOKEN")

if not api_key:
    print("❌ GITHUB_TOKEN not found!")
    sys.exit(1)

client = ChatCompletionsClient(
    endpoint=endpoint,
    credential=AzureKeyCredential(api_key)
)

# Make API call
print("📤 Making API call...")
response = client.complete(
    model="gpt-4o-mini",  # Change this to any model you want to test
    messages=[{"role": "user", "content": "Say hello and introduce yourself!"}],
    temperature=0.7,
    max_tokens=200
)

# Print response
print("\n📥 Response:")
print(response.choices[0].message.content)

