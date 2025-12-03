# Playwright Tutorial | API Testing Demo

## 📹 Video Information
- **Title:** Playwright API Testing Demo for Beginners
- **Video ID:** EEjyLfp6DoQ
- **URL:** https://www.youtube.com/watch?v=EEjyLfp6DoQ
- **Instructor:** Raghav Pal

---

## 📝 Video Description
End-to-end walkthrough on building Playwright API tests (GET, POST, PUT, DELETE) using reqres.in. Covers project setup, request context usage, assertions, UI Mode, and HTML reports.

---

## ⏰ Timestamps
- **00:00** – API testing overview & goals
- **00:40** – Project setup (folder, VS Code)
- **02:41** – Install Playwright via `npm init playwright@latest`
- **08:04** – Running sample tests (`npx playwright test`, `--ui`, `show-report`)
- **11:05** – Create `api-tests.spec.js`
- **16:55** – GET request demo (`request.get`, status checks, response text)
- **19:31** – Inspecting responses, logs, errors
- **24:36** – Switching to POST request with payload
- **27:07** – PUT request example
- **32:19** – DELETE request example
- **34:00** – References and wrap-up

---

## 🎯 Key Topics Covered
1. Playwright project initialization for API testing
2. Using `APIRequestContext` (`{ request }` fixture) inside tests
3. GET, POST, PUT, DELETE request workflows
4. Validating response status, text, JSON bodies
5. Leveraging Playwright UI Mode to inspect logs and network traces
6. Generating HTML reports for API suites

---

## 💻 Code Samples
### Test Skeleton
```ts
import { test, expect } from '@playwright/test';

test('GET user', async ({ request }) => {
  const response = await request.get('https://reqres.in/api/users/2');
  expect(response.status()).toBe(200);
  const text = await response.text();
  expect(text).toContain('Janet');
  console.log(await response.json());
});
```

### POST Request
```ts
test('Create user', async ({ request }) => {
  const response = await request.post('https://reqres.in/api/users', {
    data: {
      name: 'Raghav',
      job: 'teacher',
    },
  });
  expect(response.status()).toBe(201);
  const body = await response.json();
  expect(body.name).toBe('Raghav');
  console.log(body);
});
```

### PUT Request
```ts
test('Update user', async ({ request }) => {
  const response = await request.put('https://reqres.in/api/users/2', {
    data: {
      name: 'Raghav',
      job: 'teacher',
    },
  });
  expect(response.status()).toBe(200);
  const body = await response.json();
  expect(body.name).toBe('Raghav');
  console.log(body);
});
```

### DELETE Request
```ts
test('Delete user', async ({ request }) => {
  const response = await request.delete('https://reqres.in/api/users/2');
  expect(response.status()).toBe(204);
});
```

### Commands
```bash
npm init playwright@latest
npx playwright test
npx playwright test --ui
npx playwright show-report
```

---

## 🔑 Key Takeaways
- Playwright’s built-in `request` fixture simplifies API calls without spinning up a browser.
- Assertions can target status codes, response text, and parsed JSON payloads.
- UI Mode (`--ui`) provides rich diagnostics (logs, console, network).
- Reqres.in offers reliable sample endpoints for experimentation.
- Structure API tests similarly to UI tests, enabling shared reporting and fixtures.

---

## ✅ Practice Checklist
- [ ] Scaffold a fresh Playwright project dedicated to API testing.
- [ ] Implement GET/POST/PUT/DELETE tests against reqres.in.
- [ ] Add custom assertions for response payload fields.
- [ ] Run the suite in UI Mode to inspect network logs.
- [ ] Capture HTML report artifacts for documentation.

---

## 📚 References
- Playwright API Testing: https://playwright.dev/docs/api-testing
- `APIRequestContext`: https://playwright.dev/docs/api/class-apirequestcontext
- API Response Assertions: https://playwright.dev/docs/api/class-apiresponseassertions
- Sample APIs: https://reqres.in/

---

## 🗒️ Full Transcript
```00:00-34:00:lesson14/lesson-14-transcript.md
hello and welcome I am raghav and today
we are going to learn step by step from
scratch how to do API testing with
playwright ...
```

*Transcript generated via YouTube MCP on November 7, 2025.*


