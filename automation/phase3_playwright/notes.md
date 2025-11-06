# Phase 3: Playwright (Primary Tool for Odoo UI Testing) - Notes

## 📚 Learning Objectives
- Master Playwright for browser automation
- Create robust UI tests for Odoo forms and workflows
- Implement reusable test patterns

---

## 🎥 Video 1: What is Playwright

**Video Link:** https://www.youtube.com/watch?v=4_m3HsaNwOE  
**Status:** ✅ Watched  
**Date Watched:** 2025-11-06

### Key Takeaways - Features of Playwright

**Core Features:**
- Free | Open Source
- Easy Setup and Configuration
- Fast execution
- Auto-wait (automatic waiting for elements)
- Built-in assertions | Less Flaky tests
- Test retry, logs, screenshots, videos

**Cross-Platform Support:**
- Multi-Browser (Chromium, Firefox, WebKit)
- Multi-Language (Python, JavaScript, Java, .NET)
- Multi-OS (Windows, Linux, macOS)
- Emulate mobile devices, geolocations

**Testing Capabilities:**
- Functional testing
- API testing
- Accessibility testing
- Multi-tab and multi-window support
- Frames | Shadow DOM support
- Test parallel execution
- Parallel testing

**Developer Experience:**
- Recording (Codegen)
- Debugging tools
- Explore selectors (Inspector)
- Built-in Reporters | Custom Reporters

**CI/CD Integration:**
- CI/CD support
- Docker support

### Odoo-Specific Applications
- Testing Odoo form views across multiple browsers
- Automating menu navigation with auto-wait feature
- Validating webclient behavior with built-in assertions
- Taking screenshots/videos of Odoo workflows for documentation
- Testing Odoo API endpoints alongside UI tests
- Running parallel tests for different Odoo modules
- Emulating mobile devices to test Odoo's responsive design

### Action Items
- [x] Understand Playwright's key features
- [x] Identify which features are most useful for Odoo testing
- [ ] Plan which browsers to test Odoo with (Chromium, Firefox, WebKit)
- [ ] Consider mobile device emulation for Odoo's mobile view 

---

## 🎥 Video 2: Install Playwright

**Video Link:** https://www.youtube.com/watch?v=IB2P1FBXjcQ  
**Status:** ✅ Watched  
**Date Watched:** 2025-11-06

### Key Takeaways
- **Prerequisites**: Node.js (v14+) and npm are required
- **Installation**: Use `npm install --save-dev playwright` for project-specific installation
- **Verify Installation**: Use `npx playwright --version` to check installed version
- **VS Code Extension**: Install Playwright Test for VS Code for better development experience
- **Version Installed**: Playwright 1.56.1

### Installation Steps Completed
```bash
# 1. Verified Node.js and npm
node -v          # v22.21.1
npm -v           # v9.2.0

# 2. Installed Playwright locally in project
npm install --save-dev playwright

# 3. Verified installation
npx playwright --version    # Version 1.56.1
```

### System Configuration
- **Node.js Version**: v22.21.1
- **npm Version**: v9.2.0
- **Playwright Version**: 1.56.1
- **Node Path**: /usr/bin/node
- **Installation Type**: Local (project-specific)
- **VS Code Extension**: ✅ Installed

### Odoo-Specific Applications
- Playwright now ready to automate Odoo browser testing
- Can integrate Playwright inside Odoo project folder
- Ready to configure for CI environment (Jenkins/GitHub Actions)
- Can use Playwright codegen to record Odoo workflows

### Action Items
- [x] Install Node.js and npm
- [x] Install Playwright in project
- [x] Install VS Code Playwright extension
- [x] Verify Playwright installation
- [x] Install Playwright browsers: `npx playwright install` ✅
  - Chromium v141.0.7390.37 ✅
  - Firefox v142.0.1 ✅
  - WebKit v26.0 ✅
- [x] Configure Playwright for Odoo testing ✅
  - Created centralized config at: `~/playwright-configs/odoo-base.config.js`
  - Config works with ALL Odoo versions (14, 15, 16, 17, 18+)
  - Can be copied/linked to any Odoo project
- [x] Create reusable Playwright config system ✅ 

---

## 🎥 Video 3: 
 
**Video Link:** https://www.youtube.com/watch?v=LTwg0kqdK4I&list=PLhW3qG5bs-L9sJKoT1LC5grGT77sfW0Z8&index=3  
**Status:** ⬜ Not Watched  
**Date Watched:** _____

### Key Takeaways
- 
- 
- 

### Odoo-Specific Applications
- Record "Create > Save > Confirm" flows
- Test Sales Order creation
- Test custom module workflows

### Action Items
- [ ] Record first Odoo test
- [ ] Run and verify test
- [ ] 

---

## 🎥 Video 4: Locators and Assertions

**Video Link:** https://www.youtube.com/watch?v=JpGsWZ6Tjrs  
**Status:** ⬜ Not Watched  
**Date Watched:** _____

### Key Takeaways
- 
- 
- 

### Odoo-Specific Applications
- Locate Odoo buttons by data attributes
- Assert notification messages
- Validate form field values

### Action Items
- [ ] Learn Odoo-specific selectors
- [ ] Create assertion library
- [ ] 

---

## 🎥 Video 5: Hooks & Groups

**Video Link:** https://www.youtube.com/watch?v=S3NVJo0ySwE  
**Status:** ⬜ Not Watched  
**Date Watched:** _____

### Key Takeaways
- 
- 
- 

### Odoo-Specific Applications
- Pre-login hooks for tests
- Setup test data before tests
- Cleanup after test runs

### Action Items
- [ ] Create login hook
- [ ] Implement test data setup
- [ ] 

---

## 📋 Phase Deliverable

**Task:** Create reusable Playwright test templates for Odoo forms

### Test Templates to Create:
1. **Login Test Template**
2. **Form Creation Test Template**
3. **Form Validation Test Template**
4. **Workflow Test Template**
5. **Button Action Test Template**

### Common Odoo Selectors:
```python
# Form buttons
SAVE_BUTTON = "button[name='action_confirm']"
CREATE_BUTTON = ".o_list_button_add"
EDIT_BUTTON = ".o_form_button_edit"

# Form fields
INPUT_FIELD = "input[name='field_name']"
SELECT_FIELD = "select[name='field_name']"

# Notifications
SUCCESS_NOTIFICATION = ".o_notification_success"
ERROR_NOTIFICATION = ".o_notification_danger"
```

---

## 💡 Playwright Best Practices for Odoo
- Use data attributes for stable selectors
- Wait for Odoo's loading indicators to disappear
- Handle modal dialogs properly
- Test in multiple browsers (Chromium, Firefox, WebKit)

## ❓ Questions to Research
- How to handle Odoo's dynamic form rendering?
- Best way to wait for Odoo AJAX calls?
- How to test Odoo's OWL components?

