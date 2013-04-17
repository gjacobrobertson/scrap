require "spec_helper"

describe User do
  before { @user = FactoryGirl.create(:user) }

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
  it { should respond_to :notifications }
  it { should respond_to :has_notifications }
  it { should respond_to :pending_for_user }
  it { should respond_to :history_for_user }
  it { should have_many :debits }
  it { should have_many :credits }
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "debt and credit methods" do
    before do
      @debtor = FactoryGirl.create(:user)
      @creditor = FactoryGirl.create(:user)

      @approved_debt = FactoryGirl.create(:split, :from => @creditor, :with => [@user], :amount => 5)
      @approved_debt.split_transactions.each {|t| t.approve}

      @approved_credit = FactoryGirl.create(:split, :from => @user, :with => [@debtor], :amount => 10)
      @approved_credit.split_transactions.each{|t| t.approve}

      @pending_debt = FactoryGirl.create(:split, :from => @creditor, :with => [@user], :amount => 15)

      @pending_credit = FactoryGirl.create(:split, :from => @user, :with => [@debtor], :amount => 20)

      @rejected_debt = FactoryGirl.create(:split, :from => @creditor, :with => [@user], :amount => 25)
      @rejected_debt.split_transactions.each {|t| t.reject}

      @rejected_credit = FactoryGirl.create(:split, :from => @user, :with => [@debtor], :amount => 30)
      @rejected_credit.split_transactions.each {|t| t.reject}
    end

    describe "total_debt" do
      subject { @user.total_debt }
      it { should be_a_kind_of Numeric }
      it { should be == 10.00 }
    end

    describe "total_credit" do
      subject { @user.total_credit }
      it { should be_a_kind_of Numeric }
      it { should be == 15.00 }
    end

    describe "total_net" do
      subject { @user.total_net }
      it { should be_a_kind_of Numeric }
      it { should be == 5.00 }
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
        entry = { :user => @creditor, :amount => 10.00 }
        should include entry
      end
    end

    describe "credit_subtotals" do
      subject { @user.credit_subtotals }
      it { should be_a_kind_of Array }
      it { should have(1).items }
      it do
        entry = { :user => @debtor, :amount => 15.00 }
        should include entry
      end
    end

    describe "debt_to" do
      describe "creditor" do
        subject { @user.debt_to @creditor }
        it { should be == 10.00 }
      end
      describe "debtor" do
        subject { @user.debt_to @debtor }
        it { should be == -15.00 }
      end
    end

    describe "notifications" do
      subject { @user.notifications }
      it { should be_a_kind_of Array }
      it { should have(2).items }
      it { should include @pending_debt.split_transactions.first }
      it { should include @rejected_credit.split_transactions.first }
    end
  end

  describe "user methods" do
    before do 
      @foo = FactoryGirl.create(:user)
      @bar = FactoryGirl.create(:user)

      @approved_debt = FactoryGirl.create(:split, :from => @foo, :with => [@user])
      @approved_debt.split_transactions.each{|t| t.approve}
      @rejected_debt = FactoryGirl.create(:split, :from => @foo, :with => [@user])
      @rejected_debt.split_transactions.each{|t| t.reject}
      @pending_debt = FactoryGirl.create(:split, :from => @foo, :with => [@user])

      @approved_credit = FactoryGirl.create(:split, :from => @user, :with => [@foo])
      @approved_credit.split_transactions.each{|t| t.approve}
      @rejected_credit = FactoryGirl.create(:split, :from => @user, :with => [@foo])
      @rejected_credit.split_transactions.each{|t| t.reject}
      @pending_credit = FactoryGirl.create(:split, :from => @user, :with => [@foo])

      @bar_debt = FactoryGirl.create(:split, :from => @bar, :with => [@user])
      @bar_credit = FactoryGirl.create(:split, :from => @user, :with => [@bar])
    end

    describe "@user pending_for_user @foo" do
      subject { @user.pending_for_user @foo}
      it { should be_a_kind_of Array }
      it { should have(2).items }
      it { should include @rejected_credit.split_transactions.first }
      it { should include @pending_debt.split_transactions.first }
    end

    describe "@foo pending_for_user @user" do
      subject { @foo.pending_for_user @user }
      it { should be_a_kind_of Array }
      it { should have(2).items }
      it { should include @rejected_debt.split_transactions.first }
      it { should include @pending_credit.split_transactions.first }
    end

    describe "history_for_user" do
      subject { @user.history_for_user @foo }
      it { should be_a_kind_of Array }
      it { should have(2).items }
      it { should include @approved_debt.split_transactions.first }
      it { should include @approved_credit.split_transactions.first }
    end
  end
end
