# Playwright Beginner Tutorial 3 | How to Run Tests

## 📹 Video Information

- **Title:** Playwright Beginner Tutorial 3 | How to run tests
- **Video ID:** LTwg0kqdK4I
- **URL:** https://www.youtube.com/watch?v=LTwg0kqdK4I
- **Series:** Playwright Tutorial for Beginners
- **Instructor:** Raghav Pal

---

## 📝 Video Description

Playwright Beginner Tutorial 3 | How to run tests
▬ ALL FREE COURSES  ► https://automationstepbystep.com/ 
▬ ASK RAGHAV  ► https://bit.ly/2CoJGWf 
QUIZ - https://forms.gle/TXRXbM8URRXppwem6

---

## ⏰ Timestamps

- **00:00** - Introduction
- **01:41** - `npx playwright test` - runs all tests on all browsers in headless mode
- **04:20** - `npx playwright test --workers 3` - runs with 3 workers in parallel
- **05:14** - `npx playwright test one.spec.js` - runs a specific test file
- **05:54** - `npx playwright test one.spec.js two.spec.js` - runs the files specified
- **06:04** - `npx playwright test one two` - runs files that have one or two in the file name
- **06:40** - `npx playwright test -g "check title"` - runs test with the title
- **08:04** - `npx playwright test --project=chromium` - runs on specific browser
- **08:56** - `npx playwright test --headed` - runs tests in headed mode
- **09:51** - `npx playwright test --debug` - debug tests
- **11:40** - `npx playwright test example.spec.js --debug` - debug specific test file
- **12:04** - `npx playwright test example.spec.js:21 --debug` - debug starting from specific line where test(...) starts
- **14:08** - All commands screenshot

---

## 🎯 Key Topics Covered

### 1. Running All Tests
```bash
npx playwright test
```
- Runs all tests in the test folder
- Executes on all configured browsers (Chromium, Firefox, WebKit)
- Runs in headless mode by default
- Uses 1 worker (sequential execution)

### 2. Parallel Execution with Workers
```bash
npx playwright test --workers 3
```
- Runs tests in parallel using multiple workers
- Saves time when running multiple tests
- Example: 3 workers means tests run on 3 browsers simultaneously

### 3. Running Specific Test Files
```bash
# Single file
npx playwright test example.spec.js

# Multiple files
npx playwright test one.spec.js two.spec.js

# Files matching pattern
npx playwright test example
```

### 4. Running Tests by Title
```bash
npx playwright test -g "check title"
```
- Runs specific tests by matching the test title
- Useful when you have multiple tests in a file

### 5. Running on Specific Browser
```bash
npx playwright test --project=chromium
```
- Executes tests on a single browser only
- Options: chromium, firefox, webkit

### 6. Headed Mode
```bash
npx playwright test --headed
```
- Shows physical browser during execution
- By default, tests run in headless mode (no GUI)
- Useful for watching test execution

### 7. Debugging Tests
```bash
# Debug all tests
npx playwright test --debug

# Debug specific file
npx playwright test example.spec.js --debug

# Debug from specific line
npx playwright test example.spec.js:21 --debug
```
- Opens Playwright Inspector
- Allows step-by-step execution
- Can pause, resume, and step over
- Runs in headed mode automatically

### 8. Combining Options
```bash
npx playwright test --project=chromium --headed --debug
```
- You can combine multiple options
- Example: Run on Chrome, in headed mode, with debugging

---

## 📊 Viewing Reports

```bash
# Show HTML report
npx playwright show-report
```
- Opens HTML report in browser
- Shows all test results
- Provides filters (passed, failed, etc.)
- Shows execution time for each test
- Displays detailed steps for each test

---

## 🎓 Learning Takeaways

1. **Default Behavior:**
   - Tests run in headless mode
   - Sequential execution (1 worker)
   - All configured browsers are tested

2. **Performance:**
   - Use `--workers` for parallel execution
   - Saves significant time with multiple tests

3. **Debugging:**
   - Playwright Inspector is powerful
   - Step-by-step debugging available
   - Can start debugging from specific line

4. **Flexibility:**
   - Multiple ways to run tests (all, specific, by name, by title)
   - Can target specific browsers
   - Options can be combined

5. **Reports:**
   - HTML reports generated automatically
   - Detailed information about each test execution
   - Filter and search capabilities

---

## 🔧 Practical Examples from Video

### Example Test Structure
```javascript
test('homepage has playwright in title', async ({ page }) => {
  await page.goto('https://playwright.dev/');
  await expect(page).toHaveTitle(/Playwright/);
});

test('demo test', async ({ page }) => {
  await page.goto('https://playwright.dev/');
  // ... test steps
});
```

### Worker Comparison
- **1 worker (sequential):** ~15 seconds for 3 tests
- **3 workers (parallel):** ~13 seconds for 3 tests
- *Note: Time savings increase significantly with more tests*

---

## 🎯 Quiz

Take the quiz to test your knowledge: https://forms.gle/TXRXbM8URRXppwem6

---

## 📌 Commands Quick Reference

| Command | Description |
|---------|-------------|
| `npx playwright test` | Run all tests (headless, all browsers) |
| `npx playwright test --workers 3` | Run with 3 parallel workers |
| `npx playwright test file.spec.js` | Run specific file |
| `npx playwright test file1 file2` | Run multiple files |
| `npx playwright test -g "title"` | Run by test title |
| `npx playwright test --project=chromium` | Run on specific browser |
| `npx playwright test --headed` | Run in headed mode |
| `npx playwright test --debug` | Debug mode |
| `npx playwright test file.spec.js:21 --debug` | Debug from line 21 |
| `npx playwright show-report` | Open HTML report |

---

## ✅ Action Items

- [ ] Practice all commands shown in the video
- [ ] Take the quiz and share score in comments
- [ ] Experiment with different worker counts
- [ ] Try debugging with Playwright Inspector
- [ ] Review HTML reports after test execution
- [ ] Create breakpoints for debugging (covered in future videos)

---

## 🔗 Related Resources

- Next: Learn how to write Playwright tests
- Previous: Install Playwright
- Playwright Documentation: https://playwright.dev/

---

*Extracted using YouTube MCP on November 6, 2025*

