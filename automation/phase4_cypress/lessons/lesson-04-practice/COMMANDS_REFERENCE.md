# Cypress Commands Reference for Odoo Testing

Quick reference guide for running Cypress tests for Odoo applications.

## 📦 Installation

```bash
# Install Cypress
npm install

# Or install Cypress globally
npm install -g cypress
```

## 🚀 Basic Commands

### Open Cypress Test Runner (Interactive Mode)
```bash
npx cypress open
# or
npm run test:headed
```

### Run All Tests (Headless Mode)
```bash
npx cypress run
# or
npm test
```

### Run Specific Test File
```bash
npx cypress run --spec "cypress/e2e/login.cy.js"
npx cypress run --spec "cypress/e2e/sale-order.cy.js"
npx cypress run --spec "cypress/e2e/**/*"
```

## 🌐 Browser Selection

### Run in Specific Browser
```bash
npx cypress run --browser chrome
npx cypress run --browser firefox
npx cypress run --browser edge
# or use npm scripts
npm run test:chrome
npm run test:firefox
npm run test:edge
```

### List Available Browsers
```bash
npx cypress info
```

## 🎯 Test Filtering

### Run Tests by Name Pattern
```bash
npx cypress run --spec "cypress/e2e/**/login*"
npx cypress run --spec "cypress/e2e/**/sale*"
```

### Run Multiple Spec Files
```bash
npx cypress run --spec "cypress/e2e/login.cy.js,cypress/e2e/sale-order.cy.js"
```

## 🎬 Recording and Reporting

### Record Test Run
```bash
npx cypress run --record --key <project-key>
```

### Generate Custom Report
```bash
npx cypress run --reporter json
npx cypress run --reporter junit
```

### Save Screenshots
```bash
# Screenshots are automatically saved on failure to:
# cypress/screenshots/
```

### Save Videos
```bash
# Enable video in cypress.config.js
# Videos saved to: cypress/videos/
npx cypress run --config video=true
```

## 🔧 Configuration

### Override Config Values
```bash
npx cypress run --config baseUrl=http://localhost:8069
npx cypress run --config viewportWidth=1280,viewportHeight=720
npx cypress run --config defaultCommandTimeout=10000
```

### Use Custom Config File
```bash
npx cypress run --config-file cypress.prod.config.js
```

### Set Environment Variables
```bash
npx cypress run --env odoo_url=localhost:8069,odoo_user=admin
```

## 🐛 Debugging

### Run in Debug Mode
```bash
# Use Cypress Test Runner for debugging
npx cypress open
```

### Show Browser Console
```bash
npx cypress run --headed --no-exit
```

### Slow Down Test Execution
```javascript
// Add in test file
cy.wait(1000)  // Wait 1 second
```

## 📊 Parallel Execution

### Run Tests in Parallel (Requires Cypress Dashboard)
```bash
npx cypress run --record --parallel
```

## 🔍 Useful Flags

| Flag | Description | Example |
|------|-------------|---------|
| `--headed` | Run in headed mode (show browser) | `npx cypress run --headed` |
| `--browser` | Specify browser | `npx cypress run --browser chrome` |
| `--spec` | Specify test file(s) | `npx cypress run --spec "**/*login*"` |
| `--config` | Override config | `npx cypress run --config baseUrl=...` |
| `--env` | Set environment variables | `npx cypress run --env user=admin` |
| `--record` | Record to Cypress Dashboard | `npx cypress run --record` |
| `--parallel` | Run tests in parallel | `npx cypress run --parallel` |
| `--quiet` | Suppress output | `npx cypress run --quiet` |
| `--no-exit` | Keep browser open after tests | `npx cypress run --no-exit` |

## 🎯 Odoo-Specific Commands

### Test Odoo Login
```bash
npx cypress run --spec "cypress/e2e/login.cy.js"
```

### Test Sale Order Workflow
```bash
npx cypress run --spec "cypress/e2e/sale-order.cy.js"
```

### Run Against Different Odoo Instance
```bash
npx cypress run --config baseUrl=http://odoo-staging:8069
npx cypress run --config baseUrl=http://demo.odoo.com
```

## 📝 Package.json Scripts

Add these to your `package.json`:

```json
{
  "scripts": {
    "test": "cypress run",
    "test:headed": "cypress open",
    "test:chrome": "cypress run --browser chrome",
    "test:firefox": "cypress run --browser firefox",
    "test:edge": "cypress run --browser edge",
    "test:login": "cypress run --spec 'cypress/e2e/login.cy.js'",
    "test:sale": "cypress run --spec 'cypress/e2e/sale-order.cy.js'",
    "test:all-browsers": "cypress run --browser chrome && cypress run --browser firefox"
  }
}
```

Then run with:
```bash
npm test
npm run test:headed
npm run test:chrome
npm run test:login
```

## 🎓 Best Practices

1. **Use custom commands** for repeated Odoo actions
2. **Run in headed mode** when developing tests
3. **Use specific specs** for faster iteration
4. **Record videos** only when needed (they're large)
5. **Take screenshots** on failures automatically
6. **Use environment variables** for credentials
7. **Run different browsers** to ensure compatibility

## 🔗 Useful Links

- [Cypress Documentation](https://docs.cypress.io/)
- [Cypress CLI](https://docs.cypress.io/guides/guides/command-line)
- [Cypress Best Practices](https://docs.cypress.io/guides/references/best-practices)

---

**Last Updated:** 2025-11-06  
**For:** Odoo UI Automation Testing - Phase 4

