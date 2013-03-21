require 'spec_helper'

describe SplitsController, "#create" do
  before do 
    @params = FactoryGirl.attributes_for(:split)
    sign_in FactoryGirl.create(:user)
  end

  it "should respond successfully" do
    post :create, :split => @params
    should respond_with :success
    should respond_with_content_type :html
  end

  describe "for a valid split" do
    before do
      @count = Split.count
      post :create, :split => @params
    end

    it "should create a new split" do
      Split.count.should be > @count
    end

    it "should render alert" do
      should render_template(:alert)
    end
  end

  describe "for an invalid split" do
    before do
      @count = Split.count
      @params[:amount] = nil
    end

    it "should not create a new split" do
      post :create, :split => @params
      Split.count.should eq @count
    end

    it "should render alert" do
      post :create, :split => @params
      should render_template(:alert)
    end
  end
end
