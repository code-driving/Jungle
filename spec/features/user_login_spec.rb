require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create!(name: 'ben', email: 'b@gmail.com', password: '12345', password_confirmation: '12345')
    end

  scenario "Visit landing page, then click login and successfully log in" do
    visit root_path
    page.find('.nav-login').click_on('Login')
    
    expect(page).to have_css '.form-control'
    
    fill_in 'sessions_email', with: 'b@gmail.com'
    fill_in 'sessions_password', with: '12345'
    
    page.click_on('Submit')
    
    expect(page).to have_text('ben')
    expect(page).to have_text('Logout')
  end
end
