# Lesson 04: Cypress Practice for Odoo Testing

This directory contains practice exercises for learning Cypress with Odoo applications.

## 📦 Setup

### 1. Install Dependencies
```bash
npm install
```

This will install Cypress and all required dependencies.

### 2. Configure Odoo URL
Edit `cypress.config.js` and update the `baseURL`:
```javascript
baseUrl: 'http://localhost:8069',  // Your Odoo instance URL
```

### 3. Update Credentials
Edit test files and update login credentials:
- `cypress/e2e/login.cy.js`
- `cypress/e2e/sale-order.cy.js`

## 🚀 Running Tests

### Open Cypress Test Runner (Interactive)
```bash
npm run test:headed
# or
npx cypress open
```

### Run Tests in Headless Mode
```bash
npm test
# or
npx cypress run
```

### Run Tests in Specific Browser
```bash
npm run test:chrome
npm run test:firefox
npm run test:edge
```

### Run Specific Test File
```bash
npx cypress run --spec "cypress/e2e/login.cy.js"
```

## 📁 Project Structure

```
lesson-04-practice/
├── cypress/
│   ├── e2e/                    # Test files
│   │   ├── example.cy.js       # Basic example test
│   │   ├── login.cy.js         # Login tests
│   │   └── sale-order.cy.js    # Sale order workflow tests
│   ├── fixtures/               # Test data
│   │   └── example.json
│   └── support/                # Custom commands and setup
│       ├── commands.js         # Custom Odoo commands
│       └── e2e.js             # Global configuration
├── cypress.config.js           # Cypress configuration
├── package.json               # Dependencies and scripts
└── README.md                  # This file
```

## 🎯 Test Files

### 1. example.cy.js
Basic Cypress example to verify setup:
- Visit Odoo login page
- Check page elements

### 2. login.cy.js
Odoo login functionality tests:
- Display login form
- Login with valid credentials
- Handle invalid credentials
- Use custom login command

### 3. sale-order.cy.js
Complete Sale Order workflow tests:
- Navigate to Sales module
- Create new quotation
- Add products to order
- Confirm quotation

## 🛠️ Custom Commands

Custom Odoo commands are defined in `cypress/support/commands.js`:

### cy.odooLogin(username, password, database)
```javascript
cy.odooLogin('admin', 'admin', 'my_database')
```

### cy.odooNavigateToApp(appName)
```javascript
cy.odooNavigateToApp('Sales')
```

### cy.odooCreateRecord()
```javascript
cy.odooCreateRecord()
```

### cy.odooSaveForm()
```javascript
cy.odooSaveForm()
```

### cy.odooFillMany2one(fieldName, value)
```javascript
cy.odooFillMany2one('partner_id', 'Azure Interior')
```

### cy.odooWaitLoading()
```javascript
cy.odooWaitLoading()
```

### cy.odooCheckNotification(type, message)
```javascript
cy.odooCheckNotification('success', 'Record saved')
```

## 📝 Configuration Details

### cypress.config.js Settings

```javascript
{
  baseUrl: 'http://localhost:8069',
  viewportWidth: 1920,
  viewportHeight: 1080,
  defaultCommandTimeout: 15000,    // 15 seconds for commands
  pageLoadTimeout: 45000,          // 45 seconds for page loads
  requestTimeout: 15000,
  responseTimeout: 15000,
  video: false,
  screenshotOnRunFailure: true,
  retries: {
    runMode: 2,    // Retry failed tests twice in CI
    openMode: 0    // No retries in interactive mode
  }
}
```

## 🎓 Learning Exercises

### Exercise 1: Basic Navigation
1. Run `example.cy.js`
2. Observe how Cypress interacts with the page
3. Try modifying assertions

### Exercise 2: Login Testing
1. Run `login.cy.js`
2. Update credentials for your Odoo instance
3. Add a new test for "forgot password" link

### Exercise 3: Sale Order Workflow
1. Run `sale-order.cy.js`
2. Customize for your Odoo setup
3. Add test for canceling an order

### Exercise 4: Create Your Own Test
Create `cypress/e2e/my-test.cy.js`:
```javascript
describe('My Custom Test', () => {
  it('should do something', () => {
    cy.odooLogin('admin', 'admin')
    // Your test code here
  })
})
```

## 🔍 Debugging Tips

1. **Use Cypress Test Runner**: `npm run test:headed`
2. **Time Travel**: Click on commands in the test runner to see the state
3. **Console Logs**: Add `cy.log('Debug message')`
4. **Pause Test**: Add `cy.pause()` to stop execution
5. **Screenshots**: Automatically taken on failure

## 📊 Comparison with Playwright

| Feature | Cypress | Playwright |
|---------|---------|------------|
| Language | JavaScript | JavaScript/Python/Java/.NET |
| Browser Support | Chrome, Firefox, Edge | Chrome, Firefox, Safari |
| Speed | Good | Excellent |
| Odoo Testing | ✅ Good | ✅ Excellent |
| Learning Curve | Easy | Moderate |

## 🎯 Next Steps

1. Complete all exercises
2. Create tests for your own Odoo modules
3. Compare Cypress vs Playwright experience
4. Update comparison matrix in `phase4_cypress/notes.md`

---

**Created for:** Odoo UI Automation Testing Learning Path  
**Phase:** 4 - Cypress Alternative  
**Lesson:** 04 - Cypress Basics

