class CreateCostsUsersTable < ActiveRecord::Migration
  def change
    create_table :costs_users, :id => false do |t|
      t.integer :cost_id
      t.integer :user_id
    end

    add_index :costs_users, :cost_id
    add_index :costs_users, :user_id
    add_index :costs_users, [:cost_id, :user_id], :unique => true
  end
end
