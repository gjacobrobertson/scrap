class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :rememberable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :remember_me, :provider, :uid, :name

  validates :name, :presence => true

  has_many :debits, :class_name => 'Transaction', :foreign_key => "to_id"
  has_many :credits, :class_name => 'Transaction', :foreign_key => "from_id"
  # attr_accessible :title, :body
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
         provider:auth.provider,
         uid:auth.uid,
         )
    end
    user
  end

  def total_debt
    sum = 0
    debt_subtotals.each{|s| sum += s[:amount]}
    sum
  end

  def total_credit
    sum = 0
    credit_subtotals.each{|s| sum += s[:amount]}
    sum
  end

  def total_net
    total_credit - total_debt
  end

  def debtors
    Transaction.where(:from_id => self.id, :confirmed => true).collect{|t| t.to}.uniq
  end

  def creditors
    Transaction.where(:to_id => self.id, :confirmed => true).collect{|t| t.from}.uniq
  end

  def debt_to(user)
    amount = 0
    Transaction.where(:from_id => self.id, :to_id => user.id, :confirmed => true).each{|t| amount -= t.amount}
    Transaction.where(:from_id => user.id, :to_id => self.id, :confirmed => true).each{|t| amount += t.amount}
    amount
  end

  def debt_subtotals
    items = creditors.collect{|u| {:user => u, :amount => debt_to(u)}}.select{|d| d[:amount] > 0}
    items.sort{|a,b| b[:amount] <=> a[:amount]}
  end

  def credit_subtotals
    items = debtors.collect{|u| {:user => u, :amount => -1 * debt_to(u)}}.select{|d| d[:amount] > 0}
    items.sort{|a,b| b[:amount] <=> a[:amount]}
  end

  def pending_approvals
    Transaction.where(:to_id => self.id, :confirmed => nil).to_a
  end

  def has_pending_approvals
    pending_approvals.count > 0
  end

  def rejections
    Transaction.where(:from_id => self.id, :confirmed => false).to_a
  end

  def has_rejections
    rejections.count > 0
  end

  def has_notifications
    has_pending_approvals || has_rejections
  end

  def approvals_for_user(user)
    debts = Transaction.pending.where(:from_id => user.id, :to_id => self.id)
    credits = Transaction.pending.where(:from_id => self.id, :to_id => user.id)
    debts + credits
  end

  def rejections_for_user(user)
    debts = Transaction.rejected.where(:from_id => user.id, :to_id => self.id)
    credits = Transaction.rejected.where(:from_id => self.id, :to_id => user.id)
    debts + credits
  end

  def history_for_user(user)
    debts = Transaction.approved.where(:from_id => user.id, :to_id => self.id)
    credits = Transaction.approved.where(:from_id => self.id, :to_id => user.id)
    debts + credits
  end
end
