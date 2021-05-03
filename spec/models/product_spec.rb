require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "ensures the presence of all four fields: name, price, quantity, category" do
      @category = Category.new
      @category.id = 20
      @category.name = "products"
      
      @product = Product.new
      @product.name = "sofa"
      @product.price = 2000
      @product.quantity = 50
      @product.category_id = @category
      
      @category.products = [@product]
      @product.save
      
      expect(@product).to be_valid
    end
  
    it 'ensures the presence of name' do
      @category = Category.new
      @category.id = 20
      @category.name = "products"

      @product = Product.new
      @product.name = nil
      @product.price = 2000
      @product.quantity = 50
      @product.category_id = @category

      @category.products = [@product]
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.length).to eql(1)
      expect(@product.errors.full_messages[0]).to eql("Name can't be blank")
    end 

    it 'ensures the presence of price' do
      @category = Category.new
      @category.id = 20
      @category.name = "products"

      @product = Product.new
      @product.name = "sofa"
      @product.price = nil
      @product.quantity = 50
      @product.category_id = @category

      @category.products = [@product]
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to eql("Price cents is not a number")
      expect(@product.errors.full_messages.length).to eql(3)
    end 

    it 'ensures the presence of quantity' do
      @category = Category.new
      @category.id = 20
      @category.name = "products"

      @product = Product.new
      @product.name = "sofa"
      @product.price = 2000
      @product.quantity = nil
      @product.category_id = @category

      @category.products = [@product]
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to eql("Quantity can't be blank")
      expect(@product.errors.full_messages.length).to eql(1)
    end 

    it 'should have a category' do
      @category = nil     
      @product = Product.new
      @product.name = "sofa"
      @product.price = 2000
      @product.quantity = 50
      @product.category_id = nil  
      @product.save
      expect(@product.category).to be_nil
      expect(@product.errors.full_messages[0]).to eql("Category can't be blank")
      expect(@product.errors.full_messages.length).to eql(1)
    end 
  end
end
