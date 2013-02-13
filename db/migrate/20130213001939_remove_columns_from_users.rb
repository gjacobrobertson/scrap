class RemoveColumnsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :email
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
  end

  def down
    add_column :users, :unconfirmed_email, :string
    add_column :users, :confirmation_sent_at, :string
    add_column :users, :confirmed_at, :string
    add_column :users, :confirmation_token, :string
    add_column :users, :last_sign_in_ip, :string
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_at, :string
    add_column :users, :current_sign_in_at, :string
    add_column :users, :sign_in_count, :string
    add_column :users, :reset_password_sent_at, :string
    add_column :users, :reset_password_token, :string
    add_column :users, :encrypted_password, :string
    add_column :users, :email, :string
  end
end
