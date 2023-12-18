require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    # validates :name, presence: true
    it "should create a database entry" do
      @category = Category.new(name: 'tree')
      @product = Product.new(name: "test", price: 1234, quantity: 1, category: @category)
      expect(@product).to be_valid
    end
    it "should not create a database entry with just the name" do
      @category = Category.new(name: 'tree1')
      @product = Product.new(name: "test", price: nil, quantity: nil, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
    it "should not create a database entry with just the price" do
      @category = Category.new(name: 'tree2')
      @product = Product.new(name: nil, price: 1234, quantity: nil, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
    it "should not create a database entry with just the quantity" do
      @category = Category.new(name: 'tree3')
      @product = Product.new(name: nil, price: nil, quantity: 1, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
    it "should not create a database entry with just the category" do
      @category = Category.new(name: 'tree4')
      @product = Product.new(name: nil, price: nil, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
  end
end