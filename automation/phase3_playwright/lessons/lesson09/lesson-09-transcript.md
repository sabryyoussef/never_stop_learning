# Playwright Beginner Tutorial 9 | Assertions

## 📹 Video Information
- **Title:** Playwright Beginner Tutorial 9 | Assertions
- **Video ID:** hYNOFle3zic
- **URL:** https://www.youtube.com/watch?v=hYNOFle3zic
- **Series:** Playwright Tutorial for Beginners
- **Instructor:** Raghav Pal

---

## 📝 Video Description
Playwright Beginner Tutorial 9 | Assertions  
▬ ALL FREE COURSES ► https://automationstepbystep.com/  
▬ QUIZ ► https://forms.gle/CyH64LrA39FLqbtC7

---

## ⏰ Timestamps
- **00:00** – Introduction & assertion purpose
- **00:21** – What assertions are (actual vs expected)
- **00:56** – Playwright `expect` API overview
- **02:34** – Creating a test scaffold for assertions
- **04:07** – Demo app: Applitools Kitchen
- **06:37** – Presence checks (`toHaveCount`)
- **11:30** – Visibility checks (`toBeVisible`, `toBeHidden`)
- **12:17** – Enabled/disabled checks (`toBeEnabled`, `toBeDisabled`)
- **15:23** – Soft assertions (`expect.soft`)
- **16:50** – Text assertions (`toHaveText`, negative asserts)
- **18:12** – Attribute/class assertions
- **23:12** – Page URL and title assertions
- **25:36** – Visual assertions (`toHaveScreenshot`)
- **29:27** – Wrap-up

---

## 🎯 Key Topics Covered
1. Using Playwright’s built-in `expect` library for robust checks
2. Presence, visibility, and enabled state validations
3. Soft assertions to continue execution after failures
4. Matching text, attributes, and classes (support for regex)
5. URL/title assertions for navigation validation
6. Visual regression with `toHaveScreenshot`
7. Managing timeouts and retries via `playwright.config.ts`

---

## 💻 Code Samples
### Test Setup
```ts
import { test, expect } from '@playwright/test';

test('Assertions demo', async ({ page }) => {
  await page.goto('https://kitchen.applitools.com/');
  await expect(page.locator('text=The Kitchen')).toHaveCount(1);
  await expect(page.locator('text=The Kitchen')).toBeVisible();
  await expect(page.locator('text=The Kitchen')).toHaveText('The Kitchen');
  await expect(page).toHaveURL(/kitchen.applitools.com/);
  await expect(page).toHaveTitle(/Kitchen/);
  await expect(page).toHaveScreenshot();
});
```

### Soft Assertions
```ts
await expect.soft(page.locator('text=The Kitchen'))
  .not.toHaveText('ABCD');
```

### Attribute Assertions
```ts
await expect(page.locator('text=The Kitchen'))
  .toHaveAttribute('class', /.*navbar-brand.*/);

await expect(page.locator('#cook-button'))
  .toHaveClass(/.*btn-primary.*/);
```

### Wait Configuration (optional)
```ts
// playwright.config.ts
export default defineConfig({
  use: {
    expect: { timeout: 2000 },
  },
});
```

---

## 🔑 Key Takeaways
- Assertions are first-class citizens in Playwright; no external libs required.
- `expect(locator)` automatically waits for conditions (visibility, stability).
- Use `expect.soft` when you need to accumulate failures but continue steps.
- Attribute assertions support regex, making dynamic class checks easier.
- Visual comparison with `toHaveScreenshot` protects against UI regressions.

---

## 🛠️ Commands Used
```bash
npx playwright test tests/assertions.spec.ts --project=chromium --headed
npx playwright test tests/assertions.spec.ts --project=chromium --debug
```

---

## 🎓 Odoo-Specific Applications
- Assert breadcrumbs, view titles, and URL patterns after navigation.
- Validate button state (`toBeDisabled`) for workflow guards (e.g., draft vs posted).
- Use soft assertions to collect multiple form field errors in a single run.
- Capture screenshots for critical Odoo views (Kanban, reports) as baseline visuals.

---

## ✅ Practice Checklist
- [ ] Add presence, visibility, and text assertions to the Odoo login smoke test.
- [ ] Configure soft assertions for optional warning banners.
- [ ] Assert menu breadcrumb text matches the expected module name.
- [ ] Add `toHaveScreenshot` to a key Odoo dashboard page; store baseline in repo.
- [ ] Document chosen assertions in `phase3_playwright/notes.md`.

---

## 📚 Additional Resources
- Assertion Guide: https://playwright.dev/docs/test-assertions
- Visual Comparisons: https://playwright.dev/docs/test-snapshots
- Expect API Reference: https://playwright.dev/docs/api/class-expect

---

## 🗒️ Full Transcript
```00:00-14:30:lesson09/lesson-09-transcript.md
hello and welcome i'm raghav and today
we are going to learn something very
easy and very interesting and that is
assertions in playwright so in this
session we will see what are assertions
we will see what are the assessions in
playwright and then we will see how to
add assertions in our test in playwright
so this is going to be very interesting
let's get started with what are
assertions now in very very simple words
assertions are like checks or
verifications that we do in our test for
example if i want to check if an element
is present or not present if a text is
present or not present or if the element
has some particular value or not all
these will be assertions so
we actually check uh these things and
whenever we add a session it checks
whatever we have given in the session is
it equal to the actual and if actual and
expected are equal it will pass
otherwise it will fail the test so in
assertions uh in playwright we use the
expect keyword this comes from the jest
testing test runner and this is what we
use and it comes inbuilt in the
playwright library so we can directly
say expect and then we can write our
assertions in a moment i will show you
how to add a sessions so in this session
we are going to see how to check if an
element is present or not present
visible or hidden enabled or disabled
whether the text matches some particular
value or does not match a particular
value we can check the element attribute
as well like the class id or any
attribute that you want to check we can
check the page url
```

```14:30-29:27:lesson09/lesson-09-transcript.md
and we have already seen how to use the soft
accessions we just add this soft keyword
after expect so i hope this was very
useful for you if you have any questions
you can let me know and i will see you
in the next session thank you for
watching and never stop learning
```

---

*Transcript generated via YouTube MCP on November 7, 2025.*


