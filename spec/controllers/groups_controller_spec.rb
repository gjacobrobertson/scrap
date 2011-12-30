require 'spec_helper'

describe GroupsController do

  describe "GET 'index'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "as a signed in user" do

      before(:each) do
        test_sign_in(@user)
      end


  end

  describe "GET 'show'" do
  end

  describe "GET 'new'" do
  end

  describe "POST 'create'" do
  end

  describe "GET 'edit'" do
  end

  describe "PUT 'update'" do
  end

  describe "DELETE 'destroy'" do
  end
end
