class ChangeMileageTypeToFloat < ActiveRecord::Migration
  def change
    change_column :records, :mileage, :float
  end
end
