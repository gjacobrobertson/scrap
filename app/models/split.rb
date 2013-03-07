class Split < ActiveRecord::Base
  attr_accessor :from, :with, :amount, :note
  attr_accessible :from, :with, :amount, :note
  has_many :split_transactions

  validates :from, :presence => true
  validates :with, :presence => true
  validates :amount, :numericality => { :greater_than => 0 }
end
