class GiveServiceRecordsManyServiceTypes < ActiveRecord::Migration
  def change
		remove_column :records, :service_type_id, :integer

		create_table :records_service_types do |t|
			t.integer :service_record_id
			t.integer :service_type_id
			t.timestamps
		end
  end
end
