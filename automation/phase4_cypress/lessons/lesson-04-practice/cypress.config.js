const { defineConfig } = require('cypress')

module.exports = defineConfig({
  e2e: {
    // Base URL for Odoo instance
    baseUrl: 'http://localhost:8069',
    
    // Viewport settings
    viewportWidth: 1920,
    viewportHeight: 1080,
    
    // Timeouts (Odoo can be slow)
    defaultCommandTimeout: 15000,
    pageLoadTimeout: 45000,
    requestTimeout: 15000,
    responseTimeout: 15000,
    
    // Test settings
    video: false,
    screenshotOnRunFailure: true,
    
    // Retry settings
    retries: {
      runMode: 2,
      openMode: 0
    },
    
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
})

