class AddColumnToCars < ActiveRecord::Migration
  def change
		add_column :cars, :mpg, :float
  end
end
