require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should create a new user entry with all data" do
      @user = User.new(first_name: 'Robert', last_name: 'P', email: 'robert@san.com', password: "12345test", password_confirmation: "12345test")
      expect(@user).to be_valid
    end
    it "should not create a new user entry with all data when password confirmation fails" do
      @user = User.new(first_name: 'Robert', last_name: 'P', email: 'robert@san2.com', password: "12345test", password_confirmation: "123456test")
      expect(@user).to_not be_valid
    end
    it "should not create a new user entry with all data when the unique case sensitive email is used" do
      @user = User.new(first_name: 'Robert', last_name: 'T', email: 'robert@test.com', password: "12345test", password_confirmation: "12345test")
      expect(@user).to be_valid
      @user.save
      @userTwo = User.new(first_name: 'Robert', last_name: 'W', email: 'Robert@TEST.com', password: "12345test", password_confirmation: "12345test")
      expect(@userTwo).to_not be_valid
    end
    it "should not create a new user entry without an email" do
      @user = User.new(first_name: 'Robert', last_name: 'P', email: nil, password: "12345test", password_confirmation: "12345test")
      expect(@user).to_not be_valid
    end
    it "should not create a new user entry without an firstname" do
      @user = User.new(first_name: nil, last_name: 'P', email: nil, password: "12345test", password_confirmation: "12345test")
      expect(@user).to_not be_valid
    end
    it "should not create a new user entry without an lastname" do
      @user = User.new(first_name: "Robert", last_name: nil, email: nil, password: "12345test", password_confirmation: "12345test")
      expect(@user).to_not be_valid
    end
  end
    describe 'Password minimum length' do
      it "Passwords should have a minimum length" do
        @user = User.new(first_name: 'Robert', last_name: 'P', email: 'robert@san.com', password: "x", password_confirmation: "x")
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
      end
  end
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "login with valid information" do
      @user = User.new(first_name: 'Robert', last_name: 'P', email: 'robert@san.com', password: "12345test", password_confirmation: "12345test")
      expect(@user).to be_valid
      @user.save
      @user_logged_in = User.authenticate_with_credentials('robert@san.com', "12345test")
      expect(@user_logged_in).to_not eq(nil)
    end
    it "login with invalid information will fail" do
      @user = User.new(first_name: 'Robert', last_name: 'P', email: 'robert@san.com', password: "12345test", password_confirmation: "12345test")
      expect(@user).to be_valid
      @user.save
      @user_logged_in = User.authenticate_with_credentials('robert@san.com', "1234test")
      expect(@user_logged_in).to eq(nil)
    end
    it "login with valid information and email spaces" do
      @user = User.new(first_name: 'Robert', last_name: 'P', email: 'robert@san.com', password: "12345test", password_confirmation: "12345test")
      expect(@user).to be_valid
      @user.save
      @user_logged_in = User.authenticate_with_credentials('rober t@san.com', "12345test")
      expect(@user_logged_in).to_not eq(nil)
    end
    it "login with valid information and email case differences" do
      @user = User.new(first_name: 'Robert', last_name: 'P', email: 'robert@san.com', password: "12345test", password_confirmation: "12345test")
      expect(@user).to be_valid
      @user.save
      @user_logged_in = User.authenticate_with_credentials('Robert@san.com', "12345test")
      expect(@user_logged_in).to_not eq(nil)
    end
  end
end
