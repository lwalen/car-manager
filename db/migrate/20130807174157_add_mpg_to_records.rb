class AddMpgToRecords < ActiveRecord::Migration
  def change
		add_column :records, :mpg, :float
  end
end
