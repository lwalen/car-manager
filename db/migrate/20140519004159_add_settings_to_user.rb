class AddSettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :number_of_records, :integer, default: 5
    add_column :users, :distance_unit, :string, default: 'Miles'
    add_column :users, :volume_unit, :string, default: 'Gallons'
  end
end
