
it("There is 2 products on the page", () => {
  cy.visit('/')
  cy.get(".products article").first().click()
  cy.url().should("include", '/products/2')
});