class MovePrimaryCarToUser < ActiveRecord::Migration
  def change
    remove_column :cars, :main
    add_column :users, :primary_car_id, :integer
  end
end
