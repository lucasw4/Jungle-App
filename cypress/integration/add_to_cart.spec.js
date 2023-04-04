describe("add to cart", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000/");
  });

  it("should add to cart and increment cart by one", () => {
    cy.get(".btn").first().click({ force: true });
    cy.contains("My Cart (1)");
  });
});
