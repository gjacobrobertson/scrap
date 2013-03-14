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
    Transaction.where(:to_id => self.id).each{|t| sum += t.amount}
    sum
  end

  def total_credit
    sum = 0
    Transaction.where(:from_id => self.id).each{|t| sum += t.amount}
    sum
  end

  def total_net
    total_credit - total_debt
  end

  def creditors
    Transaction.where(:from_id => self.id).collect{|t| t.to}.uniq
  end

  def debtors
    Transaction.where(:to_id => self.id).collect{|t| t.from}.uniq
  end

  def debt_to(user)
    amount = 0
    Transaction.where(:from_id => self.id, :to_id => user.id).each{|t| amount -= t.amount}
    Transaction.where(:from_id => user.id, :to_id => self.id).each{|t| amount += t.amount}
    amount
  end

  def debt_subtotals
    items = debtors.collect{|u| {:user => u, :amount => debt_to(u)}}.select{|d| d[:amount] > 0}
    items.sort{|a,b| b[:amount] <=> a[:amount]}
  end

  def credit_subtotals
    items = creditors.collect{|u| {:user => u, :amount => -1 * debt_to(u)}}.select{|d| d[:amount] > 0}
    
    items.sort{|a,b| b[:amount] <=> a[:amount]}
  end
end
