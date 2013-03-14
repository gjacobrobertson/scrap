class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :from
      t.integer :to
      t.float :amount
      t.boolean :confirmed
      t.string :note
      t.string :type

      t.timestamps
    end

    add_index :transactions, :from
    add_index :transactions, :to
  end
end
