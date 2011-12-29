require 'spec_helper'

describe Group do

  describe "data" do

    it "should respond to name" do
      @group = Group.new
      @group.should respond_to :name
    end

    it "should respond to description" do
      @group = Group.new
      @group.should respond_to :description
    end
  end

  describe "validations" do

    before(:each) do
      @attr = { :name => "Example Group",
                :description => "Lorem Ipsum" }
    end

    it "should create a new instance given valid attributes" do
      Group.create!(@attr)
    end

    describe "name" do

      it "should be required" do
        group = Group.new(@attr.merge(:name => ""))
        group.should_not be_valid
      end

      it "should not be too long" do
        group = Group.new(@attr.merge(:name => ("a" * 51)))
        group.should_not be_valid
      end
    end

    describe "description" do

      it "should not be required" do
        group = Group.new(@attr.merge(:description => ""))
        group.should be_valid
      end

      it "should not be too long" do
        group = Group.new(@attr.merge(:description => ("a" * 501)))
        group.should_not be_valid
      end
    end
  end

  describe "user association" do

    before(:each) do
      @group = Factory(:group)
      @user = Factory(:user)
      @group.users << @user
    end

    it "should respond to users" do
      @group.should respond_to :users
    end

    it "should have the right users" do
      @group.users.should == [@user]
    end

    it "should not have duplicate users" do
      lambda do
        @group.users << @user
      end.should raise_error
    end
  end
end
