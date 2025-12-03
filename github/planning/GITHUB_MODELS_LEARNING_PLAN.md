# GitHub Models: Prototyping with AI Models - Learning Plan

**Source Documentation:** [Prototyping with AI models](https://docs.github.com/en/github-models/use-github-models/prototyping-with-ai-models)

**Created:** 2025-01-27

---

## 📚 Overview

This learning plan covers GitHub Models, a platform for finding, experimenting with, and integrating AI models into applications. The plan is structured to take you from beginner to production-ready implementation.

**Learning Objectives:**
- Understand GitHub Models platform and its capabilities
- Learn to find and experiment with AI models in the playground
- Master model evaluation and comparison techniques
- Integrate GitHub Models API into applications
- Understand rate limits and production considerations
- Use VS Code integration for AI model development

**Estimated Time:** 8-12 hours (depending on depth of practice)

---

## 🎯 Phase 1: Foundation & Discovery (2-3 hours)

### Lesson 1.1: Understanding GitHub Models Platform
**Time:** 30 minutes  
**Objective:** Get familiar with the GitHub Models ecosystem

**Topics:**
- What is GitHub Models?
- Free vs. paid usage tiers
- Model types: Low, High, Embedding, and custom models
- Responsible use guidelines

**Practical Tasks:**
1. Visit [github.com/marketplace/models](https://github.com/marketplace/models)
2. Read the overview and understand the platform structure
3. Review the rate limits table (document in notes)
4. Identify which Copilot tier you have access to

**Checkpoint:**
- [x] Can explain what GitHub Models is
- [x] Understand the difference between model tiers
- [x] Know your current rate limits

---

### Lesson 1.2: Finding AI Models
**Time:** 45 minutes  
**Objective:** Learn to navigate and select models

**Topics:**
- Navigating the model marketplace
- Model selection dropdown
- Viewing all models
- Understanding model details sidebar

**Practical Tasks:**
1. Navigate to github.com/marketplace/models
2. Use "Model: Select a Model" dropdown
3. Click "View all models" and browse available models
4. Open at least 3 different models in the playground
5. Explore the model details sidebar (expand if needed)
6. Document 5 interesting models you found

**Checkpoint:**
- [x] Successfully opened a model in the playground
- [x] Can navigate between different models
- [x] Understand how to view model information

**Notes Section:**
```
Models I discovered:
1. [Model Name] - [Brief description]
2. [Model Name] - [Brief description]
...
```

---

### Lesson 1.3: Playground Basics
**Time:** 1 hour  
**Objective:** Master the playground interface

**Topics:**
- Playground interface overview
- Chat vs. Code tabs
- Parameters sidebar
- Understanding model responses

**Practical Tasks:**
1. Open a model in the playground
2. Switch between Chat and Code tabs
3. Open Parameters tab in sidebar
4. Submit a simple prompt: "Hello, introduce yourself"
5. Observe the response
6. Switch to Code tab and examine the generated code
7. Try changing parameters (temperature, max tokens, etc.)
8. Submit another prompt and observe differences

**Checkpoint:**
- [x] Comfortable navigating playground interface
- [x] Understand difference between Chat and Code views
- [x] Can adjust basic parameters
- [x] Know how to interpret model responses

---

## 🔬 Phase 2: Experimentation & Comparison (2-3 hours)

### Lesson 2.1: Model Parameters Deep Dive
**Time:** 1 hour  
**Objective:** Master parameter tuning

**Topics:**
- Temperature settings
- Max tokens (input/output)
- Top-p and top-k sampling
- Frequency and presence penalties
- System prompts and context

**Practical Tasks:**
1. Create a test prompt (e.g., "Write a creative story about a robot")
2. Test with different temperature values (0.1, 0.7, 1.0, 1.5)
3. Document how responses differ
4. Experiment with max tokens limits
5. Try different sampling parameters
6. Create a system prompt and test its effect

**Checkpoint:**
- [x] Understand what each parameter does
- [x] Can predict how parameter changes affect output
- [x] Know when to use different parameter settings

**Practice Exercise:**
Create a parameter comparison table:
| Parameter | Value | Effect on Output |
|-----------|-------|------------------|
| Temperature: 0.1 | | |
| Temperature: 1.0 | | |
| Max Tokens: 100 | | |
| Max Tokens: 1000 | | |

---

### Lesson 2.2: Model Comparison
**Time:** 1.5 hours  
**Objective:** Compare multiple models side-by-side

**Topics:**
- Using the Compare feature
- Simultaneous prompt submission
- Analyzing response differences
- Parameter synchronization

**Practical Tasks:**
1. Open a model in the playground
2. Click "Compare" button
3. Select a second model for comparison
4. Type a prompt in one window (observe mirroring)
5. Compare responses from both models
6. Test with different prompt types:
   - Creative writing
   - Code generation
   - Question answering
   - Data analysis
7. Adjust parameters and observe effects on both models
8. Document which model performs better for each task type

**Checkpoint:**
- [x] Can use Compare feature effectively
- [x] Understand how prompts are mirrored
- [x] Can identify strengths/weaknesses of different models
- [x] Know when to use each model type

**Comparison Exercise:**
Compare 3 different models on the same 5 prompts:
1. "Explain quantum computing in simple terms"
2. "Write a Python function to sort a list"
3. "Create a marketing tagline for a coffee shop"
4. "Summarize the benefits of exercise"
5. "Generate a recipe for chocolate cake"

Document which model performs best for each task.

---

### Lesson 2.3: Model Evaluation
**Time:** 1 hour  
**Objective:** Use structured metrics to evaluate models

**Topics:**
- Evaluators: similarity, relevance, groundedness
- Custom prompt evaluators
- Comparisons view
- Measuring performance

**Practical Tasks:**
1. Open Comparisons view
2. Submit a prompt to multiple models
3. Apply similarity evaluator
4. Apply relevance evaluator
5. Apply groundedness evaluator
6. Create a custom prompt evaluator for a specific use case
7. Compare evaluation results across models
8. Document which evaluators are most useful for your needs

**Checkpoint:**
- [x] Understand different evaluation metrics
- [x] Can apply built-in evaluators
- [x] Can create custom evaluators
- [x] Can interpret evaluation results

**Evaluation Exercise:**
Create a custom evaluator for code quality:
- Prompt: "Write a function to calculate factorial"
- Evaluation criteria: Code correctness, efficiency, readability
- Test on 2-3 different models
- Document results

---

## 💻 Phase 3: API Integration (2-3 hours)

### Lesson 3.1: API Setup & Authentication
**Time:** 45 minutes  
**Objective:** Set up API access

**Topics:**
- Creating GitHub Personal Access Token
- Required permissions (`models:read`)
- Environment variable setup
- SDK installation

**Practical Tasks:**
1. Create a GitHub Personal Access Token with `models:read` permission
2. Save token as environment variable:
   ```bash
   export GITHUB_TOKEN="your_token_here"
   ```
3. Verify token is accessible:
   ```bash
   echo $GITHUB_TOKEN
   ```
4. Choose your preferred SDK (Azure AI Inference SDK recommended)
5. Install SDK dependencies
6. Test token access (optional: make a simple API call)

**Checkpoint:**
- [ ] Have valid GitHub token
- [ ] Token saved as environment variable
- [ ] SDK installed and ready
- [ ] Understand authentication process

**Security Notes:**
- Never commit tokens to version control
- Use environment variables or secure secret management
- Rotate tokens regularly

---

### Lesson 3.2: Making Your First API Call
**Time:** 1 hour  
**Objective:** Successfully call GitHub Models API

**Topics:**
- Understanding API endpoints
- Request structure
- Response handling
- Error handling

**Practical Tasks:**
1. Open a model in playground
2. Switch to Code tab
3. Select your preferred language (Python, JavaScript, etc.)
4. Select SDK (Azure AI Inference SDK recommended)
5. Copy example code
6. Set up local environment or use codespace
7. Make your first API call
8. Handle response
9. Add error handling
10. Test with different prompts

**Checkpoint:**
- [ ] Successfully made API call
- [ ] Can parse response
- [ ] Have basic error handling
- [ ] Understand request/response structure

**Code Exercise:**
Create a simple script that:
- Takes a prompt as input
- Calls GitHub Models API
- Returns the response
- Handles errors gracefully
- Logs the request/response

---

### Lesson 3.3: Advanced API Usage
**Time:** 1.5 hours  
**Objective:** Master API features and best practices

**Topics:**
- Parameter passing via API
- Streaming responses
- Batch requests
- Rate limit handling
- Retry logic

**Practical Tasks:**
1. Implement parameter customization in API calls
2. Test different parameter combinations
3. Implement streaming (if supported by SDK)
4. Create a batch request handler
5. Implement rate limit detection and handling
6. Add retry logic with exponential backoff
7. Create a wrapper class/function for easy model access
8. Test with multiple models

**Checkpoint:**
- [ ] Can customize all parameters via API
- [ ] Understand rate limits and handling
- [ ] Have robust error handling
- [ ] Can make efficient API calls

**Advanced Exercise:**
Create a model client class that:
- Handles authentication
- Manages rate limits
- Implements retry logic
- Supports multiple models
- Provides easy parameter configuration
- Logs all requests/responses
- Handles errors gracefully

---

## 📝 Phase 4: Workflow & Productivity (1-2 hours)

### Lesson 4.1: Presets & Sharing
**Time:** 45 minutes  
**Objective:** Save and share playground experiments

**Topics:**
- Creating presets
- Saving state and parameters
- Including chat history
- Sharing presets
- Loading presets

**Practical Tasks:**
1. Configure a model with specific parameters
2. Create a conversation with multiple exchanges
3. Create a new preset (name it, add description)
4. Choose whether to include chat history
5. Save the preset
6. Load the preset to verify it works
7. Share the preset (get shareable URL)
8. Edit the preset with new parameters
9. Delete a test preset
10. Document your useful presets

**Checkpoint:**
- [ ] Can create and save presets
- [ ] Understand preset options
- [ ] Can share presets via URL
- [ ] Can edit and manage presets

**Preset Exercise:**
Create 3 different presets:
1. **Code Generation**: Optimized for code generation tasks
2. **Creative Writing**: Optimized for creative content
3. **Data Analysis**: Optimized for analytical tasks

Document the parameters used for each.

---

### Lesson 4.2: Prompt Editor
**Time:** 30 minutes  
**Objective:** Master the prompt editor for single-turn scenarios

**Topics:**
- Accessing prompt editor
- Single-turn vs. multi-turn interactions
- Prompt refinement workflow
- Testing and iteration

**Practical Tasks:**
1. Open prompt editor from playground
2. Write an initial prompt
3. Test the prompt
4. Refine based on results
5. Iterate 3-5 times to optimize
6. Compare refined prompt with original
7. Document the refinement process

**Checkpoint:**
- [ ] Can access and use prompt editor
- [ ] Understand when to use prompt editor vs. chat
- [ ] Can refine prompts effectively
- [ ] Know the iteration workflow

**Refinement Exercise:**
Start with a vague prompt: "Write about AI"
Refine it through 5 iterations to be specific and effective.
Document each iteration and the improvements.

---

### Lesson 4.3: VS Code Integration
**Time:** 45 minutes  
**Objective:** Use GitHub Models in your IDE

**Topics:**
- Installing AI Toolkit extension
- Authorization setup
- Model catalog in VS Code
- Local vs. remote models
- Playground in VS Code

**Practical Tasks:**
1. Install AI Toolkit extension (pre-release version)
2. Authorize connection to GitHub account
3. Open "My models" section
4. Click "Open Model Catalog"
5. Try a remote model in playground
6. Download a model locally (if desired)
7. Load local model in playground
8. Configure context instructions
9. Set inference parameters
10. Test with prompts

**Checkpoint:**
- [ ] AI Toolkit extension installed
- [ ] Can access model catalog in VS Code
- [ ] Can use both remote and local models
- [ ] Comfortable with VS Code workflow

**Integration Exercise:**
Set up VS Code for your development workflow:
- Configure preferred models
- Set up default parameters
- Create a workspace for AI model experiments
- Document your setup

---

## 🚀 Phase 5: Production Readiness (1-2 hours)

### Lesson 5.1: Understanding Rate Limits
**Time:** 45 minutes  
**Objective:** Master rate limit management

**Topics:**
- Rate limit tiers (Low, High, Embedding)
- Limits by Copilot tier
- Requests per minute/day
- Token limits
- Concurrent request limits
- Rate limit detection and handling

**Practical Tasks:**
1. Review rate limits table for your Copilot tier
2. Calculate your daily usage capacity
3. Identify which model tier you're using
4. Create a rate limit monitoring script
5. Implement rate limit handling in your code
6. Test hitting rate limits (carefully!)
7. Document your rate limit strategy

**Checkpoint:**
- [ ] Know your exact rate limits
- [ ] Can calculate usage capacity
- [ ] Understand all limit types
- [ ] Have rate limit handling in place

**Rate Limit Exercise:**
Create a rate limit calculator:
- Input: Model type, Copilot tier, request size
- Output: Max requests per minute/day, estimated capacity
- Include warnings for approaching limits

---

### Lesson 5.2: Production Options
**Time:** 45 minutes  
**Objective:** Understand production pathways

**Topics:**
- Free tier limitations
- Paid usage opt-in
- BYOK (Bring Your Own Keys)
- Azure subscription integration
- Billing considerations

**Practical Tasks:**
1. Review free tier limitations
2. Research paid usage options
3. Understand BYOK requirements
4. Compare GitHub Models pricing vs. direct provider pricing
5. Create a production readiness checklist
6. Document your production strategy

**Checkpoint:**
- [ ] Understand free tier limitations
- [ ] Know production options available
- [ ] Can make informed decision about production path
- [ ] Have a production plan

**Production Planning Exercise:**
Create a production readiness document:
- Current usage estimate
- Projected production usage
- Cost analysis (free vs. paid vs. BYOK)
- Migration plan
- Timeline

---

### Lesson 5.3: Best Practices & Optimization
**Time:** 30 minutes  
**Objective:** Learn production best practices

**Topics:**
- Prompt optimization
- Cost optimization
- Performance optimization
- Error handling patterns
- Monitoring and logging
- Security best practices

**Practical Tasks:**
1. Review prompt optimization techniques
2. Implement caching where appropriate
3. Set up logging and monitoring
4. Create error handling patterns
5. Document security practices
6. Create a best practices checklist

**Checkpoint:**
- [ ] Understand optimization strategies
- [ ] Have monitoring in place
- [ ] Follow security best practices
- [ ] Can optimize costs and performance

---

## 📊 Phase 6: Project & Practice (2-3 hours)

### Final Project: Build an AI-Powered Application
**Time:** 2-3 hours  
**Objective:** Apply all learned concepts

**Project Requirements:**
Build a complete application that uses GitHub Models API with:

1. **Core Features:**
   - Multiple model support
   - Parameter customization
   - Error handling
   - Rate limit management
   - Response caching

2. **Advanced Features:**
   - Model comparison functionality
   - Evaluation metrics
   - Preset management
   - Logging and monitoring

3. **Documentation:**
   - README with setup instructions
   - API documentation
   - Usage examples
   - Best practices guide

**Project Ideas:**
- **Code Review Assistant**: Analyzes code and provides suggestions
- **Content Generator**: Creates blog posts, social media content
- **Question Answering Bot**: Answers questions from knowledge base
- **Translation Service**: Multi-language translation with quality metrics
- **Data Analysis Tool**: Analyzes data and generates insights

**Deliverables:**
- [ ] Working application
- [ ] Source code with comments
- [ ] README documentation
- [ ] Usage examples
- [ ] Test cases
- [ ] Production readiness assessment

---

## 📚 Additional Resources

### Documentation Links
- [Main Documentation](https://docs.github.com/en/github-models/use-github-models/prototyping-with-ai-models)
- [Evaluating outputs](https://docs.github.com/en/github-models/use-github-models/evaluating-ai-models)
- [GitHub Models billing](https://docs.github.com/en/github-models/use-github-models/github-models-billing)
- [Using your own API keys](https://docs.github.com/en/github-models/use-github-models/using-your-own-api-keys-in-github-models)
- [Responsible use](https://docs.github.com/en/github-models/use-github-models/responsible-use-of-github-models)

### Community Resources
- [GitHub Models Discussion](https://github.com/community/community/discussions/categories/models)
- [GitHub Community Discussions](https://github.com/community/community/discussions)

### Tools & Extensions
- [AI Toolkit for VS Code](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat)
- [Azure AI Inference SDK](https://learn.microsoft.com/en-us/azure/ai-studio/how-to/use-rest-api)

---

## ✅ Learning Checklist

### Phase 1: Foundation
- [x] Understand GitHub Models platform
- [x] Can find and select models
- [x] Comfortable with playground interface
- [x] Understand basic parameters

### Phase 2: Experimentation
- [x] Master parameter tuning
- [x] Can compare models effectively
- [x] Understand evaluation metrics
- [x] Can create custom evaluators

### Phase 3: API Integration
- [ ] Set up API authentication
- [ ] Made first successful API call
- [ ] Implemented advanced API features
- [ ] Have robust error handling

### Phase 4: Workflow
- [ ] Can create and manage presets
- [ ] Master prompt editor
- [ ] Set up VS Code integration
- [ ] Optimized workflow

### Phase 5: Production
- [ ] Understand rate limits
- [ ] Know production options
- [ ] Follow best practices
- [ ] Ready for production

### Phase 6: Project
- [ ] Completed final project
- [ ] Documented code
- [ ] Tested thoroughly
- [ ] Production-ready

---

## 📝 Notes & Progress Tracking

### My Notes
_Use this section to document your learning journey, insights, and discoveries._

---

### Progress Log
| Date | Phase | Lesson | Status | Notes |
|------|-------|--------|--------|-------|
| | | | | |
| | | | | |
| | | | | |

---

### Key Learnings
_Record important insights and "aha!" moments here._

---

### Challenges & Solutions
_Document any challenges you faced and how you solved them._

---

## 🎓 Next Steps After Completion

1. **Explore Advanced Topics:**
   - Custom model integration
   - Fine-tuning workflows
   - Advanced evaluation techniques
   - Multi-model orchestration

2. **Join Community:**
   - Participate in GitHub Models discussions
   - Share your projects
   - Learn from others

3. **Production Deployment:**
   - Choose production path (paid/BYOK)
   - Set up monitoring
   - Optimize costs
   - Scale your application

4. **Continue Learning:**
   - Explore other GitHub Models features
   - Learn about model optimization
   - Study responsible AI practices
   - Keep up with platform updates

---

**Happy Learning! 🚀**

*Remember: This is a living document. Update it as you learn and discover new insights!*

