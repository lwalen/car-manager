class AddSettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :number_of_records, :integer
    add_column :users, :distance_unit, :string
    add_column :users, :volume_unit, :string
  end
end
