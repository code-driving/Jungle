require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "ensures the name is not an empty field" do
      @user = User.create(name: nil, email: "mark@gmail.com", password: "test", password_confirmation: "test")

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eql("Name can't be blank")
      expect(@user.errors.full_messages.length).to eql(1)
    end

    it "ensures email is not an empty field" do
      @user = User.create(name: "John", email: nil, password: "test", password_confirmation: "test")

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eql("Email can't be blank")
      expect(@user.errors.full_messages.length).to eql(1)
    end
    

    it "ensures password is not an empty field" do
      @user = User.create(name: "John", email: "mark@gmail.com", password: nil, password_confirmation: "test")

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eql("Password can't be blank")
      expect(@user.errors.full_messages[1]).to eql("Password can't be blank")
      expect(@user.errors.full_messages[2]).to eql("Password is too short (minimum is 4 characters)")
      expect(@user.errors.full_messages.length).to eql(3)
    end

    # it "ensures password_confirmatioon is not an empty field" do
    #   @user = User.create(name: "John", email: "mark@gmail.com", password: nil, password_confirmation: nil)

    #   expect(@user).to_not be_valid
    #   expect(@user.errors.full_messages[0]).to eql("Password can't be blank")
    #   expect(@user.errors.full_messages.length).to eql(1)
    # end
    
    it "ensures the password and password_confirmation match" do
      @user = User.create(name: "John", email: "mark@gmail.com", password: "test", password_confirmation: "test1")

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eql("Password confirmation doesn't match Password")
      expect(@user.errors.full_messages.length).to eql(1)
    end

    it "should have a unique email that is not case sensitive" do
      @user1 = User.create(name: "John", email: "mark@gmail.com", password: "test",  password_confirmation: "test")
      @user2 = User.create(name: "John", email: "MARK@gmail.com", password: "test",  password_confirmation: "test")
      
      expect(@user2.errors.full_messages.length).to eql(1)
      expect(@user2.errors.full_messages[0]).to eql("Email has already been taken")
      expect(@user2).to_not be_valid
      
      expect(@user1.errors.full_messages.length).to eql(0)
      expect(@user1).to be_valid
    end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "is valid if email and password the user types in correct" do
      @user = User.create(name: "John", email: "mark@gmail.com", password: "test",  password_confirmation: "test")
      @authenticated = User.authenticate_with_credentials("mark@gmail.com ", "test")
      
      expect(@authenticated).to eql(@user)
    end
    
    it "is valid if email is correct in different cases, with whitespaces" do
      @user = User.create(name: "John", email: "mark@gmail.com", password: "test",  password_confirmation: "test")
      @authenticated = User.authenticate_with_credentials(" mArK@gmail.com ", "test")
      
      expect(@authenticated).to eql(@user)
    end
    
    it "is invalid if user does not input an email" do
      @user = User.create(name: "John", email: "mark@gmail.com", password: "test", password_confirmation: "test")
      @authenticated = User.authenticate_with_credentials(nil, "test")
      expect(@authenticated).to eql(nil)
    end
    
    it "is invalid if user does not input password" do
      @user = User.create(name: "John", email: "mark@gmail.com", password: "test", password_confirmation: "test")
      @authenticated = User.authenticate_with_credentials("mark@gmail.com", nil)
      expect(@authenticated).to eql(nil)
    end
  end
end

