# 🧪 Odoo UI Automation Testing - Learning Repository

Welcome to your comprehensive learning path for mastering UI automation testing in Odoo! This repository contains a structured 6-week program based on **Raghav Pal's Automation Step by Step** series, tailored specifically for Odoo module development.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Repository Structure](#repository-structure)
- [Learning Path](#learning-path)
- [Setup Instructions](#setup-instructions)
- [Usage Guide](#usage-guide)
- [Progress Tracking](#progress-tracking)
- [Resources](#resources)
- [Contributing](#contributing)

---

## 🎯 Overview

This learning path will teach you how to:
- ✅ Automate UI testing for Odoo forms, buttons, and workflows
- ✅ Test Odoo REST/JSON-RPC APIs using Postman
- ✅ Write robust Playwright tests for Odoo modules
- ✅ Integrate automated tests into CI/CD pipelines with Jenkins
- ✅ Perform load testing on Odoo endpoints with JMeter

**Target Audience:** Odoo developers who want to add automated testing to their workflow

**Duration:** 6 weeks (flexible, self-paced)

**Prerequisites:** 
- Basic Python knowledge
- Familiarity with Odoo development
- Understanding of web technologies (HTML, CSS, JavaScript)

---

## 🚀 Quick Start

### 1. Clone or Navigate to This Repository

```bash
cd /home/sabry3/never_stop_learning/automation
```

### 2. Install Python Dependencies

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r templates/requirements.txt

# Install Playwright browsers
playwright install
```

### 3. Install Node.js Dependencies (for Playwright)

```bash
# Install Node packages
npm install

# Or using the package.json in templates/
cd templates
npm install
```

### 4. Start Learning!

Open `LEARNING_PLAN.md` and begin with Phase 1!

---

## 📁 Repository Structure

```
automation/
├── LEARNING_PLAN.md           # Main learning plan with all phases and videos
├── README.md                  # This file - quick start guide
├── progress.json              # JSON file to track your progress
│
├── phase1_foundation/         # Phase 1: Testing mindset
│   └── notes.md              # Your notes for Phase 1
│
├── phase2_api_testing/        # Phase 2: API testing with Postman
│   └── notes.md              # Your notes for Phase 2
│
├── phase3_playwright/         # Phase 3: Playwright for Odoo UI
│   └── notes.md              # Your notes for Phase 3
│
├── phase4_cypress/            # Phase 4: Cypress alternative
│   └── notes.md              # Your notes for Phase 4
│
├── phase5_selenium/           # Phase 5: Selenium fallback
│   └── notes.md              # Your notes for Phase 5
│
├── phase6_jenkins/            # Phase 6: Jenkins CI/CD
│   └── notes.md              # Your notes for Phase 6
│
├── phase7_performance/        # Phase 7: JMeter load testing
│   └── notes.md              # Your notes for Phase 7
│
├── templates/                 # Reusable test templates
│   ├── odoo_login_test.py    # Login test template
│   ├── odoo_form_test.py     # Form test template
│   ├── odoo_api_test.py      # API test template
│   ├── playwright.config.js  # Playwright configuration
│   ├── pytest.ini            # Pytest configuration
│   ├── requirements.txt      # Python dependencies
│   ├── package.json          # Node.js dependencies
│   └── Jenkinsfile           # Jenkins pipeline template
│
└── examples/                  # Complete working examples
    └── example_sale_order_test.py  # Full sale order test example
```

---

## 🗺️ Learning Path

### Phase 1: Testing Mindset (Foundation)
**Duration:** 2-3 days  
**Videos:** 2  
**Goal:** Understand automation testing strategy

### Phase 2: API Testing (Odoo Controllers)
**Duration:** 3-4 days  
**Videos:** 2  
**Goal:** Test Odoo APIs with Postman

### Phase 3: Playwright (Primary Tool)
**Duration:** 1-2 weeks  
**Videos:** 5  
**Goal:** Master Playwright for Odoo UI testing

### Phase 4: Cypress (Optional)
**Duration:** 2-3 days  
**Videos:** 1  
**Goal:** Explore JavaScript-based alternative

### Phase 5: Selenium (Fallback)
**Duration:** 1-2 days  
**Videos:** 1  
**Goal:** Understand legacy tool options

### Phase 6: Jenkins CI/CD
**Duration:** 3-5 days  
**Videos:** 3  
**Goal:** Automate test execution in pipelines

### Phase 7: Performance Testing (Optional)
**Duration:** 2-3 days  
**Videos:** 1  
**Goal:** Load test Odoo endpoints

---

## ⚙️ Setup Instructions

### Prerequisites

1. **Python 3.8+**
   ```bash
   python3 --version
   ```

2. **Node.js 16+**
   ```bash
   node --version
   npm --version
   ```

3. **Odoo Instance**
   - Running Odoo instance (local or remote)
   - Admin credentials
   - Test database

### Environment Configuration

Create a `.env` file in the automation directory:

```bash
# Odoo Configuration
ODOO_URL=http://localhost:8069
ODOO_DB=your_database
ODOO_USER=admin
ODOO_PASSWORD=admin

# Test Configuration
TEST_TIMEOUT=30000
HEADLESS=false
BROWSER=chromium
```

### Verify Installation

```bash
# Test Python environment
python3 -c "import playwright; print('Playwright installed!')"

# Test Playwright
playwright --version

# Test Pytest
pytest --version
```

---

## 📖 Usage Guide

### Running Tests

#### Run All Tests
```bash
pytest
```

#### Run Specific Test File
```bash
pytest examples/example_sale_order_test.py
```

#### Run with Specific Browser
```bash
pytest --browser=chromium
pytest --browser=firefox
pytest --browser=webkit
```

#### Run in Headed Mode (See Browser)
```bash
pytest --headed
```

#### Run Specific Test Function
```bash
pytest examples/example_sale_order_test.py::test_create_and_confirm_sale_order
```

#### Run Tests by Marker
```bash
pytest -m smoke      # Run only smoke tests
pytest -m api        # Run only API tests
pytest -m ui         # Run only UI tests
```

### Recording Tests with Playwright

```bash
# Record actions on Odoo
playwright codegen http://localhost:8069

# Record with authentication
playwright codegen --save-storage=auth.json http://localhost:8069
```

### Debugging Tests

```bash
# Run in debug mode
pytest --headed --slowmo=1000

# Use Playwright inspector
PWDEBUG=1 pytest examples/example_sale_order_test.py
```

### Generating Reports

```bash
# Generate HTML report
pytest --html=test-results/report.html

# Generate JSON report
pytest --json-report --json-report-file=test-results/report.json
```

---

## 📊 Progress Tracking

### Method 1: Update LEARNING_PLAN.md

After watching each video:
1. Change status from `⬜ Not Watched` to `✅ Watched`
2. Add your notes in the Notes section
3. Update phase progress counter

### Method 2: Update progress.json

Edit `progress.json` to track:
- Videos watched
- Phases completed
- Deliverables finished
- Weekly goals

### Method 3: Use Git Commits

```bash
# Commit after completing each phase
git add .
git commit -m "Completed Phase 1: Testing Mindset"
```

---

## 🎓 Learning Tips

### Best Practices

1. **Watch Videos Actively**
   - Take notes in the phase-specific `notes.md` files
   - Pause and try examples yourself
   - Ask questions and research answers

2. **Practice Immediately**
   - Apply concepts to your Odoo modules right away
   - Start with simple tests and gradually increase complexity
   - Use the provided templates as starting points

3. **Build a Test Library**
   - Create reusable test utilities
   - Document your custom selectors for Odoo
   - Share patterns with your team

4. **Test Real Scenarios**
   - Focus on critical business workflows
   - Test edge cases and error conditions
   - Validate both happy paths and failure scenarios

### Common Odoo Testing Challenges

| Challenge | Solution |
|-----------|----------|
| Dynamic element IDs | Use data attributes or stable selectors |
| Slow page loads | Increase timeouts, wait for network idle |
| Modal dialogs | Wait for modal to appear before interacting |
| Many2one fields | Use autocomplete pattern from templates |
| AJAX calls | Wait for network idle or specific elements |

---

## 🔗 Resources

### Official Documentation
- [Playwright Docs](https://playwright.dev/)
- [Pytest Docs](https://docs.pytest.org/)
- [Odoo Documentation](https://www.odoo.com/documentation/)

### Video Series
- [Raghav Pal YouTube Channel](https://www.youtube.com/@RaghavPal)
- [Automation Step by Step Website](https://automationstepbystep.com/)

### Odoo Testing Resources
- [Odoo Testing Guide](https://www.odoo.com/documentation/18.0/developer/reference/backend/testing.html)
- [Odoo API Documentation](https://www.odoo.com/documentation/18.0/developer/reference/external_api.html)

### Community
- [Playwright Discord](https://discord.com/invite/playwright)
- [Odoo Community Forum](https://www.odoo.com/forum)

---

## 🛠️ Troubleshooting

### Common Issues

**Issue:** Playwright browsers not installed
```bash
# Solution
playwright install
playwright install-deps
```

**Issue:** Tests failing due to timeout
```bash
# Solution: Increase timeout in pytest.ini or test
pytest --timeout=60
```

**Issue:** Can't find Odoo elements
```bash
# Solution: Use Playwright inspector
PWDEBUG=1 pytest your_test.py
```

**Issue:** Authentication failures
```bash
# Solution: Verify credentials in .env file
# Check Odoo instance is running
curl http://localhost:8069/web/login
```

---

## 📝 Next Steps

1. **Start with Phase 1** - Open `LEARNING_PLAN.md` and watch the first video
2. **Set up your environment** - Install all dependencies
3. **Run example tests** - Try the example sale order test
4. **Create your first test** - Use templates to test your own Odoo module
5. **Track your progress** - Update progress.json after each milestone

---

## 🤝 Contributing

This is your personal learning repository, but you can:
- Share your custom test patterns with the team
- Document Odoo-specific testing tips
- Create additional examples for common scenarios
- Improve templates based on your experience

---

## 📧 Support

If you encounter issues:
1. Check the troubleshooting section above
2. Review the video series for clarification
3. Consult official documentation
4. Ask in Odoo community forums

---

## 📄 License

This learning material is for personal educational use.

---

**Happy Testing! 🎉**

Remember: The goal is not just to complete the videos, but to build practical skills you can apply to your Odoo projects. Take your time, practice extensively, and don't hesitate to experiment!

---

**Created for:** Sabry Youssef  
**Last Updated:** 2025-11-06  
**Version:** 1.0

