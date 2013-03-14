require "spec_helper"

describe Transaction do
  before { @transaction = FactoryGirl.build(:transaction) }

  subject { @transaction }

  it { should belong_to :from }
  it { should belong_to :to }
  it { should respond_to :amount }
  it { should respond_to :note }
  it { should respond_to :confirmed }
  it { should be_valid }

  describe "when from is not present" do
    before { @transaction.from = nil }
    it { should_not be_valid }
  end

  describe "when to is not present" do
    before { @transaction.to = nil }
    it { should_not be_valid }
  end

  describe "when amount is not present" do
    before { @transaction.amount = nil }
    it { should_not be_valid }
  end

  describe "when amount is negative" do
    before { @transaction.amount = -1.2 } 
    it { should_not be_valid }
  end

  describe "when from is to" do
    before do
      user = FactoryGirl.build(:user)
      @transaction.from = user
      @transaction.to = user
    end

    it { should_not be_valid }
  end

  describe "approve" do
    before do
      @transaction.approve
    end

    it "confirmed should be true" do
      @transaction.confirmed.should be_true
    end
  end

  describe "reject" do
    before do
      @transaction.reject
    end

    it "confirmed should be false" do
      @transaction.confirmed.should be_false
    end
  end
    
end
