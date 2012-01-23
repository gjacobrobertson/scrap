class Payment < ActiveRecord::Base
  attr_accessible :description, :amount, :to_id

  belongs_to :from, :class_name => "User"
  belongs_to :to, :class_name => "User"

  validates :description, :presence => true,
                          :length => { :maximum => 50 }
  validates :amount,       :presence => true,
                          :numericality => { :greater_than => 0}
end
