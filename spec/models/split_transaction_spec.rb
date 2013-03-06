require 'spec_helper'

describe SplitTransaction do
  before { @transaction = FactoryGirl.build(:split_transaction) }

  subject { @transaction }

  it { should belong_to :split }
  it { should be_a Transaction }
  it { should be_valid }
end
