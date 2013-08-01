class AddMainColumnToCars < ActiveRecord::Migration
  def change
		add_column :cars, :main, :boolean, default: false, null: false
  end
end
