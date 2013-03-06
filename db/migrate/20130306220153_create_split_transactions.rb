class CreateSplitTransactions < ActiveRecord::Migration
  def change
    create_table :split_transactions do |t|

      t.timestamps
    end
  end
end
