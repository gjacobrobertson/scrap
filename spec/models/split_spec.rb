require "spec_helper"

describe Split do
  before { @split = FactoryGirl.build(:split) }

  subject { @split }

  it { should have_many :split_transactions }
  it { should be_valid }
end