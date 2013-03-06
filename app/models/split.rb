class Split < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :split_transactions
end
