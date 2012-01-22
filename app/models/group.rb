class Group < ActiveRecord::Base
  attr_accessible :name, :description

  has_and_belongs_to_many :users
  has_many :costs

  validates :name,  :presence => true,
                    :length => { :maximum => 50 }
  validates :description, :length => { :maximum => 500 }

  def add_member(user)
    users << user unless member?(user)
  end

  def remove_member(user)
    users.delete(user)
  end

  def member?(user)
    users.exists?(user)
  end
end
