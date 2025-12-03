# Playwright Beginner Tutorial 12 | Annotations & Tags

## 📹 Video Information
- **Title:** Playwright Beginner Tutorial 12 | Annotation & Tags
- **Video ID:** 9dSRZ-oswlM
- **URL:** https://www.youtube.com/watch?v=9dSRZ-oswlM
- **Series:** Playwright Tutorial for Beginners
- **Instructor:** Raghav Pal

---

## 📝 Video Description
Playwright Beginner Tutorial 12 | Annotation & Tags  
▬ ALL FREE COURSES ► https://automationstepbystep.com/  
▬ ASK RAGHAV ► https://bit.ly/2CoJGWf

---

## ⏰ Timestamps
- **00:00** – Introduction to annotations and tags
- **00:32** – Annotation overview: `only`, `skip`, `fail`, `fixme`, `slow`
- **03:09** – `test.skip` usage
- **05:20** – `test.fail` to expect failures
- **06:39** – `test.fixme` for temporarily disabled tests
- **07:36** – `test.slow` tripling timeouts
- **08:21** – `test.only` to focus specific tests
- **10:28** – Tagging tests with `@smoke`, `@reg`, etc.
- **12:30** – Running tagged tests via CLI (`--grep`, `--grep-invert`)
- **13:54** – Recap: using annotations to control execution

---

## 🎯 Key Topics Covered
1. When and why to use Playwright annotations
2. Controlling test execution flow (`skip`, `fail`, `fixme`, `slow`)
3. Scoped runs with `test.only`
4. Tagging strategy for test suites (smoke, regression, sanity)
5. CLI filtering using `--grep` and `--grep-invert`

---

## 💻 Code Samples
### Common Annotations
```ts
test.skip('skip this test', async ({ page }) => {
  // Will be skipped
});

test('expected to fail', async ({ page }) => {
  test.fail();
  // Test must fail to pass overall run
});

test.fixme('needs investigation', async ({ page }) => {
  // Marked to be fixed later; treated as skipped
});

test('slow test', async ({ page }) => {
  test.slow();
  // Timeout triples for this test
});

// Run only this test during the session
test.only('focused test', async ({ page }) => {
  // ...
});
```

### Tagging and CLI Filters
```ts
test('Login flow @smoke', async ({ page }) => {
  // ...
});

// Run only @smoke tests
npx playwright test --grep "@smoke"

// Skip @smoke tests
npx playwright test --grep-invert "@smoke"
```

---

## 🔑 Key Takeaways
- Annotations enable fine-grained control without modifying test logic.
- `test.fail` helps mark known failing scenarios while preserving pipeline integrity.
- `test.fixme` is ideal for temporarily disabling broken tests.
- Tagging supports flexible suite selection (CI smoke vs. full regression).
- Combine annotations with `test.describe` and hooks for sophisticated orchestration.

---

## 🛠️ Commands Used
```bash
npx playwright test tests/annotations-and-tags.spec.ts --project=chromium
npx playwright test --grep "@smoke"
npx playwright test --grep-invert "@smoke"
```

---

## 🎓 Odoo-Specific Applications
- Tag flows by module (`@sales`, `@inventory`) to run targeted suites.
- Use `test.fail` for known Odoo bugs awaiting fixes, keeping CI green.
- `test.fixme` useful when a feature is under development or blocked.
- Mark long-running end-to-end scenarios with `test.slow` to extend timeouts.

---

## ✅ Practice Checklist
- [ ] Tag existing Odoo smoke tests with `@smoke` and verify CLI filtering.
- [ ] Use `test.fixme` for failing tests linked to open issues.
- [ ] Apply `test.slow` to lengthy report generation scenarios.
- [ ] Document annotation usage guidelines in `phase3_playwright/notes.md`.

---

## 📚 Additional Resources
- Annotations Reference: https://playwright.dev/docs/test-annotations
- Tagging & Filtering: https://playwright.dev/docs/test-annotations#tag-tests
- CLI Options: https://playwright.dev/docs/test-cli

---

## 🗒️ Full Transcript
```00:00-08:21:lesson12/lesson-12-transcript.md
hello and welcome I am raghav and today
we are going to learn annotations and
tags in playwright this is going to be
very easy and very interesting and I
will go very basic step by step so we
are going to see what are tags and
annotations in playwright how do we use
the annotations and tags and we will see
a step-by-step Hands-On demo now in the
last session we have already seen the
hooks and groups how do we use different
hooks in playwright in the tests and how
can we group our test cases and today we
will see annotations we have different
annotations like only skip fix me slow
Etc and then we can also tag our test
cases with tags like at regression at
smoke at sanity at fast etc etc and then
we can run the tests with specific tags
or we can also have an option where we
can skip the tests having a certain tag
we will see this in a moment so let's
get started and see some annotations and
before that I will will go to my project
```

```08:21-13:54:lesson12/lesson-12-transcript.md
// Run only this test during the session
test.only('focused test', async ({ page }) => {
  // ...
});
```

```10:28-13:54:lesson12/lesson-12-transcript.md
// Run only @smoke tests
npx playwright test --grep "@smoke"

// Skip @smoke tests
npx playwright test --grep-invert "@smoke"
```
```

---

*Transcript generated via YouTube MCP on November 7, 2025.*



