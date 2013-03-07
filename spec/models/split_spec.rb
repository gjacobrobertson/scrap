require "spec_helper"

describe Split do
  before { @split = FactoryGirl.build(:split) }

  subject { @split }

  it { should have_many :split_transactions }
  it { should respond_to :from }
  it { should respond_to :with }
  it { should respond_to :amount }
  it { should respond_to :note }
  it { should be_valid }
end