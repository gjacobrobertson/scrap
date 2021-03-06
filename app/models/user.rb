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
    Transaction.approved_or_pending.where(:from_id => self.id).collect{|t| t.to}.uniq
  end

  def creditors
    Transaction.approved_or_pending.where(:to_id => self.id).collect{|t| t.from}.uniq
  end

  def debt_to(user)
    amount = 0
    Transaction.approved_or_pending.where(:from_id => self.id, :to_id => user.id).each{|t| amount -= t.amount}
    Transaction.approved_or_pending.where(:from_id => user.id, :to_id => self.id).each{|t| amount += t.amount}
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

  def notifications
    approvals = Transaction.pending.where(:to_id => self.id)
    rejections = Transaction.rejected.where(:from_id => self.id)
    approvals + rejections
  end

  def has_notifications
    notifications.count > 0
  end

  def pending_for_user(user)
    credits = Transaction.rejected.where(:from_id => self.id, :to_id => user.id)
    debts = Transaction.pending.where(:from_id => user.id, :to_id => self.id)
    debts + credits
  end

  def history_for_user(user)
    debts = Transaction.approved.where(:from_id => user.id, :to_id => self.id)
    credits = Transaction.approved.where(:from_id => self.id, :to_id => user.id)
    debts + credits
  end
end
