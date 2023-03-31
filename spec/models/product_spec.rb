require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "gives an error with no name" do
      @category = Category.new(id: 1, name: "Test")
      @product = Product.new(id: 1, price_cents: 50000, quantity: 100, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to_not be_empty
    end

    it "gives an error with an invalid price" do
      @category = Category.new(id: 1, name: "Test")
      @product = Product.new(id: 1, name: "Gorilla Cage", quantity: 100, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to_not be_empty
    end

    it "gives an error with an invalid quantity" do
      @category = Category.new(id: 1, name: "Test")
      @product = Product.new(id: 1, name: "Gorilla Cage", price_cents: 50000, category: @category)
      @product.valid?
      expect(@product.errors.full_messages).to_not be_empty
    end

    it "gives an error with an invalid category" do
      @category = Category.new(id: 1, name: "Test")
      @product = Product.new(id: 1, name: "Gorilla Cage", price_cents: 50000, quantity: 100)
      @product.valid?
      expect(@product.errors.full_messages).to_not be_empty
    end

    it "is a valid product with valid data" do
      @category = Category.new(id: 1, name: "Test")
      @product = Product.new(id: 1, name: "Gorilla Cage", price_cents: 50000, quantity: 100, category: @category)
      expect(@product).to be_valid
    end
  end
end
