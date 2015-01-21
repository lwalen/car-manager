class AddDefaultsToUsers < ActiveRecord::Migration
  def change
    change_column :users, :number_of_gas_records, :integer, default: 5
    change_column :users, :number_of_service_records, :integer, default: 5
  end
end
