class RenameColumnType < ActiveRecord::Migration
  def change
    rename_column :services, :type, :type_id
  end
end
