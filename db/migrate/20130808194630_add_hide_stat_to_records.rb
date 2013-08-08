class AddHideStatToRecords < ActiveRecord::Migration
  def change
		add_column :records, :stat, :boolean, null: false, :default => true
  end
end
