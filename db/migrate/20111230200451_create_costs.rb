class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :description
      t.decimal :amount

      t.timestamps
    end
  end
end
