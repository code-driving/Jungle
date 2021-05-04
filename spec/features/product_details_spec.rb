require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
      10.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      end
    end

    scenario "TVisit all products, then visit a specific product" do
      visit root_path
  
      # commented out b/c it's for debugging only
  
      page.find('.product', match: :first).find('header').click_link
      sleep 1
      save_and_open_screenshot
      
      expect(page).to have_css '.products-show'
    end

end