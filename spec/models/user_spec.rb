require "spec_helper"

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :provider }
  it { should respond_to :uid }
  it { should respond_to :total_debt }
  it { should respond_to :total_credit }
  it { should respond_to :total_net }
  it { should respond_to :creditors }
  it { should respond_to :debtors }
  it { should respond_to :credit_subtotals }
  it { should respond_to :debt_subtotals }
  it { should respond_to :debt_to }
  it { should respond_to :pending_approvals }
  it { should respond_to :rejections }
  it { should have_many :debits }
  it { should have_many :credits }
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "debt and credit methods" do
    before do
      @user.save
      @debtor = FactoryGirl.create(:user)
      @creditor = FactoryGirl.create(:user)
      @debt = FactoryGirl.create(:split, :from => @debtor, :with => [@user.uid], :amount => 5)
      @debt.split_transactions.each {|t| t.approve}
      @credit = FactoryGirl.create(:split, :from => @user, :with => [@creditor.uid], :amount => 10)
      @credit.split_transactions.each{|t| t.approve}
      @unconfirmed = FactoryGirl.create(:split, :from => @debtor, :with => [@user.uid], :amount => 15)
      @rejected = FactoryGirl.create(:split, :from => @user, :with => [@debtor.uid], :amount => 20)
      @rejected.split_transactions.each {|t| t.reject}
    end

    describe "total_debt" do
      subject { @user.total_debt }
      it { should be_a_kind_of Numeric }
      it { should be == 2.50 }
    end

    describe "total_credit" do
      subject { @user.total_credit }
      it { should be_a_kind_of Numeric }
      it { should be == 5 }
    end

    describe "total_net" do
      subject { @user.total_net }
      it { should be_a_kind_of Numeric }
      it { should be == 2.50 }
    end

    describe "creditors" do
      subject { @user.creditors }
      it { should be_a_kind_of Array }
      it { should have(1).items }
      it { should include @creditor }
    end

    describe "debtors" do
      subject { @user.debtors }
      it { should be_a_kind_of Array }
      it { should have(1).items }
      it { should include @debtor }
    end

    describe "debt_subtotals" do
      subject { @user.debt_subtotals }
      it { should be_a_kind_of Array }
      it { should have(1).items }
      it do
        entry = { :user => @debtor, :amount => 2.50 }
        should include entry
      end
    end

    describe "credit_subtotals" do
      subject { @user.credit_subtotals }
      it { should be_a_kind_of Array }
      it { should have(1).items }
      it do
        entry = { :user => @creditor, :amount => 5 }
        should include entry
      end
    end

    describe "debt_to" do
      describe "debtor" do
        subject { @user.debt_to @debtor }
        it { should be == 2.5 }
      end
      describe "creditor" do
        subject { @user.debt_to @creditor }
        it { should be == -5 }
      end
    end

    describe "pending_approvals" do
      subject { @user.pending_approvals }
      it { should be_a_kind_of Array }
      it { should have(1).items }
      it { should include @unconfirmed.split_transactions.first }
    end

    describe "rejections" do
      subject { @user.rejections }
      it { should be_a_kind_of Array }
      it { should have(1).items }
      it { should include @rejected.split_transactions.first }
    end
  end
end
