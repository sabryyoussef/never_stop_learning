Here’s your transcript arranged into a **structured Markdown lesson** — grouped by topic without any summarization, just clean formatting for readability.

---

# 🎓 Lesson: Playwright Test Run Commands

---

## Introduction

Hello and welcome, I'm Makhav.
Today we are going to see the different commands that we can use to run our tests and the different options we have — such as how to run all the tests, specific tests, headless or headed mode, parallel runs, debugging, and more.

We’ll cover:

* Running all or specific tests
* Running with or without browser UI
* Using multiple workers and running in parallel
* Debugging tests
* Viewing reports
* Running on specific browsers
* Other useful options

At the end, there’s a quiz (link in the video description).

---

## Project Setup

We’re using **VS Code** and the **Playwright project** created in the last session using npm commands.

* The project structure includes a `/tests` folder.
* Sample test files are already added.
* You can open a terminal using `Ctrl + J`.

---

## Command: Run All Tests

```bash
npx playwright test
```

* Runs all tests inside the `tests` folder.
* Example output:

  * Runs 3 tests using 1 worker → sequential execution.
  * Browsers: Chromium, WebKit, Firefox.
  * Report generated automatically (HTML).

---

## Viewing Reports

* Reports are saved in the `playwright-report` folder.
* You can view it directly via:

  ```bash
  npx playwright show-report
  ```
* Shows all test results with filters (Passed/Failed, etc.).
* Displays details like execution time, browser type, and step breakdown.

---

## Command: Run in Parallel with Multiple Workers

```bash
npx playwright test --workers 3
```

* Executes tests in parallel using 3 workers.
* Saves time especially with multiple test files.

---

## Command: Run Specific Test File

```bash
npx playwright test tests/example.spec.js
```

* Runs only the specified test file.

---

## Command: Run Tests by File Name Pattern

```bash
npx playwright test example
```

* Runs files whose names include “example”.

---

## Command: Run Specific Test by Title

```bash
npx playwright test -g "Home page has Playwright in title"
```

* Runs only the test matching the given title from any file.

---

## Command: Run on Specific Browser

```bash
npx playwright test --project=chromium
```

* Executes tests only on the specified browser (Chromium, Firefox, WebKit).

---

## Command: Run in Headed Mode

```bash
npx playwright test --project=chromium --headed
```

* Opens a visible browser window during test execution.
* Useful for observing test behavior manually.
* Default mode (headless) runs faster and saves memory.

---

## Command: Debug Mode

```bash
npx playwright test --project=chromium --debug
```

* Launches Playwright Inspector for step-by-step debugging.
* Automatically runs in headed mode.
* Allows:

  * Pausing/resuming execution
  * Step over
  * Inspecting each test step in detail

---

## Debugging Specific Test or Line

You can specify a test starting line number:

```bash
npx playwright test tests/example.spec.js:23 --debug
```

* Starts debugging from the test defined at line 23.
* Useful for skipping other tests in the same file.

---

## Playwright Inspector

When debugging:

* The **Playwright Inspector** window appears.
* You can:

  * Resume or pause execution.
  * Step over each test command.
  * Create breakpoints.
  * Inspect elements and test actions interactively.

---

## Recording Tests (Preview)

Commands to record tests will be covered in upcoming sessions.

---

## Final Notes

* Take a screenshot of all these commands for quick reference.
* Practice running different commands to get familiar.
* The quiz link is in the description.
* Share your score and questions in the comments.

> Thank you for watching, and remember — **never stop learning!**

---

Would you like me to add a **command reference table** at the end (for quick scanning during practice)?
