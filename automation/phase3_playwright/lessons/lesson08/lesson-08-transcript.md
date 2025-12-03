# Playwright Beginner Tutorial 8 | Demo Login Tests

## 📹 Video Information
- **Title:** Playwright Beginner Tutorial 8 | Demo Login Test
- **Video ID:** KSzmCo9xxVs
- **URL:** https://www.youtube.com/watch?v=KSzmCo9xxVs
- **Series:** Playwright Tutorial for Beginners
- **Instructor:** Raghav Pal

---

## 📝 Video Description
Playwright Beginner Tutorial 8 | Demo Login Test  
▬ ALL FREE COURSES ► https://automationstepbystep.com/  
▬ QUIZ ► https://forms.gle/F1K2XyT8PVX3YUz28

---

## ⏰ Timestamps
- **00:00** – Introduction & test objectives
- **00:15** – Overview of demo applications (Applitools, OrangeHRM, nopCommerce)
- **01:20** – Login Test 1: Applitools demo app
- **08:39** – Handling waits and selectors for reliability
- **11:41** – Login Test 2: OrangeHRM dashboard
- **14:35** – Login Test 3: nopCommerce admin portal

---

## 🎯 Key Topics Covered
1. Setting up Playwright tests for real-world login workflows
2. Using `page.pause()` and Inspector to capture locators quickly
3. Recording flows vs. hand-coding locators
4. Waiting strategies: `waitForSelector`, `expect(locator).toHaveCount()`
5. Cleaning reusable login logic (clear fields, fill, submit, assert)
6. Closing pages and validating post-login URLs

---

## 💻 Code Samples
### Test 1 – Applitools Demo
```ts
test('Login demo test 1', async ({ page }) => {
  await page.goto('https://demo.applitools.com/');
  await page.locator('[placeholder="Enter your username"]').fill('Raghav');
  await page.locator('[placeholder="Enter your password"]').fill('1234');
  await page.locator('text=Sign in').click();
  await expect(page.locator('text=ACME')).toBeVisible();
});
```

### Wait Helpers Used
```ts
await page.waitForSelector('text=Sign in', { timeout: 4000 });
await expect(page.locator('text=Sign in')).toHaveCount(1);
```

### Test 2 – OrangeHRM
```ts
test('Login demo test 2', async ({ page }) => {
  await page.goto('https://opensource-demo.orangehrmlive.com/web/index.php/auth/login');
  await page.locator('[placeholder="Username"]').fill('Admin');
  await page.locator('[placeholder="Password"]').fill('admin123');
  await page.locator('button:has-text("Login")').click();
  await page.locator('p:has-text("Paul Collings")').click();
  await page.locator('text=Logout').click();
  await page.close();
});
```

### Test 3 – nopCommerce Admin
```ts
test('Login demo test 3', async ({ page }) => {
  await page.goto('https://admin-demo.nopcommerce.com/login');
  await page.locator('input[name="Email"]').fill('admin@yourstore.com');
  await page.locator('input[name="Password"]').fill('admin');
  await page.locator('text=Log in').click();
  await page.locator('#nopSideBarPusher i').click();
  await page.locator('text=Logout').click();
  await page.waitForURL('**/login?ReturnUrl=%2Fadmin%2F');
  await page.close();
});
```

---

## 🔑 Key Takeaways
- `page.pause()` + Inspector accelerates locator capture and script authoring.
- Explicit waits (`waitForSelector`, expectations) help when pages render slowly.
- Clearing fields (`Control+A`) before `fill()` avoids residual default values.
- Use `page.close()` for cleanup when a test finishes on a dedicated page.
- Recording flows is useful for scaffolding; refactor into reusable helpers for production.

---

## 🛠️ Commands Used
```bash
npx playwright test tests/login_demo.spec.ts --project=chromium --headed
npx playwright test tests/login_demo.spec.ts --project=chromium --debug
```

---

## 🎓 Odoo-Specific Applications
- Adapt these flows for Odoo backend login and post-login checks (e.g., presence of the user avatar).
- Wrap authentication in a helper to reuse across module tests.
- Validate landing URLs (`waitForURL`) to ensure proper redirect after login.
- Add waits for Odoo menus or breadcrumbs before proceeding to module-specific steps.

---

## ✅ Practice Checklist
- [ ] Recreate the three login tests locally and confirm they pass.
- [ ] Convert one test into a reusable `login(page, user)` helper for Odoo.
- [ ] Add `expect` assertions for post-login UI elements (e.g., company name).
- [ ] Experiment with recording vs. handcrafted selectors; note differences.
- [ ] Document reusable login utilities in `phase3_playwright/notes.md`.

---

## 📚 Additional Resources
- Playwright Assertions: https://playwright.dev/docs/test-assertions
- Waiting Best Practices: https://playwright.dev/docs/actionability
- nopCommerce Demo: https://admin-demo.nopcommerce.com/login

---

## 🗒️ Full Transcript
```00:00-08:39:lesson08/lesson-08-transcript.md
hello and welcome i'm raghav and today
we are going to create a sample login
test and you can follow along with me
and you can do hands-on so we are going
to create a demo login test and the
applications i am going to use is
i will first go to this
link
demo.epitools.com and here we will do
login on this page then i will show you
a login test on this link that is
orange hrm live application and we will
do login on this page and then i will
also show you login on this demo
application that is uh no commerce dot
com login page so we will see different
login pages and how do we do login test
so let's get started i will go to my
vs code and my project is already open
here i will go to the tests folder here
and i will create a new file
and i will call it as
login
underscore demo dot spec
dot gs
```

```08:39-14:35:lesson08/lesson-08-transcript.md
you can see here all these options or
the properties so we have
a id of this page so id is username then
we have class property then we have
placeholder property that says enter
your username then i have typed property
so i have so many we have so many
properties here and we can create a
locator as we have learnt in the earlier
session but because we are using an
automation tool we should use the
features we should use the option of the
tool to create the locators for us or to
give us the object selectors so for that
what i'm going to do is i will
have
i want to open the playwright inspector
and from the playwright inspector window
i want to explore and find the object
locators or the object selectors so for
that i will just add the command to
pause so i will say await page dot pause
and in playwright when i say page dot
pause
the execution will pause here and it
will open the playwright inspector
window and from there we can either
record and we can uh explore and find the
objects we have also learned earlier how
to record a test and you can also use
that way but for now let us do this way
here
to run this i will say i will go to the
terminal
and i will say npx
playwright
test and i want to run this specific
file so i will
```

```14:35-17:30:lesson08/lesson-08-transcript.md
so this is how we can do login test and this is
the example all these examples that we
have seen so i hope you can do some more
hands-on now and try to
do some more login tests on some demo
applications if you have any questions
you can let me know i will see you in
the next session thank you for watching
and never stop learning
```

---

*Transcript generated via YouTube MCP on November 7, 2025.*


