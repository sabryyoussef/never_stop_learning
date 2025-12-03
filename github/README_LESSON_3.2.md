# Lesson 3.2: Making Your First API Call

## ✅ Setup Complete

You have:
- ✅ GitHub token configured in `.env` file
- ✅ Azure AI Inference SDK installed
- ✅ Python virtual environment ready
- ✅ Two example scripts created

## 🚀 Quick Start

### Option 1: Simple API Call (Recommended for first test)

```bash
cd /home/sabry3/never_stop_learning/github
source venv/bin/activate
python simple_api_call.py
```

This will make a simple "hello" call to test your setup.

### Option 2: Full Featured Script

```bash
cd /home/sabry3/never_stop_learning/github
source venv/bin/activate
python first_api_call.py
```

This runs multiple test prompts with error handling and logging.

## 📝 What the Scripts Do

### `simple_api_call.py`
- Minimal example
- One API call
- Quick testing

### `first_api_call.py`
- Full-featured example
- Multiple test prompts
- Error handling
- Response logging
- Parameter customization

## 🎯 Lesson 3.2 Tasks

1. ✅ **Open a model in playground** - Visit [github.com/marketplace/models](https://github.com/marketplace/models)
2. ✅ **Switch to Code tab** - Click "Code" in the playground
3. ✅ **Select Python** - Choose Python as your language
4. ✅ **Select SDK** - Azure AI Inference SDK (already installed)
5. ✅ **Copy example code** - Scripts provided above
6. ✅ **Set up local environment** - Virtual environment ready
7. ⏳ **Make your first API call** - Run the scripts!
8. ⏳ **Handle response** - Scripts show how
9. ⏳ **Add error handling** - Included in `first_api_call.py`
10. ⏳ **Test with different prompts** - Modify the prompts in the scripts

## 🔧 Customizing the Scripts

### Change the Model

Edit the `model` parameter:
```python
response = client.complete(
    model="gpt-4o-mini",  # Change to any model name
    ...
)
```

### Change the Prompt

Edit the `messages` content:
```python
messages=[{"role": "user", "content": "Your custom prompt here"}]
```

### Adjust Parameters

```python
response = client.complete(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": "Your prompt"}],
    temperature=0.7,      # 0.0-2.0 (creativity)
    max_tokens=1000,      # Max response length
    top_p=0.9,           # Nucleus sampling
    frequency_penalty=0, # Reduce repetition
    presence_penalty=0    # Encourage new topics
)
```

## 📊 Available Models

Check available models at: [github.com/marketplace/models](https://github.com/marketplace/models)

Common models:
- `gpt-4o-mini` - Low tier, fast, cost-effective
- `gpt-4o` - High tier, more capable
- `claude-3-5-sonnet-20241022` - High tier, excellent quality
- `claude-3-5-haiku-20241022` - Low tier, fast

## 🐛 Troubleshooting

### Error: "GITHUB_TOKEN not found"
- Make sure `.env` file exists in project root
- Verify token is in `.env` file: `GITHUB_TOKEN=your_token_here`

### Error: "Module not found"
- Activate virtual environment: `source venv/bin/activate`
- Install dependencies: `pip install azure-ai-inference azure-core python-dotenv`

### Error: "401 Unauthorized"
- Check token has `models:read` permission
- Verify token is correct in `.env` file

### Error: "Model not found"
- Check model name spelling
- Visit marketplace to get exact model names

## ✅ Checkpoint

After running the scripts, you should be able to:
- [x] Successfully make API call
- [x] Parse response
- [x] Have basic error handling
- [x] Understand request/response structure

## 📚 Next Steps

Once you've successfully made your first API call:
1. Try different models
2. Experiment with parameters (temperature, max_tokens, etc.)
3. Test with different prompts
4. Review the logged requests in `api_logs.json`
5. Move to **Lesson 3.3: Advanced API Usage**

## 💡 Tips

- Start with `gpt-4o-mini` (low tier, free tier friendly)
- Lower temperature (0.3-0.5) for code/logical tasks
- Higher temperature (0.7-1.0) for creative tasks
- Monitor rate limits (15 requests/min for free tier)
- Check `api_logs.json` to review your API calls

