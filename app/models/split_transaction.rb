class SplitTransaction < Transaction
  attr_accessible :from, :to, :amount, :confirmed, :note, :split
  belongs_to :split

  def others_count
    self.split.split_transactions.count - 1
  end

  def split_total
    self.amount * (self.split.split_transactions.count + 1)
  end
end
