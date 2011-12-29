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
    end

    it "should respond to users" do
      @group.should respond_to :users
    end

    it "should be able to add a member" do
      @group.add_member(@user)
      @group.member?(@user).should be_true
    end

    it "should be able to remove a member" do
      @group.add_member(@user)
      @group.remove_member(@user)
      @group.member?(@user).should be_false
    end
  end
end
