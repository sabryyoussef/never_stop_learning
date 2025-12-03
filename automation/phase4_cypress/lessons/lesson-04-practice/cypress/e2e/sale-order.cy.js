describe('Odoo Sale Order Tests', () => {
  beforeEach(() => {
    // Login before each test
    cy.odooLogin('admin', 'admin')
  })

  it('should navigate to Sales module', () => {
    cy.odooNavigateToApp('Sales')
    cy.url().should('include', '/web')
    cy.get('.o_control_panel').should('contain', 'Quotations')
  })

  it('should create a new quotation', () => {
    cy.odooNavigateToApp('Sales')
    cy.odooCreateRecord()
    
    // Fill customer field
    cy.odooFillMany2one('partner_id', 'Azure Interior')
    
    // Add product line
    cy.get('a.o_field_x2many_list_row_add').click()
    cy.odooFillMany2one('product_id', 'Desk Combination')
    
    // Set quantity
    cy.get('input[name="product_uom_qty"]').first().clear().type('5')
    
    // Save the quotation
    cy.odooSaveForm()
    
    // Verify quotation is created
    cy.get('span[name="name"]').should('exist')
    cy.get('span[name="state"]').should('contain', 'Quotation')
  })

  it('should confirm a quotation', () => {
    cy.odooNavigateToApp('Sales')
    cy.odooCreateRecord()
    
    // Quick create minimal quotation
    cy.odooFillMany2one('partner_id', 'Azure Interior')
    cy.odooSaveForm()
    
    // Confirm the order
    cy.get('button[name="action_confirm"]').click()
    cy.odooWaitLoading()
    
    // Verify state changed to Sale Order
    cy.get('span[name="state"]').should('contain', 'Sale Order')
  })

  it('should display sale order smart buttons', () => {
    cy.odooNavigateToApp('Sales')
    
    // Open first sale order
    cy.get('.o_data_row').first().click()
    
    // Verify smart buttons exist
    cy.get('.o_stat_info').should('exist')
  })
})

