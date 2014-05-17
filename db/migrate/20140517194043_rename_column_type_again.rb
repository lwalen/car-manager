class RenameColumnTypeAgain < ActiveRecord::Migration
  def change
    rename_column :services, :type_id, :service_type_id
  end
end
