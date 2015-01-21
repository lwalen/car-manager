class AddColumnsBackToUsers < ActiveRecord::Migration
  def change
    add_column :users, :number_of_gas_records, :integer
    add_column :users, :number_of_service_records, :integer
    add_column :users, :distance_unit, :string
    add_column :users, :volume_unit, :string
    add_column :users, :primary_car_id, :integer
  end
end
