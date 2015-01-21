class RemoveAllButIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :username
    remove_column :users, :password_digest
    remove_column :users, :created_at
    remove_column :users, :updated_at
    remove_column :users, :auth_token
    remove_column :users, :number_of_gas_records
    remove_column :users, :distance_unit
    remove_column :users, :volume_unit
    remove_column :users, :primary_car_id
    remove_column :users, :number_of_service_records
  end
end
