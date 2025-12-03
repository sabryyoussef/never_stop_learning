#!/usr/bin/env python3
"""
Interactive API Call - Chat with GitHub Models
Ask questions and get responses interactively
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

print("=" * 60)
print("GitHub Models - Interactive Chat")
print("=" * 60)
print("Type your questions (or 'quit'/'exit' to end)")
print("=" * 60)
print()

# Conversation history
conversation_history = []

while True:
    try:
        # Get user input
        user_input = input("You: ").strip()
        
        if not user_input:
            continue
        
        # Check for exit commands
        if user_input.lower() in ['quit', 'exit', 'q']:
            print("\n👋 Goodbye!")
            break
        
        # Add to conversation history
        conversation_history.append({"role": "user", "content": user_input})
        
        # Make API call
        print("🤔 Thinking...", end="\r")
        response = client.complete(
            model="gpt-4o-mini",
            messages=conversation_history,
            temperature=0.7,
            max_tokens=500
        )
        
        # Get response
        assistant_message = response.choices[0].message.content
        
        # Add to conversation history
        conversation_history.append({"role": "assistant", "content": assistant_message})
        
        # Print response
        print(f"\n🤖 Assistant: {assistant_message}\n")
        
        # Keep only last 10 messages to avoid token limit
        if len(conversation_history) > 10:
            conversation_history = conversation_history[-10:]
    
    except KeyboardInterrupt:
        print("\n\n👋 Goodbye!")
        break
    except Exception as e:
        print(f"\n❌ Error: {e}\n")
        continue

