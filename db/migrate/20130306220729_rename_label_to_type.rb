class RenameLabelToType < ActiveRecord::Migration
  def up
    rename_column :transactions, :label, :type
  end

  def down
  end
end
