describe("home page", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000/");
  });

  it("displays the home page", () => {
    cy.get(".intro").should("be.visible");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
});
