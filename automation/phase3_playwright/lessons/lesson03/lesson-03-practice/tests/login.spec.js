import { test, expect } from '@playwright/test';

test('Login page title test', async ({ page }) => {
  await page.goto('https://demo.playwright.dev/todomvc/');
  
  // Check the page title
  await expect(page).toHaveTitle(/TodoMVC/);
});

test('Todo creation test', async ({ page }) => {
  await page.goto('https://demo.playwright.dev/todomvc/');
  
  // Add a new todo
  await page.fill('.new-todo', 'Learn Playwright commands');
  await page.press('.new-todo', 'Enter');
  
  // Verify todo was added
  await expect(page.locator('.todo-list li')).toHaveText('Learn Playwright commands');
});

test('Todo completion test', async ({ page }) => {
  await page.goto('https://demo.playwright.dev/todomvc/');
  
  // Add a todo
  await page.fill('.new-todo', 'Complete this task');
  await page.press('.new-todo', 'Enter');
  
  // Mark as completed
  await page.click('.todo-list li .toggle');
  
  // Verify it's marked as completed
  await expect(page.locator('.todo-list li')).toHaveClass(/completed/);
});