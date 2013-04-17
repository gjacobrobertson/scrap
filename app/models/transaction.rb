class Transaction < ActiveRecord::Base
  attr_accessible :amount, :confirmed, :note
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'

  validates :amount, :numericality => { :greater_than => 0 }
  validates :from, :presence => true
  validates :to, :presence => true
  validate :from_cannot_be_to

  scope :approved, where(:confirmed => true)
  scope :rejected, where(:confirmed => false)
  scope :pending, where(:confirmed => nil)
  scope :approved_or_pending, where('confirmed = ? OR confirmed IS NULL', true)

  def from_cannot_be_to
    if from == to
      errors.add(:from, "Can't be from and to the same user")
    end
  end

  def approve
    self.confirmed = true
    save
  end

  def reject
    self.confirmed = false
    save
  end

  before_save :round_pennies

  def round_pennies
    self.amount = self.amount.round(2)
  end
end
