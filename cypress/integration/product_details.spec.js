describe("product details", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000/");
    cy.contains("Swamp Root").click();
  });

  it("should show product details", () => {
    cy.get(".product-detail h1").should("have.text", "Swamp Root");
  });
});
