require 'spec_helper'

describe TransactionsController do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @debtor = FactoryGirl.create(:user)
    @split = FactoryGirl.create(:split, :from => @debtor, :with => [@user.uid])
    @transaction = @split.split_transactions.first
  end

  describe "#approve" do

    it "should approve the transaction" do
      post :approve, :id => @transaction.id
      @transaction.reload
      @transaction.confirmed.should be_true
    end
  end

  describe "#reject" do
    it "should reject the transaction" do
      post :reject, :id => @transaction.id
      @transaction.reload
      @transaction.confirmed.should_not be_nil
      @transaction.confirmed.should be_false
    end
  end
end
