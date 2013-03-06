class SplitTransactionColumns < ActiveRecord::Migration
  def up
    add_column :transactions, :split_id, :integer
  end

  def down
  end
end
