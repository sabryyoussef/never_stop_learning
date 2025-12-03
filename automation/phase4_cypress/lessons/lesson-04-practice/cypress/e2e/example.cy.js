describe('Cypress Example Test', () => {
  it('should visit Odoo login page', () => {
    cy.visit('/')
    cy.get('input[name="login"]').should('be.visible')
    cy.get('input[name="password"]').should('be.visible')
    cy.get('button[type="submit"]').should('be.visible')
  })

  it('should have correct page title', () => {
    cy.visit('/')
    cy.title().should('include', 'Odoo')
  })
})

