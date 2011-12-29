require 'spec_helper'

describe User do
  
  describe "data" do

    it "should respond to name" do
      @user = User.new
      @user.should respond_to :name
    end

    it "should respond to email" do
      @user = User.new
      @user.should respond_to :email
    end
  end

  describe "validations" do

    before(:each) do
      @attr = { :name => "Example User",
                :email => "user@example.com",
                :password => "foobar",
                :password_confirmation => "foobar" }
    end

    it "should create a new instance given valid attributes" do
      User.create!(@attr)
    end

    describe "name" do

      it "should be required" do
        user = User.new(@attr.merge(:name => ""))
        user.should_not be_valid
      end

      it "should not be too long" do
        user = User.new(@attr.merge(:name => ("a" * 51)))
        user.should_not be_valid
      end
    end

    describe "email" do

      it "should be required" do
        user = User.new(@attr.merge(:email => ""))
        user.should_not be_valid
      end

      it "should accept valid email addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar first.last@foo.jp]
        addresses.each do |address|
          user = User.new(@attr.merge(:email => address))
          user.should be_valid
        end
      end

      it "should reject invalid email addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          invalid_email_user = User.new(@attr.merge(:email => address))
          invalid_email_user.should_not be_valid
        end
      end

      it "should reject duplicate email addresses" do
        #Put a user with given email address into the database.
        User.create!(@attr)
        user = User.new(@attr)
        user.should_not be_valid
      end

      it "should reject email addresses identical up to case" do
        email = @attr[:email].upcase
        User.create!(@attr.merge(:email => email))
        user = User.new(@attr)
        user.should_not be_valid
      end
    end

    describe "password" do

      it "should be required" do
        user = User.new(@attr.merge(:password => "", :password_confirmation => ""))
        user.should_not be_valid
      end

      it "should require matching confirmation" do
        user = User.new(@attr.merge(:password_confirmation => "barfoo"))
        user.should_not be_valid
      end
    end
  end

  describe "group association" do

    before(:each) do
      @group = Factory(:group)
      @user = Factory(:user)
      @user.groups << @group
    end

    it "should respond to groups" do
      @user.should respond_to :groups
    end

    it "should have the right groups" do
      @user.groups.should == [@group]
    end

    it "should not have duplicate groups" do
      lambda do
        @user.groups << @group
      end.should raise_error
    end
  end
end
