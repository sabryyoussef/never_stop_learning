#!/usr/bin/env python3
"""
Test script to verify GitHub token is loaded from .env file
"""
import os
import sys
from pathlib import Path

# Add parent directory to path to access .env file
parent_dir = Path(__file__).parent.parent
sys.path.insert(0, str(parent_dir))

try:
    from dotenv import load_dotenv
    # Load .env from parent directory (project root)
    env_path = parent_dir / '.env'
    load_dotenv(env_path)
    print("✅ .env file loaded successfully")
except ImportError:
    print("⚠️  python-dotenv not installed. Using environment variables directly.")
    print("   Install with: pip install python-dotenv")

# Get token from environment
token = os.getenv("GITHUB_TOKEN")

if token:
    # Show first and last 10 characters for security
    masked_token = token[:10] + "..." + token[-10:] if len(token) > 20 else "***"
    print(f"✅ GITHUB_TOKEN found: {masked_token}")
    print(f"   Token length: {len(token)} characters")
    
    # Verify token format (GitHub PATs start with github_pat_)
    if token.startswith("github_pat_"):
        print("✅ Token format looks correct (GitHub Personal Access Token)")
    else:
        print("⚠️  Token doesn't match expected GitHub PAT format")
else:
    print("❌ GITHUB_TOKEN not found!")
    print("   Make sure .env file exists in project root with: GITHUB_TOKEN=your_token")
    sys.exit(1)

print("\n🎉 Token setup complete! Ready for Lesson 3.1 ✅")

