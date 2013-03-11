require "spec_helper"

describe Split do
  before do
    @split = FactoryGirl.build(:split)
    @split.from = FactoryGirl.create(:user)
  end

  subject { @split }

  it { should have_many :split_transactions }
  it { should respond_to :from }
  it { should respond_to :with }
  it { should respond_to :amount }
  it { should respond_to :note }
  it { should_not allow_mass_assignment_of :from }
  it { should be_valid }

  describe "when from is not present" do
    before { @split.from = nil }
    it { should_not be_valid}
  end

  describe "when with is not present" do
    before { @split.with = nil }
    it { should_not be_valid}
  end

  describe "when amount is 0" do
    before { @split.amount = 0 }
    it { should_not be_valid}
  end

  describe "when amount is negative" do
    before { @split.amount = -1 }
    it { should_not be_valid}
  end

  describe "when it is saved" do
    before do
      @count = SplitTransaction.count
      @split.save
    end
    it "should create split_transactions with the correct amounts" do
      (SplitTransaction.count - @count).should eq 2
      @split.split_transactions.each do |trans|
        trans.amount.should eq 3.50
      end
    end
  end
end