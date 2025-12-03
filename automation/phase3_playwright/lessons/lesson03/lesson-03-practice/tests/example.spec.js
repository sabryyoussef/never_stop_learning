import { test, expect } from '@playwright/test';

test('Home page has Playwright in title', async ({ page }) => {
  await page.goto('https://playwright.dev/');
  
  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/Playwright/);
});

test('Get started link navigation', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Click the get started link.
  await page.getByRole('link', { name: 'Get started' }).click();

  // Expects page to have a heading with the name of Installation.
  await expect(page.getByRole('heading', { name: 'Installation' })).toBeVisible();
});

test('Search functionality test', async ({ page }) => {
  await page.goto('https://playwright.dev/');
  
  // Find search button and click it
  const searchButton = page.getByRole('button', { name: 'Search' });
  await searchButton.click();
  
  // Type in search box
  await page.keyboard.type('API');
  
  // Wait for search results
  await page.waitForTimeout(1000);
});