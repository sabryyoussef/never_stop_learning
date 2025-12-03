# 🎯 Playwright Test Commands - Quick Reference

## Basic Commands
```bash
# Run all tests
npx playwright test

# Run all tests with specific number of workers
npx playwright test --workers 3

# View HTML test report
npx playwright show-report
```

## Specific Test Execution
```bash
# Run specific test file
npx playwright test tests/example.spec.js

# Run tests matching file pattern
npx playwright test example

# Run specific test by title
npx playwright test -g "Home page has Playwright in title"
```

## Browser-Specific Commands
```bash
# Run on specific browser only
npx playwright test --project=chromium
npx playwright test --project=firefox
npx playwright test --project=webkit

# Run in headed mode (visible browser)
npx playwright test --project=chromium --headed

# Combine options
npx playwright test --project=chromium --headed tests/forms.spec.js
```

## Debug Commands
```bash
# Debug mode with Playwright Inspector
npx playwright test --project=chromium --debug

# Debug specific test
npx playwright test --project=chromium --debug -g "Form submission"

# Debug from specific line (if you know the line number)
npx playwright test tests/example.spec.js:23 --debug
```

## Useful Combinations
```bash
# Run specific test in headed mode for visual debugging
npx playwright test --project=chromium --headed -g "Todo creation"

# Run single file with multiple workers
npx playwright test tests/forms.spec.js --workers 2

# Run all tests except WebKit (if having issues)
npx playwright test --project=chromium --project=firefox
```

## Practice Summary ✅

Today we practiced:
- ✅ **Project setup** with npm and Playwright configuration
- ✅ **Basic test execution** with all tests and workers
- ✅ **Specific test targeting** by file, pattern, and title
- ✅ **Browser-specific execution** on Chromium only
- ✅ **Headed mode** for visual test observation
- ✅ **Debug mode** with Playwright Inspector
- ✅ **HTML report viewing** for detailed results

## Key Takeaways
1. **Default behavior**: Runs on all browsers (Chromium, Firefox, WebKit)
2. **Parallel execution**: Multiple workers speed up test runs
3. **Flexible targeting**: Can run specific files, patterns, or test titles
4. **Visual debugging**: Headed mode and debug mode are invaluable for development
5. **Rich reporting**: HTML reports provide detailed test analysis

Remember: **Never stop learning!** 🚀