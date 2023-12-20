it('can visit the homepage', () => {
  cy.visit('/')
})

it('It should add to cart', () => {
  cy.get('nav').contains('My Cart (0)')

  cy.contains('Add').first().click({force: true})

  cy.get('nav').contains('My Cart (1)')

  cy.contains('My Cart (1)').first().click({force: true})

})
