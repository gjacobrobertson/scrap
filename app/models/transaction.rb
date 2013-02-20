class Transaction < ActiveRecord::Base
  attr_accessible :amount, :confirmed, :from, :note, :to, :type
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'
end
