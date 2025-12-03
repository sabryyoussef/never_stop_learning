// ***********************************************
// Custom commands for Odoo testing
// ***********************************************

/**
 * Login to Odoo
 * @example cy.odooLogin('admin', 'admin', 'your_database')
 */
Cypress.Commands.add('odooLogin', (username, password, database = 'odoo') => {
  cy.visit('/web/login')
  cy.get('input[name="login"]').type(username)
  cy.get('input[name="password"]').type(password)
  if (cy.get('input[name="db"]').should('exist')) {
    cy.get('input[name="db"]').type(database)
  }
  cy.get('button[type="submit"]').click()
  cy.get('.o_main_navbar', { timeout: 15000 }).should('be.visible')
})

/**
 * Navigate to Odoo app
 * @example cy.odooNavigateToApp('Sales')
 */
Cypress.Commands.add('odooNavigateToApp', (appName) => {
  cy.get('.o_app').contains(appName).click()
  cy.wait(1000)
})

/**
 * Create new record in list view
 * @example cy.odooCreateRecord()
 */
Cypress.Commands.add('odooCreateRecord', () => {
  cy.get('button.o_list_button_add').click()
  cy.get('.o_form_view').should('be.visible')
})

/**
 * Save Odoo form
 * @example cy.odooSaveForm()
 */
Cypress.Commands.add('odooSaveForm', () => {
  cy.get('button.o_form_button_save').click()
  cy.get('.o_form_readonly', { timeout: 10000 }).should('exist')
})

/**
 * Fill Many2one field
 * @example cy.odooFillMany2one('partner_id', 'Azure Interior')
 */
Cypress.Commands.add('odooFillMany2one', (fieldName, value) => {
  cy.get(`div[name="${fieldName}"] input`).click()
  cy.get(`div[name="${fieldName}"] input`).type(value)
  cy.get('.ui-autocomplete').should('be.visible')
  cy.get('.ui-autocomplete li').contains(value).click()
})

/**
 * Wait for Odoo loading to complete
 * @example cy.odooWaitLoading()
 */
Cypress.Commands.add('odooWaitLoading', () => {
  cy.get('.o_loading', { timeout: 1000 }).should('not.exist')
})

/**
 * Check for success notification
 * @example cy.odooCheckNotification('success', 'Record saved')
 */
Cypress.Commands.add('odooCheckNotification', (type, message) => {
  cy.get(`.o_notification.o_notification_${type}`, { timeout: 5000 })
    .should('be.visible')
    .and('contain', message)
})

