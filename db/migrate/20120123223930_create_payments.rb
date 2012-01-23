class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :description
      t.decimal :amount
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
  end
end
