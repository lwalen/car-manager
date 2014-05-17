class AddCostToService < ActiveRecord::Migration
  def change
    add_column :services, :cost, :float
  end
end
