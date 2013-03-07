require 'spec_helper'

describe SplitsController, "#create" do
  before { @params = FactoryGirl.attributes_for(:split) }


  describe "for a valid split" do
    before do
      @count = Split.count
      post :create, :split => @params
    end

    it { should respond_with :success }
    it { should respond_with_content_type :json }

    it "should create a new split" do
      Split.count.should be > @count
    end
  end

  describe "for an invalid split" do
    before do
      @count = Split.count
      @params[:from] = nil
      post :create, :split => @params
    end

    it { should respond_with 403 }
    it { should respond_with_content_type :json}

    it "should not create a new split" do
      Split.count.should eq @count
    end

    it "should contain errors" do
      body = JSON.parse(response.body)
      body.should include('errors')
    end
  end
end
