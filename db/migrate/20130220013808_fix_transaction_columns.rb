class FixTransactionColumns < ActiveRecord::Migration
  def up
    rename_column :transactions, :from, :from_id
    rename_column :transactions, :to, :to_id
    rename_column :transactions, :type, :label
  end

  def down
  end
end
