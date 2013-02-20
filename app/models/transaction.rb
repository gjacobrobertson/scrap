class Transaction < ActiveRecord::Base
  attr_accessible :amount, :confirmed, :note, :label
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'

  validates :amount, :numericality => { :greater_than => 0 }
  validates :from, :presence => true
  validates :to, :presence => true
  validates :label, :inclusion => { :in => %w(share give) }
end
