class RenameNumberOfRecords < ActiveRecord::Migration
  def change
    rename_column :users, :number_of_records, :number_of_gas_records
    add_column :users, :number_of_service_records, :integer, default: 5
  end
end
