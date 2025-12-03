# Playwright Beginner Tutorial 10 | Slow Motion & Video Recording

## 📹 Video Information
- **Title:** Playwright Beginner Tutorial 10 | Slow Motion and Video Recording
- **Video ID:** ETFS_RMt4go
- **URL:** https://www.youtube.com/watch?v=ETFS_RMt4go
- **Series:** Playwright Tutorial for Beginners
- **Instructor:** Raghav Pal

---

## 📝 Video Description
Playwright Beginner Tutorial 10 | Slow Motion and Video Recording  
▬ ASK RAGHAV ► https://bit.ly/2CoJGWf  
▬ QUIZ ► https://forms.gle/V1gNBxZbWnoZozBdA

---

## ⏰ Timestamps
- **00:00** – Introduction to slow-mo and video capture
- **00:52** – Configuring slow motion & video in `playwright.config.ts`
- **08:23** – Review: test-results folder & generated videos
- **09:39** – Browser context basics (incognito sessions)
- **10:34** – Creating browser/context/page programmatically
- **13:49** – Per-test slow-mo and video settings
- **16:42** – Saving videos to custom directories
- **19:09** – Wrap-up

---

## 🎯 Key Topics Covered
1. Global slow motion and video recording via configuration
2. Video recording modes: `on`, `off`, `retain-on-failure`, `on-first-retry`
3. Launch options (`headless`, `slowMo`) and context options (`recordVideo`)
4. Managing videos in `test-results/` and custom directories
5. Programmatically launching browsers and contexts with custom settings
6. Practical login demo to verify outputs

---

## 💻 Code Samples
### Global Configuration (`playwright.config.ts`)
```ts
const config = {
  use: {
    video: 'on',
    launchOptions: {
      slowMo: 1000,
    },
  },
};
export default config;
```

### Video Modes
- `'on'`: record every test
- `'off'`: disable video capture
- `'retain-on-failure'`: keep only failed test videos
- `'on-first-retry'`: record only during first retry

### Per-Test Setup Using Browser Context
```ts
import { test, chromium } from '@playwright/test';

test('slow-mo video login', async () => {
  const browser = await chromium.launch({
    headless: false,
    slowMo: 500,
  });

  const context = await browser.newContext({
    recordVideo: {
      dir: 'videos/',
      size: { width: 800, height: 600 },
    },
  });

  const page = await context.newPage();
  await page.goto('https://opensource-demo.orangehrmlive.com/web/index.php/auth/login');
  await page.locator('[placeholder="Username"]').fill('Admin');
  await page.locator('[placeholder="Password"]').fill('admin123');
  await page.locator('button:has-text("Login")').click();

  await context.close();
  await browser.close();
});
```

---

## 🔑 Key Takeaways
- Use `slowMo` for debugging fast tests; choose millisecond values appropriate for your workflow.
- `recordVideo.dir` lets you persist recordings under a project-specific folder (e.g., `videos/`).
- Prefer `retain-on-failure` or `on-first-retry` in CI to reduce storage usage.
- Per-test browser/context setup offers granular control without affecting global config.
- Recorded videos appear under `test-results/<browser>/` unless overridden.

---

## 🛠️ Commands Used
```bash
npx playwright test tests/login_demo.spec.ts --project=chromium --headed
npx playwright show-report
```

---

## 🎓 Odoo-Specific Applications
- Slow down onboarding walkthroughs to capture UI transitions in Odoo modules.
- Record videos for flaky flows (e.g., POS, inventory) to share with developers.
- Store recordings for CI failures to accelerate debugging.
- Use per-test video configuration for high-value regression suites only.

---

## ✅ Practice Checklist
- [ ] Enable `slowMo` globally and observe Odoo login playback.
- [ ] Switch to `retain-on-failure` before running CI smoke suites.
- [ ] Configure per-test recording to save videos in `automation/videos/`.
- [ ] Review `test-results/` to ensure old videos are cleaned between runs.
- [ ] Update `phase3_playwright/notes.md` with chosen video strategy.

---

## 📚 Additional Resources
- Launch Options Reference: https://playwright.dev/docs/api/class-browsertype#browser-type-launch
- Video Recording Docs: https://playwright.dev/docs/videos
- Browser Context Guide: https://playwright.dev/docs/api/class-browsercontext

---

## 🗒️ Full Transcript
```00:00-10:34:lesson10/lesson-10-transcript.md
hello and welcome i'm raghav and today
we are going to learn something very
interesting in playwright we are going
to see how we can slow down the speed of
execution of our test so generally
playwright is very fast and sometimes
you may want to see what is happening on
the screen on the browser and in that
case you may want to slow down the speed
of execution so we will see how we can
run our tests in slow motion and then we
will also see how we can record video of
our test execution and both of these
features are inbuilt in playwright so we
do not have to use any third-party tools
or any third-party libraries all these
features are built in within playwright
and we will see these options from the
config file how to set these
configurations from the config file at a
global level and we will also see how we
can do this at a test level so let's get
started and let us see the first step is
we will go to our config file and we
will add the configuration for slow
motion and video recording so i will go
to my project
```

```10:34-19:09:lesson10/lesson-10-transcript.md
so let me show you this is my test now
i have created all these browser context
and then this is my test which is going
to this link and sending setting email
and password so it first
selects all that is written and then
adds the username in the username field
then goes to the password selects
everything by pressing ctrl a and then
as the new password and then clicks on
login button and then we are closing our
context so let us now
save this
and i will run
npx playwright
```

---

*Transcript generated via YouTube MCP on November 7, 2025.*


