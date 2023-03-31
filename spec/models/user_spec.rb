require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "is a valid user with valid data" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
    end

    it "gives an error with an invalid first_name" do
      @user = User.create(first_name: nil, last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password")
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it "gives an error with an invalid last_name" do
      @user = User.create(first_name: "John", last_name: nil, email: "john@example.com", password: "password", password_confirmation: "password")
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it "gives an error with an invalid email" do
      @user = User.create(first_name: "John", last_name: "Smith", email: nil, password: "password", password_confirmation: "password")
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it "gives an error with a in use email" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password")
      @user_2 = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password")
      @user_2.valid?
      expect(@user_2.errors.full_messages).to_not be_empty
    end
    
    it "gives an error with an invalid password" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: nil, password_confirmation: "password")
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it "gives an error with a non matching password_confirmation" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password_123123123")
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end

    it "gives an error with a password less than 5 characters" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "1", password_confirmation: "1")
      @user.valid?
      expect(@user.errors.full_messages).to_not be_empty
    end
  end

  describe ".authenticate_with_credentials" do
    it "should login with correct credentials" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password")
      @user_login = User.authenticate_with_credentials("john@example.com", "password")
      expect(@user_login).to eq(@user)
    end

    it "gives an error when logging in with incorrect email" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password")
      @user_login = User.authenticate_with_credentials("john1231@example.com", "password")
      expect(@user_login).to_not eq(@user)
    end

    it "gives an error when logging in with incorrect password" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password")
      @user_login = User.authenticate_with_credentials("john@example.com", "password1231")
      expect(@user_login).to_not eq(@user)
    end

    it "should login with spaces in email" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password")
      @user_login = User.authenticate_with_credentials("john@example.com  ", "password")
      expect(@user_login).to eq(@user)
    end

    it "should login with different capitalization of email" do
      @user = User.create(first_name: "John", last_name: "Smith", email: "john@example.com", password: "password", password_confirmation: "password")
      @user_login = User.authenticate_with_credentials("joHn@examPle.com", "password")
      expect(@user_login).to eq(@user)
    end

  end
end
