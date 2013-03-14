class Transaction < ActiveRecord::Base
  attr_accessible :amount, :confirmed, :note
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'

  validates :amount, :numericality => { :greater_than => 0 }
  validates :from, :presence => true
  validates :to, :presence => true
  validate :from_cannot_be_to

  def from_cannot_be_to
    if from == to
      errors.add(:from, "Can't be from and to the same user")
    end
  end
end
