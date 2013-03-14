class SplitTransaction < Transaction
  attr_accessible :from, :to, :amount, :confirmed, :note, :split
  belongs_to :split
end
