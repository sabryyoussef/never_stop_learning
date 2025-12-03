import { test, expect } from '@playwright/test';

test('Form submission test', async ({ page }) => {
  await page.goto('https://demo.playwright.dev/todomvc/');
  
  // Test form interaction
  await page.fill('.new-todo', 'Test form submission');
  await page.press('.new-todo', 'Enter');
  
  // Verify form was submitted
  await expect(page.locator('.todo-count')).toContainText('1 item left');
});

test('Form validation test', async ({ page }) => {
  await page.goto('https://demo.playwright.dev/todomvc/');
  
  // Try to submit empty form
  await page.press('.new-todo', 'Enter');
  
  // Check that no todo was added
  await expect(page.locator('.todo-list li')).toHaveCount(0);
});

test('Multiple form submissions', async ({ page }) => {
  await page.goto('https://demo.playwright.dev/todomvc/');
  
  // Add multiple todos
  const todos = ['First task', 'Second task', 'Third task'];
  
  for (const todo of todos) {
    await page.fill('.new-todo', todo);
    await page.press('.new-todo', 'Enter');
  }
  
  // Verify all todos were added
  await expect(page.locator('.todo-list li')).toHaveCount(3);
});