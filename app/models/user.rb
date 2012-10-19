class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_and_belongs_to_many :groups
  has_and_belongs_to_many :costs
  has_many :costs_created, :class_name => "Cost"
  has_many :payments_to, :class_name => "Payment", :foreign_key => "to_id"
  has_many :payments_from, :class_name => "Payment", :foreign_key => "from_id"

  has_secure_password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,      :presence     => true,
                        :length       => { :maximum => 50 }
  validates :email,     :presence     => true,
                        :format       => { :with => email_regex },
                        :uniqueness   => { :case_sensitive => false }
  validates :password,  :presence     => true,
                        :on           => :create

  def join_group(group)
    groups << group unless group?(group)
  end

  def leave_group(group)
    groups.delete(group)
  end

  def group?(group)
    groups.exists?(group)
  end

  def build_cost(cost_attr)
    cost = costs_created.build(cost_attr)
    cost.users = cost.group.users
    cost
  end

  def owes(user)
    sum = 0

    costs.where(:user_id => user.id).each do |c|
      sum += c.amount / c.users.count
    end

    payments_to.where(:from_id => user.id).each do |p|
      sum += p.amount
    end

    sum
  end

  def debts
    users = costs.collect {|c| c.users}.flatten
    users += payments_to.collect {|p| p.from}
    users += payments_from.collect {|p| p.to}
    users = users.uniq
    users.delete(self)
    users
  end

  def history(user)
    (user.costs.where(:user_id => id) +
    costs.where(:user_id => user.id) +
    user.payments_to.where(:from_id => id) +
    payments_to.where(:from_id => user.id)).sort {|a,b| b.created_at <=> a.created_at}
  end
end
