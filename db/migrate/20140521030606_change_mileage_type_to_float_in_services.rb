class ChangeMileageTypeToFloatInServices < ActiveRecord::Migration
  def change
    change_column :services, :mileage, :float
  end
end
