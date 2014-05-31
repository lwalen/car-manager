class CreateCommonRecords < ActiveRecord::Migration
  def change
    drop_table :records do
    end
    drop_table :services do
    end

    create_table :records do |t|
      t.integer :car_id, null: false
      t.string :type, null: false
      t.date :date
      t.float :mileage
      t.float :cost
      t.text :notes

      # gas
      t.float :volume
      t.float :rate
      t.boolean :stat, null: false, default: true

      # service
      t.integer :service_type_id

      t.timestamps
    end
  end
end
