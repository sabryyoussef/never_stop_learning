# GitHub Models - Quick Reference Guide

**Quick access to essential information for GitHub Models prototyping**

---

## 🔗 Essential Links

- **Model Marketplace:** [github.com/marketplace/models](https://github.com/marketplace/models)
- **Main Documentation:** [Prototyping with AI models](https://docs.github.com/en/github-models/use-github-models/prototyping-with-ai-models)
- **Community Discussions:** [GitHub Models Discussion](https://github.com/community/community/discussions/categories/models)

---

## 🚀 Quick Start Commands

### API Authentication
```bash
# Set GitHub token
export GITHUB_TOKEN="your_token_here"

# Verify token
echo $GITHUB_TOKEN
```

### Required Token Permissions
- `models:read` - Required for API access

---

## 📊 Rate Limits Quick Reference

### Low Tier Models
| Copilot Tier | Requests/min | Requests/day | Tokens (in/out) | Concurrent |
|--------------|--------------|-------------|-----------------|------------|
| Free | 15 | 150 | 8000/4000 | 5 |
| Pro | 15 | 300 | 8000/4000 | 5 |
| Business | 15 | 450 | 8000/8000 | 8 |
| Enterprise | 20 | - | 8000/8000 | 8 |

### High Tier Models
| Copilot Tier | Requests/min | Requests/day | Tokens (in/out) | Concurrent |
|--------------|--------------|-------------|-----------------|------------|
| Free | 10 | 50 | 8000/4000 | 2 |
| Pro | 10 | 100 | 8000/4000 | 2 |
| Business | 10 | 150 | 8000/4000 | 2 |
| Enterprise | 15 | - | 16000/8000 | 4 |

### Embedding Models
| Copilot Tier | Requests/min | Requests/day | Tokens | Concurrent |
|--------------|--------------|-------------|--------|------------|
| Free | 15 | 150 | 64000 | 5 |
| Pro | 15 | 300 | 64000 | 5 |
| Business | 15 | 450 | 64000 | 8 |
| Enterprise | 20 | - | 64000 | 8 |

---

## 🎯 Common Workflows

### Finding a Model
1. Go to `github.com/marketplace/models`
2. Click **Model: Select a Model** dropdown
3. Choose model or click **View all models**
4. Click **Playground** to open

### Comparing Models
1. Open a model in playground
2. Click **Compare** button
3. Select second model
4. Prompts auto-mirror to both models

### Creating a Preset
1. Configure model parameters
2. Click **Preset: PRESET-NAME** dropdown
3. Click **Create new preset**
4. Name, describe, optionally include chat history
5. Save

### Making API Call (Python Example)
```python
import os
from azure.ai.inference import ChatCompletionsClient
from azure.core.credentials import AzureKeyCredential

# Set up client
endpoint = "https://models.inference.ai.azure.com"
api_key = os.getenv("GITHUB_TOKEN")
client = ChatCompletionsClient(
    endpoint=endpoint,
    credential=AzureKeyCredential(api_key)
)

# Make request
response = client.complete(
    model="model-name",
    messages=[{"role": "user", "content": "Your prompt here"}],
    temperature=0.7,
    max_tokens=1000
)

print(response.choices[0].message.content)
```

---

## ⚙️ Key Parameters

| Parameter | Description | Typical Range | Use Case |
|-----------|-------------|---------------|----------|
| **temperature** | Creativity/randomness | 0.0-2.0 | Higher = more creative |
| **max_tokens** | Max output length | 1-8000+ | Control response length |
| **top_p** | Nucleus sampling | 0.0-1.0 | Focus on likely tokens |
| **frequency_penalty** | Reduce repetition | -2.0 to 2.0 | Positive = less repetition |
| **presence_penalty** | Encourage new topics | -2.0 to 2.0 | Positive = more diversity |

---

## 🔍 Model Types

- **Low Tier:** General purpose, faster, lower cost
- **High Tier:** More capable, better quality, higher cost
- **Embedding:** Vector embeddings for search/similarity
- **Custom:** Your own models via BYOK

---

## 🛠️ VS Code Integration

1. Install **AI Toolkit** extension (pre-release)
2. Authorize GitHub account
3. Open **My models** → **Open Model Catalog**
4. Try in playground or download locally

---

## 📝 Evaluation Metrics

- **Similarity:** How similar is output to expected?
- **Relevance:** How relevant is output to prompt?
- **Groundedness:** How well-supported by facts?
- **Custom:** Define your own evaluation criteria

---

## 🚨 Common Issues & Solutions

### Rate Limit Hit
- **Symptom:** Error about rate limits
- **Solution:** Wait for reset or upgrade tier
- **Prevention:** Implement rate limit monitoring

### Authentication Failed
- **Symptom:** 401/403 errors
- **Solution:** Check token has `models:read` permission
- **Prevention:** Verify token before making calls

### Model Not Found
- **Symptom:** 404 error
- **Solution:** Verify model name is correct
- **Prevention:** Use model catalog to get exact names

---

## 💡 Best Practices

1. **Always handle errors** - API calls can fail
2. **Monitor rate limits** - Track your usage
3. **Cache responses** - Reduce API calls when possible
4. **Use appropriate model tier** - Don't overpay for simple tasks
5. **Optimize prompts** - Better prompts = better results
6. **Test parameters** - Small changes can have big impacts
7. **Log everything** - Debugging is easier with logs
8. **Secure tokens** - Never commit tokens to code

---

## 📚 Documentation Structure

```
GitHub Models
├── Use GitHub Models
│   ├── Prototyping with AI models ← You are here
│   ├── Evaluating AI models
│   ├── Optimize your AI-powered app
│   └── Store prompts
├── GitHub Models at scale
│   ├── Use Models at scale
│   ├── Manage Models at scale
│   └── Use custom models
└── Responsible use
```

---

## 🎓 Learning Path Summary

1. **Foundation** → Understand platform, find models
2. **Experimentation** → Playground, parameters, comparison
3. **API Integration** → Authentication, API calls, advanced usage
4. **Workflow** → Presets, prompt editor, VS Code
5. **Production** → Rate limits, production options, best practices
6. **Project** → Build complete application

---

**Last Updated:** 2025-01-27

