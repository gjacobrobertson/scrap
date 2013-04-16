class SplitTransaction < Transaction
  attr_accessible :from, :to, :amount, :confirmed, :note, :split
  belongs_to :split

  def others_count
    split.split_transactions.count - 1
  end
end
