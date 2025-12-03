describe('Odoo Login Tests', () => {
  beforeEach(() => {
    cy.visit('/web/login')
  })

  it('should display login form', () => {
    cy.get('input[name="login"]').should('be.visible')
    cy.get('input[name="password"]').should('be.visible')
    cy.get('button[type="submit"]').should('contain', 'Log in')
  })

  it('should login successfully with valid credentials', () => {
    // Update with your Odoo credentials
    cy.get('input[name="login"]').type('admin')
    cy.get('input[name="password"]').type('admin')
    cy.get('button[type="submit"]').click()
    
    // Verify successful login
    cy.get('.o_main_navbar', { timeout: 15000 }).should('be.visible')
    cy.url().should('include', '/web')
  })

  it('should show error with invalid credentials', () => {
    cy.get('input[name="login"]').type('invalid_user')
    cy.get('input[name="password"]').type('wrong_password')
    cy.get('button[type="submit"]').click()
    
    // Verify error message
    cy.get('.alert-danger').should('be.visible')
    cy.get('.alert-danger').should('contain', 'Wrong login/password')
  })

  it('should use custom login command', () => {
    // Using the custom command from commands.js
    cy.odooLogin('admin', 'admin')
    cy.get('.o_main_navbar').should('be.visible')
  })
})

