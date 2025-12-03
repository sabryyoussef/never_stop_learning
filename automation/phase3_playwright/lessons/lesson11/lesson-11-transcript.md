# Playwright Beginner Tutorial 11 | Hooks & Groups

## 📹 Video Information
- **Title:** Playwright Beginner Tutorial 11 | Hooks & Groups
- **Video ID:** S3NVJo0ySwE
- **URL:** https://www.youtube.com/watch?v=S3NVJo0ySwE
- **Series:** Playwright Tutorial for Beginners
- **Instructor:** Raghav Pal

---

## 📝 Video Description
Playwright Beginner Tutorial 11 | Hooks & Groups  
▬ ALL FREE COURSES ► https://automationstepbystep.com/  
▬ ASK RAGHAV ► https://bit.ly/2CoJGWf

---

## ⏰ Timestamps
- **00:00** – Introduction to hooks and grouping
- **00:24** – What are hooks? (`beforeAll`, `beforeEach`, `afterEach`, `afterAll`)
- **00:42** – Hands-on demo plan
- **02:00** – Creating login/home/logout tests
- **07:30** – Using `page.pause()` with Inspector to record steps
- **12:15** – Eliminating duplication via `beforeEach` and `afterAll`
- **16:10** – Grouping tests with `test.describe`
- **20:27** – Summary of hook behavior/order

---

## 🎯 Key Topics Covered
1. Hook lifecycle in Playwright and when to apply each
2. Reusing setup/teardown logic across tests
3. Grouping related tests with `test.describe`
4. Recording steps via Playwright Inspector to save time
5. Understanding hook execution order, especially with multiple registrations

---

## 💻 Code Samples
### Basic Hook Structure
```ts
import { test, expect } from '@playwright/test';

test.describe('All tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('https://www.saucedemo.com/');
    await page.locator('#user-name').fill('standard_user');
    await page.locator('#password').fill('secret_sauce');
    await page.locator('#login-button').click();
  });

  test.afterAll(async ({ page }) => {
    await page.close();
  });

  test('Home page', async ({ page }) => {
    await page.locator('.inventory_item').first().click();
    await expect(page).toHaveURL(/inventory-item/);
  });

  test('Logout', async ({ page }) => {
    await page.locator('#react-burger-menu-btn').click();
    await page.locator('#logout_sidebar_link').click();
    await expect(page).toHaveURL('https://www.saucedemo.com/');
  });
});
```

### Hook Execution Rules
- `beforeAll`: runs once before all tests (scope = file/describe block)
- `beforeEach`: runs before each test in scope
- `afterEach`: runs after each test in scope
- `afterAll`: runs once after all tests in scope
- Multiple hooks of same type execute in registration order

---

## 🔑 Key Takeaways
- Use `beforeEach` to centralize login/setup for grouped tests.
- `afterAll` is ideal for teardown tasks like closing pages or releasing resources.
- Group tests with `test.describe` to apply hooks to a specific subset.
- Order of hook registration matters; keep initialization logic in top-down order.
- Hooks work seamlessly with Playwright fixtures (`{ page }`, custom ones, etc.).

---

## 🛠️ Commands Used
```bash
npx playwright test tests/hooks-and-groups.spec.ts --project=chromium --headed
npx playwright show-report
```

---

## 🎓 Odoo-Specific Applications
- Use `beforeEach` to authenticate into Odoo once for each test, avoiding duplication.
- Group tests by module (e.g., `describe('Sales Orders')`) and apply targeted setup/teardown.
- `afterEach` can clean up created records or reset state between tests.
- Combine hooks with Odoo-specific fixtures (e.g., `await initOdooUsers(context)`).

---

## ✅ Practice Checklist
- [ ] Refactor existing Odoo tests to move authentication into `beforeEach`.
- [ ] Add `afterEach` to reset filters or log out when needed.
- [ ] Create `describe` blocks per Odoo module (Sales, Inventory, Manufacturing).
- [ ] Document hook responsibilities in `phase3_playwright/notes.md`.

---

## 📚 Additional Resources
- Hooks Documentation: https://playwright.dev/docs/test-advanced#fixtures
- Test Grouping: https://playwright.dev/docs/test-organizing
- Fixtures (advanced): https://playwright.dev/docs/test-fixtures

---

## 🗒️ Full Transcript
```00:00-12:15:lesson11/lesson-11-transcript.md
hello and welcome to this session I am
raghav and today we are going to learn
Hooks and groups in playwright this is
going to be very easy and very
interesting and I will go very basic
step by step we will see what are Hooks
and how do we use hooks in playwright
tests we will see what are groups how do
we group our tests in playwright and we
will see a Hands-On demo step by step
Hands-On demo so let's get started and
uh in playwright or in general as well
we have hoax where we can make some
tests or some steps done before all our
tests before each of our tests after all
our tests or after each of our tests so
let me show you a demo I'm going to my
playwright project here
```

```12:15-20:27:lesson11/lesson-11-transcript.md
this is how we can use these hooks now as of now we have not grouped our
test if you see here we have directly
added our tests inside the file but it
may happen a lot of times that you want
to run a particular group with some
different types of hook for example your
test file can have uh many tests let us
say for example your test file has 10
tests after out of these 10 tests you
want to group five tests and you want to
have a separate or before each before
all after each or after all hooks for
those set of five tests in that case you
can group these tests using the describe
block and for that you can say
```

---

*Transcript generated via YouTube MCP on November 7, 2025.*


