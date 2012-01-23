class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_and_belongs_to_many :groups
  has_and_belongs_to_many :costs
  has_many :costs_created, :class_name => "Cost"

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
    sum
  end

  def users
    costs.collect {|c| c.users}.flatten.uniq
  end
end
