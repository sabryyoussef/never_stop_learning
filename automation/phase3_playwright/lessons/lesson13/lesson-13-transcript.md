# Playwright Tutorial | Page Object Model Demo

## 📹 Video Information
- **Title:** Easiest way | Playwright Page Object Model | Step by Step DEMO
- **Video ID:** rAec3mZFhF0
- **URL:** https://www.youtube.com/watch?v=rAec3mZFhF0
- **Instructor:** Raghav Pal

---

## 📝 Video Description
Full walkthrough for building a Playwright Page Object Model (POM) project using the internet.herokuapp.com login page. Includes project setup, test creation, page classes, and GitHub upload. Supporting resources linked in video description.

---

## ⏰ Timestamps
- **00:00** – Introduction & goal
- **00:20** – Create project folder and open in VS Code
- **02:09** – Initialize Node.js project (`npm init -y`)
- **03:05** – Install Playwright (`npm init playwright@latest`)
- **04:40** – Record a demo login test with `npx playwright codegen`
- **08:35** – Run tests & view results (`npx playwright test`, `show-report`)
- **12:47** – Create `pages/` directory for POM classes
- **14:55** – Create `LoginPage` class file (`pages/login.js`)
- **15:33** – Define locators & actions within the class
- **22:38** – Import and use page class inside test file
- **28:04** – Execute tests through POM implementation
- **30:40** – Push project to GitHub

---

## 🎯 Key Topics Covered
1. Node/Playwright project scaffolding
2. Using Playwright code generator to bootstrap tests
3. Fundamentals of Page Object Model (POM) in Playwright
4. Creating reusable page classes with locators & actions
5. Refactoring tests to consume page classes
6. Running tests and checking HTML reports
7. Publishing project to GitHub repository

---

## 💻 Code Snippets
### `pages/login.js`
```js
class LoginPage {
  constructor(page) {
    this.page = page;
    this.usernameTextbox = page.locator('#username');
    this.passwordTextbox = page.locator('#password');
    this.loginButton = page.locator('button[type="submit"]');
  }

  async goto() {
    await this.page.goto('https://the-internet.herokuapp.com/login');
  }

  async login(username, password) {
    await this.usernameTextbox.fill(username);
    await this.passwordTextbox.fill(password);
    await this.loginButton.click();
  }
}

module.exports = { LoginPage };
```

### `tests/login.spec.js`
```js
const { test, expect } = require('@playwright/test');
const { LoginPage } = require('../pages/login');

test('Login via POM', async ({ page }) => {
  const login = new LoginPage(page);
  await login.goto();
  await login.login('tomsmith', 'SuperSecretPassword!');
  await expect(page.locator('#flash')).toContainText('You logged into a secure area!');
  await page.close();
});
```

### Commands
```bash
npm init -y
npm init playwright@latest
npx playwright codegen https://the-internet.herokuapp.com/login
npx playwright test --project=chromium --headed
npx playwright show-report
```

---

## 🔑 Key Takeaways
- Structure Playwright projects with `pages/` for reusable page objects.
- Keep locators & actions encapsulated to simplify test maintenance.
- Constructors accept the Playwright `page` fixture, enabling context reuse.
- POM increases readability of tests by hiding boilerplate interactions.
- GitHub versioning ensures reproducibility and collaboration.

---

## ✅ Practice Checklist
- [ ] Recreate the POM login demo locally.
- [ ] Add additional page classes (e.g., SecureAreaPage) for assertions.
- [ ] Convert existing Playwright tests to use page objects.
- [ ] Push the POM project to your own GitHub repo.
- [ ] Document the POM approach in `phase3_playwright/notes.md`.

---

## 🗒️ Full Transcript
```00:00-30:40:lesson13/lesson-13-transcript.md
hello and welcome I am raghav from
automationstepbystep.com and in this
session we are going to go very basic
step by step and we are going to learn
how do we create a page object model
design project or framework with
playwright and this is going to be very
easy and very interesting ...
```

*Transcript generated via YouTube MCP on November 7, 2025.*


