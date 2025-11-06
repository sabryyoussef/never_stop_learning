/**
 * Playwright Configuration for Odoo Testing
 * 
 * This configuration file sets up Playwright for testing Odoo applications.
 * Adjust the settings based on your Odoo instance and testing requirements.
 */

const { defineConfig, devices } = require('@playwright/test');

module.exports = defineConfig({
  // Test directory
  testDir: './tests',
  
  // Maximum time one test can run
  timeout: 60 * 1000,
  
  // Test execution settings
  fullyParallel: false, // Set to false for Odoo to avoid conflicts
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : 1, // Single worker for Odoo testing
  
  // Reporter configuration
  reporter: [
    ['html', { outputFolder: 'test-results/html' }],
    ['json', { outputFile: 'test-results/results.json' }],
    ['junit', { outputFile: 'test-results/junit.xml' }],
    ['list']
  ],
  
  // Shared settings for all projects
  use: {
    // Base URL for Odoo instance
    baseURL: 'http://localhost:8069',
    
    // Browser settings
    headless: true,
    viewport: { width: 1920, height: 1080 },
    
    // Collect trace when retrying the failed test
    trace: 'on-first-retry',
    
    // Screenshot on failure
    screenshot: 'only-on-failure',
    
    // Video on failure
    video: 'retain-on-failure',
    
    // Ignore HTTPS errors (useful for local development)
    ignoreHTTPSErrors: true,
    
    // Timeout for actions
    actionTimeout: 10000,
    
    // Timeout for navigation
    navigationTimeout: 30000,
  },
  
  // Configure projects for major browsers
  projects: [
    {
      name: 'chromium',
      use: { 
        ...devices['Desktop Chrome'],
        // Odoo-specific settings
        locale: 'en-US',
        timezoneId: 'America/New_York',
      },
    },
    
    {
      name: 'firefox',
      use: { 
        ...devices['Desktop Firefox'],
        locale: 'en-US',
        timezoneId: 'America/New_York',
      },
    },
    
    {
      name: 'webkit',
      use: { 
        ...devices['Desktop Safari'],
        locale: 'en-US',
        timezoneId: 'America/New_York',
      },
    },
    
    // Mobile testing (optional)
    // {
    //   name: 'Mobile Chrome',
    //   use: { ...devices['Pixel 5'] },
    // },
    // {
    //   name: 'Mobile Safari',
    //   use: { ...devices['iPhone 12'] },
    // },
  ],
  
  // Run local dev server before starting tests (optional)
  // webServer: {
  //   command: 'npm run start',
  //   port: 8069,
  //   timeout: 120 * 1000,
  //   reuseExistingServer: !process.env.CI,
  // },
});

