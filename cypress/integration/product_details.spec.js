
it("It should open a product", () => {
  cy.visit('/')
  cy.get(".products article").first().click()
  cy.url().should("include", '/products/2')
});