class Split < ActiveRecord::Base
  attr_accessor :from, :with, :amount, :note
  attr_accessible :with, :amount, :note
  has_many :split_transactions

  validates :from, :presence => true
  validates :with, :presence => true
  validates :amount, :numericality => { :greater_than => 0 }

  before_save :set_transactions

  def set_transactions
    with_list = with.split(',')
    with_list.each do |user|
      split_transactions.build(
        :from => User.find(from),
        :to => User.find_by_uid(user),
        :amount => (amount.to_f / (with_list.size + 1)),
        :note => note,
        :split => self
      )
    end
  end
end
