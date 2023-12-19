require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should create a new user entry with all data" do
      @user = User.new(name: 'Robert P.', email: 'robert@san.com', password: "12345test", password_confirmation: "12345test")
      expect(@user).to be_valid
    end
    it "should not create a new user entry with all data when password confirmation fails" do
      @user = User.new(name: 'Robert P.', email: 'robert@san2.com', password: "12345test", password_confirmation: "123456test")
      expect(@user).to_not be_valid
    end
    it "should not create a new user entry with all data when the unique case sensitive email is used" do
      @user = User.new(name: 'Robert T.', email: 'robert@test.com', password: "12345test", password_confirmation: "12345test")
      expect(@user).to be_valid
      @user.save
      @userTwo = User.new(name: 'Robert W.', email: 'Robert@TEST.com', password: "12345test", password_confirmation: "12345test")
      expect(@userTwo).to_not be_valid
    end
    it "should not create a new user entry without an email" do
      @user = User.new(name: 'Robert T.', email: nil, password: "12345test", password_confirmation: "12345test")
      expect(@user).to_not be_valid
    end
  end
end
