require 'spec_helper'

describe SplitsController, "#create" do
  before { @params = FactoryGirl.attributes_for(:split) }

  describe "for a valid split" do
    before do
      @count = Split.count
      post :create, :split => @params
    end

    it { should respond_with :success }

    it "should create a new split" do
      Split.count.should be > @count
    end
  end

  describe "for a split without a from" do
    before do
      @count = Split.count
      @params[:from] = nil
      post :create, :split => @params
    end

    it { should respond_with :success }

    it "should not create a new split" do
      Split.count.should eq @count
    end
  end

  describe "for a split without a with" do
    before do
      @count = Split.count
      @params[:with] = nil
      post :create, :split => @params
    end

    it { should respond_with :success }

    it "should not create a new split" do
      Split.count.should eq @count
    end
  end

  describe "for a split without an amount" do
    before do
      @count = Split.count
      @params[:amount] = nil
      post :create, :split => @params
    end

    it { should respond_with :success }

    it "should not create a new split" do
      Split.count.should eq @count
    end
  end

  describe "for a split with 0 amount" do
    before do
      @count = Split.count
      @params[:amount] = 0
      post :create, :split => @params
    end

    it { should respond_with :success }

    it "should not create a new split" do
      Split.count.should eq @count
    end
  end

  describe "for a split with a negative amount" do
    before do
      @count = Split.count
      @params[:amount] = -1
      post :create, :split => @params
    end

    it { should respond_with :success }

    it "should not create a new split" do
      Split.count.should eq @count
    end
  end
end
