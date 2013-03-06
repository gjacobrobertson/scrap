require "spec_helper"

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to :name }
  it { should have_many :debits }
  it { should have_many :credits }
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
end
