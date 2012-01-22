class Cost < ActiveRecord::Base
  attr_accessible :description, :amount, :group_id

  belongs_to :user
  belongs_to :group
  has_and_belongs_to_many :users

  validates :description, :presence => true,
                          :length => { :maximum => 50 }
  validates :amount,      :presence => true,
                          :numericality => { :greater_than => 0 }
end
